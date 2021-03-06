class SessionsController < ApplicationController
  skip_before_action :ensure_logged_in
  skip_before_action :role

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to "/menu"
    else
      flash[:error] = "Your login attempt was invalid"
      redirect_to "/signin"
    end
  end

  def show
    @user = current_user
    if @user
      if @user.role.eql?("owner")
        render "show"
      else
        redirect_to "/menu"
      end
    else
      redirect_to "/"
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user_id = nil
    redirect_to "/"
  end
end
