class SlidersController < InheritedResources::Base
  actions :all, :except => [:edit, :new]
  respond_to :html, :only => :index
  respond_to :json

  def index
    index! do |format|
      format.html do
        render 'index'
      end
    end
  end

  def update(options={}, &block)
    update! do |format|
      format.json do
        object = resource
        update_resource(object, resource_params)
        render :json => object
      end
    end
  end

  protected

  def resource_params
    [request.request_parameters]
  end

end
