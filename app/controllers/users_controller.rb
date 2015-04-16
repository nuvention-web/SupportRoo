class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.id != params[:id].to_i
      flash['notice'] = "You don't have access to this page."
      redirect_to root_path
    end

    boards = current_user.boards.includes(:supporters)
    @own_boards = current_user.owned_boards
    @support_boards = boards.where(:supporters => { owner: false } )
  end
end
