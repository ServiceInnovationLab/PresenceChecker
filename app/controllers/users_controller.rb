# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(:email)
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
