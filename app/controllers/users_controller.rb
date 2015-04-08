class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    boards = current_user.boards.includes(:supporters)
    @own_boards = boards.where(:supporters => {owner: true})
    @support_boards = boards.where(:supporters => {owner: nil})
  end
end
