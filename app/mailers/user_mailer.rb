class UserMailer < ApplicationMailer

	def notify_supporter(task)
		@task = task
    supporter = User.find(@task.user_id)
		mail to: supporter.email, subject: "Thanks for signing up for a task on SupportRoo"
	end

	def notify_board_owners(task)
		@task = task
    owner_emails = @task.board.owners.map{ |o| User.find(o.user_id).email } 
		mail to: owner_emails, subject: "#{@task.supporter_name} just signed up for a task on your board!"
	end

  def notify_supporter_of_edit(task)
    @task = task
    supporter = User.find(@task.user_id)
    mail to: supporter.email, subject: "A task you signed up for on #{@task.board.name}'s board was edited"
  end

end
