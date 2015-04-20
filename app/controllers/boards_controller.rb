class BoardsController < ApplicationController
  def index
    if params[:pass] == 'f7si8o7z6q'
      @boards = Board.all
    end
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      @board.add_owner(current_user)
      flash[:notice] = "Board created successfully!"
      redirect_to board_path(@board)
    else
      flash[:error] = "There were errors creating your board"
      redirect_to new_board_path
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    flash[:notice] = "Board deleted"
    redirect_to user_path(current_user)
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])

    if not @board.owned_by?(current_user)
      flash[:warning] = "You are not authorized to see that page"
      redirect_to root_path
    end

    @task_categories = TaskType.all.pluck(:category).uniq
    @task_types = TaskType.all
    @tasks = @board.tasks
  end

  def share
    @board = Board.find(params[:id])
    if !user_signed_in?
      flash[:warning] = "You must be signed in to view that page"
      redirect_to root_path
    elsif (@board.owned_by?(current_user))
      redirect_to board_path(@board)
    elsif !current_user.supporter_for(@board)
      flash[:warning] = "You do not have access to that page"
      redirect_to user_path(current_user)
    else
      @unaccepted_tasks = @board.unaccepted_tasks
      @user_tasks = current_user.tasks_from_board(@board)
    end
  end

  private

  def board_params
    params.require(:board).permit(:email, :name, :description)
  end
end
