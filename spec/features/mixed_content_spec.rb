require 'spec_helper'

describe 'Mixed Content Defense' do
  applicable_endpoints.each do |endpoint|
    context "#{base_url}#{endpoint.url}" do
      before(:each) do
        get endpoint.url
      end

      it 'body contains no mixed content or default-src CSP header is present' do
        request_protocol = base_url[0, base_url.index(':')]
        protocol_check = request_protocol == 'https' ? 'http' : 'https'
        protocol_check_regex = /\ssrc\s?=['"]#{protocol_check}:\/\/\S*['"]/
        expect({:body => body.scan(protocol_check_regex).empty?, :header => headers['content_security_policy'] == 'default-src https:;` *'})
          .to include(:body => true)
          .or include(:header => true)
      end
    end
  end
end
