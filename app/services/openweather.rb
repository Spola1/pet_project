module Openweather
  class Search
    def self.by_location(location)
      @parsed_response = 
        HTTParty.get('https://api.openweathermap.org/data/2.5/weather?q=' + location + '&appid=' + ENV['API_KEY'])
        .parsed_response
    end
  end
end