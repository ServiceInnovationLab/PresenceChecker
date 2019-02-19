# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show eligibility]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show; end



  private

  def requested_day
    params[:day]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id] || params[:client_id])
  end
end
