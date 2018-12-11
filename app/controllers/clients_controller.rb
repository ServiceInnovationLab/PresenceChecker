# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show eligibility]
  before_action :create_eligibility_service, only: %i[show eligibility]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show
    @identities = @client.identities
    @movements = @client.movements
  end

  def eligibility
    respond_to :json

    # URL to call this would look like /clients/eligibility?id=1&date="2019-01-01"
    @eligibility_service.to_json
  end

  private

  def create_eligibility_service
    @eligibility_service = EligibilityService.new(@client, params[:date] || now_in_date_format)
    @eligibility_service.run!
  end

  def date_format
    '%Y-%m-%d'
  end

  def now_in_date_format
    Time.zone.now.strftime(date_format)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end
end
