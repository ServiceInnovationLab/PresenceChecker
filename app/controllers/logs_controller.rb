class LogsController < ApplicationController
  def index
    @events = Ahoy::Event.all.page(params[:page]).per(30)
  end
end
