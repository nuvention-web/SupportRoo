class UserMailer < ApplicationMailer

	def notify_supporter(task)
		@task = task
		mail to: @task.supporter_email, subject: "Thanks for signing up for a task on SupportRoo"
	end

	def notify_caretaker(task)
		@task = task
		mail to: @task.board.email, subject: "#{@task.supporter_name} just signed up for a task on your board!"
	end

  def notify_supporter_of_edit(task)
    @task = task
    mail to: @task.supporter_email, subject: "A task you signed up for on #{@task.board.name}'s board was edited"
  end

end
