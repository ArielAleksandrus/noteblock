require 'rails_helper'

RSpec.describe NotesController, type: :controller do
	include Devise::Test::ControllerHelpers

	before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:user]
		if @user.nil?
			@user = FactoryGirl.create(:user)
			sign_in @user
			notes = FactoryGirl.attributes_for_list(:note, 10)
			notes.each do |note|
				note[:user] = @user
				Note.create!(note)
			end
		end
	end
	describe "GET index" do
		it "assigns @notes" do
			get :index
			expect(assigns(:notes)).to eq(@user.notes)
		end
	end
	describe "GET show" do
		it "shows self notes" do
			get :show, id: @user.notes.first.id.to_s
      expect(response).to have_http_status(:success)
		end
		it "shows public notes" do
			n = FactoryGirl.create(:note)
			n.update(privacy: "public")

			get :show, id: n.id.to_s
      expect(response).to have_http_status(:success)
		end
		it "returns unauthorized for private notes of others" do
			n = FactoryGirl.create(:note)
			n.update(privacy: "private")

			get :show, id: n.id.to_s
      expect(response).to have_http_status(:unauthorized)
		end
	end
end
