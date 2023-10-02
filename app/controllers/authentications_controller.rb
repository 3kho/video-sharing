class AuthenticationsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])

    if @user.blank?
      # create user with provided credential
      @user = User.new(email: params[:email], password: params[:password])

      if @user.save
        flash[:success] = "Account created"
        sign_in @user
        redirect_to root_path
      else
        @flash_errors = @user.errors.full_messages
        flash[:danger] = @user.errors.full_messages.join(', ')

        redirect_to root_path
      end
    else
      if @user.valid_password?(params[:password])
        sign_in @user
        flash[:success] = "Signed in"
        redirect_to root_path
      else
        flash[:danger] = "Wrong password"

        redirect_to root_path
      end
    end
  end

  def destroy
    sign_out current_user
    flash[:success] = "Signed out"

    redirect_to root_path
  end
end
