require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Orders" do
  get "/api/v1/event_dates" do 
    example "Listing event dates" do
      do_request(body: '')
      expect(status).to eq 200
    end
  end
end