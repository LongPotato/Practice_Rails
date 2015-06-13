class FlightsController < ApplicationController

  def index
    if (params[:from] == params[:to]) && !params[:from].blank?
      flash.now[:danger] = "Depature and arrival airports can not be the same!"
    end
    @flights = Flight.search(params)
    @airports = Airport.pluck(:code, :id).sort
    @dates = Flight.get_dates
    @passengers = (1..4)
  end

end
