module Openweather
  class Search
    def self.by_location(location)
      Faraday.get 'https://api.openweathermap.org/data/2.5/weather?q=' + location + '&appid=' + ENV['API_KEY']
    end
  end
end