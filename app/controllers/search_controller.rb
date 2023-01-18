class SearchController < ApplicationController
  def index
    if params['location']
      @response = Openweather::Search.by_location(params['location'])
      puts JSON.pretty_generate(@response)
    end
  end
end
