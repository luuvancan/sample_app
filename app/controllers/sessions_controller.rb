class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      condition_true
    else
      condition_false
    end
  end

  def condition_true
    user = User.find_by(email: params[:session][:email].downcase)
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to user
  end

  def condition_false
    flash.now[:danger] = "Invalid email/password combination"
    render "new"
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
