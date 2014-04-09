class SessionsController < ApplicationController
  def new
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json }
    end
  end

  def create
  end

  def destroy
  end
end
