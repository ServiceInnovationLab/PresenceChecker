# frozen_string_literal: true

class IdentitiesController < ApplicationController
  def index
    @identities = Identity.all
  end
end
