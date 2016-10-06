class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      log_in_user!(user)
      redirect_to bands_url
    else
      flash.now[:errors] = ["Incorrect username or password."]
      render :new
    end
  end

  def destroy
    user = current_user
    logout(user)

    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
