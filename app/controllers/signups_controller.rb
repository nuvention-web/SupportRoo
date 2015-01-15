class SignupsController < ApplicationController
  def index
    @signups = Signup.all
  end

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)
    @signup.save
    flash[:signup_success] = "Signup successful!"
    redirect_to '/'
  end


  private

  def signup_params
    params.require(:signup).permit(:email)
  end
end
