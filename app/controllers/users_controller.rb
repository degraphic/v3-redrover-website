class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:login, :oauth_callback]
  def login
    redirect_to "http://staging-api.redroverapp.com/api/v3/oauth2/authenticate?client_id=6FN7A39JKGRW14ANVZCHYFM6Y&redirect_uri=http://staging-redroverapp.herokuapp.com/users/oauth_callback"
  end

  def oauth_callback
    user_attributes = JSON.parse(params[:user_as_json])

    @user = User.where(email: user_attributes["email"]).where(authentication_token: user_attributes["authentication_token"]).first
    if @user
      sign_in(@user)
    else
      criteria = User.where(email: user_attributes["email"])
      @user = criteria.first
      if @user
        if @user.authentication_token == user_attributes["authentication_token"]
          criteria.update(authentication_token: user_attributes["new_authentication_token"])
          sign_in(@user)
        end
      else
        @user = User.new(user_attributes)
        @user.assign_temp_password!
        if @user.save
          sign_in(@user)
        end
      end
    end
    respond_to do |format|
      format.html{ redirect_to root_path }
    end
  end
end