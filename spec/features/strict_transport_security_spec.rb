require 'spec_helper'

describe 'HTTP Strict Transport Security' do
  if URI(base_url).scheme == 'https'
    map_feature_to_targets do |endpoint|
      context "#{base_url}#{endpoint.url}" do
        before(:each) do
          get endpoint.url
        end

        it 'Strict-Transport-Security header is present' do
          expect(headers).to include('strict_transport_security')
        end
      end
    end
  end
end
