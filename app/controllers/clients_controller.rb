# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show eligibility]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show; end

  # URL to call this would look like /clients/:client_id/eligibility/:date.json
  # e.g. /clients/1/eligibility/2019-01-01.json
  def eligibility
    respond_to :json
    @eligibility = Eligibility.find_by(client: @client, day: requested_day)
    unless @eligibility
      Rails.logger.warn "Eligibility not pre-calculated for #{@client.id} on #{requested_day}"
      @eligibility = EligibilityService.new(@client, requested_day, 1).run!
    end
    render json: {
      requested_day => {
        'meetsMinimumPresence' => @eligibility.minimum_presence,
        # boolean (root)
        'meetsFiveYearPresence' => @eligibility.five_year_presence,
        # boolean (child of root | parent of present_days_by_rolling_year)
        'daysInNZ' => @eligibility.present_days_by_rolling_year,
        # hash of integers e.g. {'2019-06-07': 365.. } (child of five_year_presence)
        'eachYearPresence' => @eligibility.each_year_presence,
        # boolean (child of root | parent of mimimum_presence_by_rolling_year)
        'last5Years' => @eligibility.mimimum_presence_by_rolling_year
        # hash of booleans e.g. {'2019-06-07': true.. } (child of each_year_presence)
      }
    }
  end

  private

  def requested_day
    params[:day]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id] || params[:client_id])
  end
end
