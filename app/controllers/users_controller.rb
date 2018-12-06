# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(:email)
  end

  def edit; end

  def update
    if params[:activate].present?
      @user.restore
      redirect_to edit_user_url(@user), notice: 'User was re-actived.'
    else
      if @user.update(user_params)
        redirect_to users_url, notice: 'User was updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    u = params.require(:user).permit(:council_id, role_ids: [])
    u[:council_id] = nil if u[:council_id].blank?
    u[:role_ids] = [] if u[:role_ids].blank?
    u
  end
end
