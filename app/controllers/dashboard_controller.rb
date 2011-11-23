class DashboardController < ApplicationController
  def index
    @sliders = [
      Slider.new(
        :name => "KM",
        :location => "+1"
      ),
      Slider.new(
        :name => "GKs",
        :location => "+9,5"
      )
    ]
  end
end
