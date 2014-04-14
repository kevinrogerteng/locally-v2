class MainsController < ApplicationController
  def index
    respond_to do |f|
        f.html  {render :layout => false }
        f.json {render :json }
    end
  end
end
