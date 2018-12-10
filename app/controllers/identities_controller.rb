# frozen_string_literal: true

class IdentitiesController < ApplicationController
  def index
    @identities = if params[:serial_number]
                    Identity.where(serial_number: params[:serial_number])
                  else
                    Identity.all.limit(100)
                  end

    redirect_to client_path(@identities.first.client) if @identities.count == 1
  end
end
