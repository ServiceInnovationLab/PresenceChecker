# frozen_string_literal: true

# this is the home controller WIP

class HomeController < ApplicationController
  def index
    @client = Client.all
  end
end
