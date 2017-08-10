require 'spec_helper'

describe 'XSS Prevention' do
  applicable_endpoints.each do |endpoint|
    context "#{base_url}#{endpoint.url}" do
      before (:each) do
        get endpoint.url
      end

      it 'returns an X-XSS-Protection header with a valid value' do
        expect(headers).to include('x_xss_protection' => '1')
      end
    end
  end
end
