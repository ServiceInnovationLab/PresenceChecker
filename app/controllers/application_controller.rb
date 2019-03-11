# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  after_action :track_action

  protected

  def track_action
    ahoy.track "Ran actions", request.path_parameters
  end
end
