class SignupsController < ApplicationController
  def index
    if params[:pass] == 'f7si8o7z6q'
      @signups = Signup.all
    end
  end

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)
    if @signup.save
      flash[:signup_success] = "Stuff"
    else 
      flash[:signup_failure] = "Stuff"
    end
    redirect_to '/'
  end


  private

  def signup_params
    params.require(:signup).permit(:email, :first_name, :last_name)
  end
end
