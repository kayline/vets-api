# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alternate phone', type: :request do
  include SchemaMatchers

  let(:token) { 'fa0f28d6-224a-4015-a3b0-81e77de269f2' }
  let(:auth_header) { { 'Authorization' => "Token token=#{token}" } }
  let(:user) { build(:user, :loa3) }

  before do
    Session.create(uuid: user.uuid, token: token)
    User.create(user)
  end

  describe 'GET /v0/profile/alternate_phone' do
    context 'with a 200 response' do
      it 'should match the alternate phone schema' do
        VCR.use_cassette('evss/pciu/alternate_phone') do
          get '/v0/profile/alternate_phone', nil, auth_header

          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('phone_number_response')
        end
      end
    end

    context 'with a 400 response' do
      it 'should match the errors schema' do
        VCR.use_cassette('evss/pciu/alternate_phone_status_400') do
          get '/v0/profile/alternate_phone', nil, auth_header

          expect(response).to have_http_status(:bad_request)
          expect(response).to match_response_schema('errors')
        end
      end
    end

    context 'with a 403 response' do
      it 'should return a forbidden response' do
        VCR.use_cassette('evss/pciu/alternate_phone_status_403') do
          get '/v0/profile/alternate_phone', nil, auth_header

          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with a 500 response' do
      it 'should match the errors schema' do
        VCR.use_cassette('evss/pciu/alternate_phone_status_500') do
          get '/v0/profile/alternate_phone', nil, auth_header

          expect(response).to have_http_status(:bad_gateway)
          expect(response).to match_response_schema('errors')
        end
      end
    end
  end
end
