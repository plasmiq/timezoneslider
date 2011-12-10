class TimezonesController < ApplicationController
  def search
    @locations = Timezone.search params[:term]
    respond_to do |format|
        format.html
        format.js
    end
  end
end
