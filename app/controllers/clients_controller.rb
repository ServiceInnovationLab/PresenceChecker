# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show]

  def index
    @clients = Client.joins(:identity).where(serial_number: params[:serial_number])
  end

  def show
    @identities = @client.identities
    @movements = @client.movements
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end
end
