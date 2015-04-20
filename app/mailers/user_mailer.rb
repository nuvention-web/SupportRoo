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

  def invite_user(invite)
    @invite = invite
    mail to: @invite.email, subject: "You have been invited to #{@invite.board.name}'s Support Board!"
  end

  def notify_owners_of_completion(task)
    @task = task
    owner_emails = @task.board.owners.map{ |o| User.find(o.user_id).email } 
    mail to: owner_emails, subject: "Your task on #{@task.board.name}'s board, #{@task.title}, has been completed!"
  end
end
