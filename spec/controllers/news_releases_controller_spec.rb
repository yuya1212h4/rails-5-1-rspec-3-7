require 'rails_helper'

describe NewsReleasesController do
  describe "GET #new" do
    # ログインを要求すること
    it "requires login" do
      get :new
      expect(response).to require_login
    end
  end

  describe "POST #create" do
    # ログインを要求すること
    it "requires login" do
      post :create, params: { news_release: attributes_for(:news_release) }
      expect(response).to require_login
    end
  end
end
