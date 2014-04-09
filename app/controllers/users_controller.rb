class UsersController < ApplicationController
  def new
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json }
    end
  end

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
    respond_to do |f|
        f.html {render :layout => false}
        f.json {render :json }
    end
  end
end
