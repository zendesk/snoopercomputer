require 'spec_helper'

describe 'Clickjacking Defense' do
  applicable_endpoints.each do |endpoint|
    context "#{base_url}#{endpoint.url}" do
      before (:each) do
        get endpoint.url
      end

      it 'returns any of the Clickjacking Defense headers' do
        expect(headers).to include('x_frame_options' => 'SAMEORIGIN')
          .or include('x_frame_options' => 'DENY')
          .or include('content_security_policy' => "frame-ancestors 'none' *")
          .or include('content_security_policy' => "frame-ancestors 'self' *")
          .or include('content_security_policy' => "frame-ancestors #{URI(base_url).host} *")
      end
    end
  end
end
