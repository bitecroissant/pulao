require 'rails_helper'

RSpec.describe "EventDates", type: :request do
  describe "GET /event_dates" do
    it "works! (now write some real specs)" do
      11.times { EventDate.create name: 'xyxzyzexe' }
      expect(EventDate.count).to eq(11)
      get '/api/v1/event_dates'
      expect(response).to have_http_status(200)
      res = JSON.parse(response.body)
      expect(res['resources'].size).to eq(10)

      get '/api/v1/event_dates?page=2'
      expect(response).to have_http_status(200)
      res = JSON.parse(response.body)
      expect(res['resources'].size).to eq(1)
    end
  end

  describe "create" do
    it "can create an event_date" do
      expect{
        post '/api/v1/event_dates', params: { name: 'abc' }
      }.to change{EventDate.count}.by(+1)
      expect(response).to have_http_status(200)
      res = JSON.parse(response.body)
      expect(res['resource']['id']).to be_an Numeric
      expect(res['resource']['name']).to eq 'abc'
    end
  end
end
