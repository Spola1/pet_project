module Openweather
  class Search
    def self.by_location(location)
      begin
        @parsed_response = 
        HTTParty.get('https://api.openweathermap.org/data/2.5/weather?q=' + location + '&appid=' + ENV['API_KEY'])
      rescue URI::InvalidURIError
        @parsed_response = 
        HTTParty.get('https://api.openweathermap.org/data/2.5/weather?q=' + CGI.escape(location) + '&appid=' + ENV['API_KEY'])
      end
    end
  end
end