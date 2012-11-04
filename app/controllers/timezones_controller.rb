class TimezonesController < ApplicationController
  def search
    @locations = Timezone::search params[:term]
    respond_to do |format|
        format.js { render :json => @locations.to_json }
    end
  end
end
