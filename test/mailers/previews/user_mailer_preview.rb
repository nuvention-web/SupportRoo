class UserMailerPreview < ActionMailer::Preview

  def notify_supporter
    user = User.last
    task = Task.last
    task.supporter_message = "a message"
    user.accept_task(task)
    UserMailer.notify_supporter(task)
  end

  def notify_board_owners
    user = User.last
    task = Task.last
    task.supporter_message = "a message"
    user.accept_task(task)
    UserMailer.notify_board_owners(task)
  end

  def notify_owners_of_completion
    user = User.last
    task = Task.last
    task.supporter_message = "a message"
    user.accept_task(task)
    task.complete!
    UserMailer.notify_owners_of_completion(task)
  end

  def notify_supporter_of_edit
    user = User.last
    task = Task.last
    task.supporter_message = "a message"
    user.accept_task(task)
    UserMailer.notify_supporter_of_edit(task)
  end
end
