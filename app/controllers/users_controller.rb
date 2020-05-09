class UsersController < ApplicationController
  skip_before_action :ensure_logged_in

  def new
    render "new"
  end

  def create
    new_user = User.new(first_name: params[:first_name],
                        last_name: params[:last_name],
                        role: params[:role],
                        email: params[:email],
                        password: params[:password])
    if new_user.save
      session[:current_user_id] = new_user.id
      redirect_to "/users/#{new_user.id}"
    else
      flash[:error] = new_user.errors.full_messages.join(",")
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_user
    if @user
      render "edit"
    else
      redirect_to "/"
    end
  end

  def show
    @user = current_user
    if @user
      render "show"
    else
      redirect_to "/"
    end
  end

  def update
    user = User.find(params[:id])
    user.first_name = params[:first_name]
    if params[:password]
      user.password = params[:password]
    end
    if user.save
      user.save!
      redirect_to "/users/#{params[:id]}"
    else
      flash[:error] = "User name can't be blank"
      redirect_to edit_user_path(id: params[:id])
    end
  end
end
