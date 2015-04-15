class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: 'You must be signed in to view Profiles'
    end
  end

  def user
    @_user = User.find(params[:user_id] ? params[:user_id] : params[:id])
  end

  def correct_user
    redirect_to(root_url) unless user == current_user
  end
end
