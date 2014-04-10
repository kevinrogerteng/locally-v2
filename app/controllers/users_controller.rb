class UsersController < ApplicationController

  def create
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json }
    end
  end

  def edit
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json }
    end
  end

  def show

    user = User.find(params[:id])
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json => user.as_json(:except=> [:user_id, :password_digest]) }
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render :json => { :success => "Account deleted"}
    end

  end
end
