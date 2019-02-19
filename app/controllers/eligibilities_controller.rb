class EligibilitiesController < ApplicationController
  def show
    @client = Client.find params[:client_id]
    @day = params[:day]
    @eligibility = @client.eligible_on_day(@day)
    
    respond_to do |format|
      format.html
      format.json do
        render json: {
          requested_day => {
            # boolean
            'meetsMinimumPresence' => @eligibility.minimum_presence,
            # boolean
            'meetsFiveYearPresence' => @eligibility.five_year_presence,
            # hash of booleans e.g. {'2019-06-07': true.. }
            'last5Years' => @eligibility.mimimum_presence_by_rolling_year,
            # hash of integers e.g. {'2019-06-07': 365.. }
            'daysInNZ' => @eligibility.present_days_by_rolling_year
          }
        }
      end
    end
  end
end
