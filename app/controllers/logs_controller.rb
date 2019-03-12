class LogsController < ApplicationController
  def index
    @events = Ahoy::Event.all
  end
end
