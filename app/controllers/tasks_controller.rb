class TasksController < ApplicationController
  def create
    Task.create( {
      description: params[:description],
      board_id: params[:board_id],
      task_type_id: params[:task_type_id]
    })

    redirect_to board_path(params[:board_id])
  end

  def destroy
    task = Task.find(params[:id])
    id = task.board_id
    task.destroy
    redirect_to board_path(id)
  end
end
