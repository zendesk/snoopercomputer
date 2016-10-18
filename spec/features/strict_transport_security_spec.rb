require 'airborne'
require 'spec_helper'

describe 'HTTP Strict Transport Security' do
  if URI(base_url).scheme == 'https'
    map_feature_to_targets do |url|
      context "#{base_url}#{url}" do
        before(:each) do
          get url
        end

        it 'Strict-Transport-Security header is present' do
          expect(headers).to include('strict_transport_security')
        end
      end
    end
  end
end
