class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credential(user_params)

    if @user
      login!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = "Wrong username or password!"
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:name,:password)
  end
end
