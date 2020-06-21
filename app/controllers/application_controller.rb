class ApplicationController < ActionController::Base
  before_action :ensure_logged_in
  before_action :role

  def ensure_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_owner_logged_in
    unless current_user.role.eql?("owner")
      redirect_to "/"
    end
  end

  def ensure_admin_logged_in
    unless current_user.role.eql?("clerk") or current_user.role.eql?("owner")
      redirect_to "/"
    end
  end

  def role
    @admin = false
    @clerk = false
    if @current_user.role.eql?("owner") or @current_user.role.eql?("clerk")
      @admin = true
      if @current_user.role.eql?("clerk")
        @clerk = true
      else
        @clerk = false
      end
    end
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    end
  end
end
