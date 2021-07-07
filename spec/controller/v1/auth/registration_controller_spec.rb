require 'rails_helper'

RSpec.describe V1::Auth::RegistrationController, type: :request do
  describe "POST #create" do
    let(:user_attrs) { attributes_for(:user) }
    let(:params) do
      {
        data: {
          attributes: user_attrs
        }
      }
    end
    subject(:do_request) { post "/v1/auth/registration", params: params }

    before { do_request }

    context "when is successfully created" do
      it { expect(response).to have_http_status(:created) }

      it { expect(json_body_data).to have_attribute(:email).with_value(user_attrs[:email]) }
    end

    context "when is not created" do
      let(:user_attrs) { attributes_for(:user, email: nil) }

      it "renders an errors json" do
        expect(json_body).to have_key("errors")
      end

      it "renders the json errors on why the user could not be created" do
        expect(json_body["errors"]["email"]).to include "can't be blank"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
