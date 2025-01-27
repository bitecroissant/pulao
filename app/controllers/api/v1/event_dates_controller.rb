class Api::V1::EventDatesController < ApplicationController

  def index
		event_dates = EventDate.page(params[:page]).per(10)
		render json: { resources: event_dates, pager: {
      page: params[:page] || 1,
      per_page: event_dates.size(),
      count: EventDate.count()
    } }
  end

    def create
      event_date = EventDate.new name: params[:name]
      if event_date.save
        render json: { resource: event_date }
      else
        render errors: { errors: event_date.errors }
      end
    end
end
