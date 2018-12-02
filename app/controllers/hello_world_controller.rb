# frozen_string_literal: true

class HelloWorldController < ApplicationController
  layout 'hello_world'
  before_action :authenticate_user!
  def index
    # @hello_world_props = { name: 'Stranger' }
    # @clients = Client.all
    # # @search = Client.search(params[:search])
    @results = Client.all
    if params[:search]
      @results = Client.search(params[:search]).order("created_at DESC")
    else
      @results = Client.all.order('created_at DESC')
    end
  end
end
