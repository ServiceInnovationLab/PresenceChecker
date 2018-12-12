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

  # URL to call this would look like /clients/:client_id/eligibility/:date.json
  # e.g. /clients/1/eligibility/2019-01-01.json
  def eligibility
    respond_to :json

    @service = EligibilityService.new(@client, requested_date)
    @service.run!

    render json: {
      requested_date => {
        'meetsMinimumPresence' => @service.meets_minimum_presence_requirements[requested_date],
        'last5Years' => @service.enough_days_by_rolling_year.values,
        'daysInNZ' => @service.days_by_rolling_year.values
      }
    }
  end

  private

  def requested_date
    params[:day] || Date.today.strftime('%Y-%m-%d')
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id] || params[:client_id])
  end
end
