class UserMailer < ApplicationMailer

	def notify_supporter(task)
		@task = task
		mail to: task.supporter_email, subject: "Thanks for signing up for a task on SupportRoo"
	end

end
