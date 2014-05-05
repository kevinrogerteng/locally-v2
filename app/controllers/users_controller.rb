class UsersController < ApplicationController

  def create
    binding.pry
    user = User.new(user_params)



    if user.save
      render :json => { 
        :success => "Welcome!",
        :user => user
      }
    end

  end

  def show

    user = User.find(params[:id])
    render :json => user.as_json(:except=> [:user_id, :password_digest]) 
  end

  def update

    user = User.find(params[:id])
    user.update_attributes(user_params)
    render :json => { 
      :success => "Account Updated",
      :updates => user
    }

  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      render :json => { :success => "Account deleted"}
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :screen_name, :password, :password_confirmation, :hometown)
  end

end
