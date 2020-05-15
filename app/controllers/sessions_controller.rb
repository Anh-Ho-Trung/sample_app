class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        check_rememember user
        redirect_back_or user
      else
        push_message_account_not_activated
      end
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
    if params[:session][:remember_me] == Settings.remember_me
      remember(user)
    else
      forget(user)
    end
  end

  def push_message_account_not_activated
    message = t(".message1")
    message += t(".message2")
    flash[:warning] = message
    redirect_to root_url
  end
end
