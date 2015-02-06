class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    @task_types = TaskType.all
    @tasks = @board.tasks
  end

  def share
    @board = Board.find(params[:id])
    @tasks = @board.tasks
  end
end
