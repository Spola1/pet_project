class SearchTemperaturesController < ApplicationController
  before_action :set_search_temperature, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @search_temperature = SearchTemperature.new
  end

  def create
    response = Openweather::Search.by_location(search_temperature_params[:location])

    if response['cod'] == '400' || response['cod'] == '404'
      flash[:danger] = 'Invalid location'
      return redirect_to new_search_temperature_path
    end

    @search_temperature = SearchTemperature.create(temp: response['main']['temp'],
    location: search_temperature_params[:location], feels_like: response['main']['feels_like'])
   
    @search_temperature.save
      redirect_to search_temperature_path(@search_temperature)

  end

  private

  def set_search_temperature
    @search_temperature = SearchTemperature.find(params[:id])
  end

  def search_temperature_params
    params.require(:search_temperature).permit(:temp, :location, :feels_like)
  end
end
