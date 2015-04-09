class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.id != params[:id].to_i
      flash['notice'] = "You don't have access to this page."
      redirect_to root_path
    end

    boards = current_user.boards.includes(:supporters)
    @own_boards = boards.where(:supporters => {owner: true})
    @support_boards = boards.where(:supporters => {owner: nil})
  end
end
