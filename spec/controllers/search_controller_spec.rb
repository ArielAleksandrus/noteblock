require 'rails_helper'

RSpec.describe SearchController, type: :controller do
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

  describe "GET #common" do
    it "returns http success" do
      get :common, query: @user.notes.first.title
      expect(response).to have_http_status(:success)
    end
    it "returns results from elasticsearch" do
      get :common, query: @user.notes.first.title
      expect(assigns(:notes).count).to be >= 1
    end
  end

  describe "GET #user_notes" do
    it "returns no results for another user's private notes" do
      note2 = FactoryGirl.create(:note)
      user2 = note2.user
      note2.update(privacy: "private")
      get :user_notes, query: note2.content
      expect(assigns(:notes).count).to be == 0
    end
  end

end
