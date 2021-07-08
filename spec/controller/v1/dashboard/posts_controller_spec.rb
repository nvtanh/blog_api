require 'rails_helper'

RSpec.describe V1::Dashboard::PostsController, type: :request do
  describe 'GET /v1/dashboard/posts/:id' do
    let!(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    subject(:do_request) do
      get "/v1/dashboard/posts/#{post.id}", headers: headers
    end

    context 'unauthorized access' do
      let(:headers) { anonymous_header }

      before { do_request }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'logged in as a User' do
      let(:headers) do
        user_header(user_id: user.id, email: user.email)
      end

      before { do_request }

      context 'The user is owner of this post' do
        it 'returns post detail' do
          expect(json_body_data).to have_attribute(:title).with_value(post.title)
          expect(json_body_data).to have_attribute(:description).with_value(post.description)
          expect(json_body_data).to have_attribute(:content).with_value(post.content)
          expect(json_body_attributes).to have_key('comments')
        end
      end

      context 'The user is NOT owner of this post' do
        let(:other_user) { create(:user) }
        let(:post) { create(:post, user: other_user) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end
  end

  describe 'POST /v1/dashboard/posts' do
    let!(:user) { create(:user) }
    let(:post_attrs) { attributes_for(:post) }
    let(:params) do
      {
        data: {
          attributes: post_attrs
        }
      }
    end

    subject(:do_request) do
      post "/v1/dashboard/posts", params: params, headers: headers
    end

    context 'unauthorized access' do
      let(:headers) { anonymous_header }

      before { do_request }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'logged in as a User' do
      let(:headers) do
        user_header(user_id: user.id, email: user.email)
      end

      before { do_request }

      context 'params is valid' do
        it { expect(response).to have_http_status(:ok) }

        it 'Total of posts increase 1 record' do
          expect(user.posts.count).to eq 1
        end

        it 'returns post detail' do
          expect(json_body_data).to have_attribute(:title).with_value(post_attrs[:title])
          expect(json_body_data).to have_attribute(:description).with_value(post_attrs[:description])
          expect(json_body_data).to have_attribute(:content).with_value(post_attrs[:content])
          expect(json_body_data).to have_attribute(:user_email).with_value(user.email)
        end
      end

      context 'params is invalid' do
        let(:post_attrs) { attributes_for(:post, title: "") }
        it { expect(response).to have_http_status(:unprocessable_entity) }

        it 'Total of posts not change' do
          expect(user.posts.count).to eq 0
        end
      end
    end
  end

  describe 'PATCH /v1/dashboard/posts' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let(:update_post_attrs) { attributes_for(:post) }
    let(:params) do
      {
        data: {
          attributes: update_post_attrs
        }
      }
    end

    subject(:do_request) do
      patch "/v1/dashboard/posts/#{post.id}", params: params, headers: headers
    end

    context 'unauthorized access' do
      let(:headers) { anonymous_header }

      before { do_request }

      it { expect(response).to have_http_status(:unauthorized) }
    end

    context 'logged in as a User' do
      let(:headers) do
        user_header(user_id: user.id, email: user.email)
      end

      before { do_request }

      context 'params is valid' do
        it { expect(response).to have_http_status(:ok) }

        it 'returns post detail changed' do
          expect(json_body_data).to have_attribute(:title).with_value(update_post_attrs[:title])
          expect(json_body_data).to have_attribute(:description).with_value(update_post_attrs[:description])
          expect(json_body_data).to have_attribute(:content).with_value(update_post_attrs[:content])
        end
      end

      context 'params is invalid' do
        let(:update_post_attrs) { attributes_for(:post, title: FFaker::Lorem.characters(300)) }

        it { expect(response).to have_http_status(:unprocessable_entity) }
      end

      context 'The user is NOT owner of this post' do
        let(:other_user) { create(:user) }
        let(:post) { create(:post, user: other_user) }

        it { expect(response).to have_http_status(:not_found) }
      end
    end
  end
end
