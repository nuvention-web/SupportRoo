class TasksController < ApplicationController
  def create
    Task.create(task_params)
    redirect_to board_path(params[:task][:board_id])
  end

  def destroy
    task = Task.find(params[:id])
    id = task.board_id
    task.destroy
    redirect_to board_path(id)
  end

  def task_params
    params.require(:task).permit(
      :description,
      :board_id,
      :task_type_id
    )
  end
end
