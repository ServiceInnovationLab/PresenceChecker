class IdentitiesController < ApplicationController
  before_action :set_identity, only: [:show, :edit, :update, :destroy]

  # GET /identities
  # GET /identities.json
  def index
    @identities = Identity.all
  end

  # GET /identities/1
  # GET /identities/1.json
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_identity
      @identity = Identity.find(params[:id])
    end
end
