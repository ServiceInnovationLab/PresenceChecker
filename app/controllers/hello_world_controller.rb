# frozen_string_literal: true

class HelloWorldController < ApplicationController
  layout 'hello_world'
  before_action :authenticate_user!
  def index
    @hello_world_props = { name: 'Stranger' }
    @clients = Client.all
    # @search = Client.search(params[:search])

  end
end
