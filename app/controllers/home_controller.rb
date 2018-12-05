# frozen_string_literal: true

# this is the home controller WIP

class HomeController < ApplicationController
  def index

    @client = Client.where(passport_no: params[:search])
    @identities = Identity.where(client_id: @client)
    if Movement.count > 0
      @movements = Movement.where(client_id: @client)
    end
  end
end
