class BoardsController < ApplicationController
  def index
    if params[:pass] == 'f7si8o7z6q'
      @boards = Board.all
    end
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      Supporter.create({ user_id: current_user.id,
                         board_id: @board.id,
                         owner: true })
      flash[:board_success]
      redirect_to board_path(@board)
    else
      flash[:board_failure]
      redirect_to root_path
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

    if not @board.owned_by(current_user)
      flash[:warning] = "You are not authorized to see that page"
      redirect_to root_path
    end

    @task_categories = TaskType.all.pluck(:category).uniq
    @task_types = TaskType.all
    @tasks = @board.tasks
  end

  def share
    @board = Board.find(params[:id])
    @tasks = @board.tasks
  end

  private

  def board_params
    params.require(:board).permit(:email, :name, :description)
  end

end
