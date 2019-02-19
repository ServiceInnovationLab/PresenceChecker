# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show eligibility]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show
    date_format = '%Y-%m-%d'
    
    @movements = []
    @client.movements.order(:carrier_date_time).each do |m|
      @movements << [
          m.direction == 'arrival' ? 'present' : 'absent',
          m.carrier_date_time.strftime(date_format),
          m.presence_status_end&.strftime(date_format) || Date.new.strftime(date_format)
        ]
    end
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
