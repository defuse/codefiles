class UserController < ApplicationController
  skip_before_filter :authorize

  def login
    @username = ""
  end

  def authenticate
    user = User.find_by_name( params[:name].downcase )
    if user && user.authenticate( params[:password] )
      reset_session
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Invalid username or password."
      @username = params[:name]
      render :login
    end
  end

  def logout
    reset_session
    session[:user] = nil
    redirect_to root_url
  end

  def adminhome
    if session[:user_id].nil?
      redirect_to root_url
      return
    end
  end

  def settings
    user = User.find( session[:user_id] )

    unless user
      redirect_to :action => "login"
      return
    end
  end

  def save_settings
    user = User.find( session[:user_id] )

    unless user
      redirect_to :action => "login"
      return
    end

    if user.authenticate( params[:old] )
      if params[:new] == params[:new_confirm]
        user.password = params[:new]
        if user.save
          flash[:error] = "Password changed."
        else
          flash[:error] = "Could not change password."
        end
      else
        flash[:error] = "Passwords do not match."
      end
    else
      flash[:error] = "Old password is incorrect."
    end

    redirect_to :action => "settings"
  end

end
