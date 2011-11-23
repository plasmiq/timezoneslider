class Slider
  attr :name, :timezone
  
  def initialize params
    @name = params[:name] || ""
    @timezone = params[:timezone] || ""
  end 
end
