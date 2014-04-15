class SessionsController < ApplicationController

  def create

    user=User.find_by_email(params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      render :json => {
        :success => user.as_json(except: [:password_digest, :remember_token, :created_at, :updated_at])}
    else
      render :json => {:error => 'invalid email or password'}
    end

  end

  def destroy

    sign_out

    render :json => {:success => "Successfully Signed Out"}

  end

end
