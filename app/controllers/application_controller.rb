class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_filter :authenticate_user!, except: [:index, :show]
  

  before_filter :set_counts
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end 

  private
  
  def set_counts
    if user_signed_in?
      @count_artists = current_user.artists.count
      @count_favorites = Content.favorites(current_user).count
    else
      @count_artists = ""
      @count_favorites = ""
    end 
  end


end
