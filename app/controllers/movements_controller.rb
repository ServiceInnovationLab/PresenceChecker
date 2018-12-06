# frozen_string_literal: true

class MovementsController < ApplicationController
  before_action :set_movement, only: %i[show edit update destroy]

  # GET /movements
  # GET /movements.json
  def index
    @movements = Movement.all
  end

  # GET /movements/1
  # GET /movements/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_movement
    @movement = Movement.find(params[:id])
  end
end
