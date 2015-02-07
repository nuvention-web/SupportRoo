class BoardsController < ApplicationController
  def index
    if params[:pass] == 'f7si8o7z6q'
      @boards = Board.all
    end
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:board_success]
      redirect_to board_path(@board)
    else 
      flash[:board_failure]
      redirect_to '/'
    end
    
  end

  def new
    @board = Board.new
  end

  def show
    @board = Board.find(params[:id])
    @task_types = TaskType.all
    @tasks = @board.tasks
  end

  def share
    @board = Board.find(params[:id])
    @tasks = @board.tasks
  end

  private

  def board_params
    params.require(:board).permit(:email, :first_name, :last_name)
  end

end