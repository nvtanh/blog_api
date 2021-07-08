require 'rails_helper'

RSpec.describe V1::Dashboard::HomeController, type: :request do
  describe 'GET /v1/dashboard/home' do
    let(:filter_params) { {} }
    let(:pagination_params) { {} }
    let(:params) { { filter: filter_params, page: pagination_params } }

    subject(:do_request) do
      get "/v1/dashboard/home", params: params, headers: headers
    end

    context 'unauthorized access' do
      let(:headers) { anonymous_header }

      before { do_request }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'logged in as a User' do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      let!(:posts) do
        10.times do |i|
          create(:post, user: user, title: "title_#{i}")
        end
      end
      let!(:other_post) { create(:post, user: other_user)}

      let(:headers) do
        user_header(user_id: user.id, email: user.email)
      end

      before { do_request }

      context 'no search/filter' do
        it 'returns all posts of current user' do
          expect(json_body_data.size).to eq 10
          expect(json_body['meta']).to have_key('page_count')
          expect(json_body['meta']).to have_key('record_count')
        end
      end

      context 'filter by title' do
        context 'match a part' do
          let(:filter_params) { { title: 'title' } }

          it 'returns filtered posts' do
            expect(json_body_data.size).to eq 10
          end
        end

        context 'match all' do
          let(:filter_params) { { title: 'title_1' } }

          it 'returns filtered posts' do
            expect(json_body_data.size).to eq 1
          end
        end
      end
    end
  end
end
