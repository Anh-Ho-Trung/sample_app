class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password])
      log_in user
      check_rememember user
      redirect_back_or user
    else
      flash.now[:danger] = t ".message_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def check_rememember user
    params[:session][:remember_me] == Settings.remember_me ? remember(user) : forget(user)
  end
end
