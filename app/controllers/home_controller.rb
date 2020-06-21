class HomeController < ApplicationController
  skip_before_action :ensure_logged_in
  skip_before_action :role

  def index
    if current_user
      redirect_to "/menu"
    else
      render "index"
    end
  end
end
