class UserMailer < ApplicationMailer

	def notify_supporter(task)
		@task = task
    @supporter = task.user
    @owner = task.board.creator
		mail to: @supporter.email, subject: "[SupportRoo] Thank you for your Support!"
	end

	def notify_board_owners(task)
		@task = task
    owner_emails = @task.board.owner_emails
    @volunteer = @task.user
    @owner = @task.board.creator
		mail to: owner_emails, subject: "[SupportRoo] #{@volunteer.first_name} #{@volunteer.last_name} just signed up for a task on your board!"
	end

  def notify_supporter_of_edit(task)
    @task = task
    @supporter = task.user
    @owner = task.board.creator
    mail to: @supporter.email, subject: "[SupportRoo] A task you signed up for on #{@owner.first_name} #{@owner.last_name}'s board was updated!"
  end

  def invite_user(invite)
    @invite = invite
    @owner = @invite.board.creator
    mail to: @invite.email, subject: "[SupportRoo] You have been invited to #{@owner.first_name} #{@owner.last_name}'s Support Board!"
  end

  def notify_owners_of_completion(task)
    @task = task
    owner_emails = @task.board.owner_emails
    @volunteer = @task.user
    @owner = @task.board.creator
    mail to: owner_emails, subject: "[SupportRoo] Your task on #{@owner.first_name} #{@owner.last_name}'s board, #{@task.title}, has been completed!"
  end
end
