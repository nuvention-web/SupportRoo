class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    @task_types = TaskType.all
    @tasks = @board.tasks
  end
end
