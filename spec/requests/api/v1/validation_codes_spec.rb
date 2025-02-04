require 'rails_helper'

RSpec.describe "Api::V1::ValidationCodes", type: :request do
  describe "验证码" do

    it "可以被发送" do
      post '/api/v1/validation_codes', params: { email: 'xxxxyyy@xxx.cc' }
      expect(response).to have_http_status(200)
    end

  end
end
