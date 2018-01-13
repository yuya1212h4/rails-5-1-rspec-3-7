require "rails_helper"

describe ContactsController do
  let(:admin) { build_stubbed(:admin) }
  let(:user) { build_stubbed(:user) }

  let(:contact) do
    create(:contact, firstname: 'Lawrence', lastname: 'Smith')
  end

  let(:phones) do
    [
      attributes_for(:phone, phone_type: "home"),
      attributes_for(:phone, phone_type: "office"),
      attributes_for(:phone, phone_type: "mobile")
    ]
  end

  let(:valid_attributes) { attributes_for(:contact) }
  let(:invalid_attributes) { attributes_for(:invalid_contact) }


  describe "administrator access" do
    before :each do
      set_user_session create(:admin)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end

  describe "user access" do
    before :each do
      set_user_session create(:user)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end

  describe "guest access" do
    it_behaves_like 'public access to contacts'

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        contact = create(:contact)
        get :edit, params: { id: contact }
        expect(response).to require_login
      end
    end

    describe "POST #create" do
      it "requires login" do
        post :create, params: { id: create(:contact),
          contact: attributes_for(:contact) }
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it "requires login" do
        put :update, params: { id: create(:contact),
          contact: attributes_for(:contact) }
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, params: { id: create(:contact) }
        expect(response).to require_login
      end
    end
  end
end
