# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show eligibility]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show
    @identities = @client.identities
    @movements = @client.movements
  end

  def eligibility
    respond_to :json

    @service = EligibilityService.new(Client.find(params[:id]), params[:date] || Date.now)
    @service.run!

    # URL to call this would look like /clients/eligibility?id=1&date="2019-01-01"
    @service.to_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end
end
