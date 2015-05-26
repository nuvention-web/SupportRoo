class TasksController < ApplicationController
  def create
    task = Task.create(params_with_datetimes(task_params))
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
    current_user.accept_task(task, task_params[:supporter_message])

    UserMailer.notify_supporter(task).deliver_now
    UserMailer.notify_board_owners(task).deliver_now

    flash[:notice] = "Thanks for signing up for the task!"
    redirect_to share_board_path(task.board_id)
  end

  def complete
    task = Task.find(params[:id])
    task.complete!
    redirect_to share_board_path(task.board_id)
    flash[:notice] = "Task has been marked as complete!"
    UserMailer.notify_owners_of_completion(task).deliver_now
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

    if @task.accepted?
      UserMailer.notify_supporter_of_edit(@task).deliver!
    end
  end

  def pin
    task = Task.find(params[:id])

    if task.pinned?
      task.unpin!
    else
      task.pin!
    end

    redirect_to task.board
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
      :start_date,
      :end_time,
      :pinned,
      :completed,
      :completion_check,
      :completion_check_time
    )
  end

  def create_date_time(date, time)
    DateTime.strptime("#{date} #{time}", "%m/%d/%Y %l:%M%p")
  end

  def params_with_datetimes(prms)
    prms[:start_time] = create_date_time(prms[:start_date], prms[:start_time])
    prms.delete(:start_date)
    if params[:completion_check]
      prms[:completion_check_time] = create_date_time(prms[:completion_check_date], prms[:completion_check_time])
      prms.delete(:completion_check_date)
    end
    prms
  end
end
