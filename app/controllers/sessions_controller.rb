class SessionsController < ApplicationController
  before_action :redirect_to_cats_path, if: :logged_in?, only: :login

  def login
  end

  def create
    user = Admin.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cats_path
    else
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def redirect_to_cats_path
    redirect_to cats_path
  end
end
