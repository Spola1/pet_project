class WeatherController < ApplicationController
  def index
    if params['location']
      @response = Openweather::Search.by_location(params['location'])
    end
  end
end
