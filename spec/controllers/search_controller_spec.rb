require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #common" do
    it "returns http success" do
      get :common
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #user_notes" do
    it "returns http success" do
      get :user_notes
      expect(response).to have_http_status(:success)
    end
  end

end
