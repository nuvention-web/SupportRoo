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

  def accept
    task = Task.find(params[:id])
    task.update_attributes(task_params)
    UserMailer.notify_supporter(task).deliver!
    UserMailer.notify_caretaker(task).deliver!
    redirect_to share_board_path(task.board_id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    redirect_to board_path(@task.board)
  end

  private

  def task_params
    params.require(:task).permit(
      :description,
      :board_id,
      :task_type_id,
      :title,
      :supporter_email,
      :supporter_message,
      :supporter_name,
      :start_time,
      :end_time
    )
  end
end
