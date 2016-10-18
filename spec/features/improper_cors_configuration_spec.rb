require 'airborne'
require 'spec_helper'

describe 'Improper CORS Configuration Headers' do
  map_feature_to_targets do |url|
    context "#{base_url}#{url}" do
      before(:each) do
        get url
      end

      it 'returns the Access-Control-Allow_Origin header' do
        expect(headers).to include('access_control_allow_origin')
      end

      it 'returns * for the Access-Control-Allow_Origin header' do
        expect(headers['access_control_allow_origin']).to eq('*')
      end

      it 'returns the Access-Control-Allow_Credentials header' do
        expect(headers).to include('access_control_allow_credentials')
      end

      it 'returns true for the correct Access-Control-Allow_Credentials header' do
        expect(headers['access_control_allow_credentials']).to eq(true)
      end
    end
  end
end
