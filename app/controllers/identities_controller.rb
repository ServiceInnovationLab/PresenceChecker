# frozen_string_literal: true

class IdentitiesController < ApplicationController
  def index
    if params[:serial_number]
      @identities = Identity.where(serial_number: params[:serial_number])
    else
      @identities = Identity.all.limit(100)
    end
  end
end
