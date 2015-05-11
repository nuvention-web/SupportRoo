task :text_completion_checks => :environment do
  tasks_to_check = Task.with_outstanding_completion_checks
  tasks_to_check.each do |task|
    next unless task.user
    user = task.user
    if user.phone_number
      send_completion_check_message(user, task)
    end
  end
end

def send_completion_check_message(user,task)
  from = "+18455895098" # Our Twilio number

  text = ["Hi #{user.friendly_name}!",
          "You signed up on #{task.board.creator.friendly_name}'s board on SupportRoo for a task titled \"#{task.title}\".",
          "Please reply to this message with 'Yes' or 'No' to let us know if you have completed this task)"]
         .join("\n\n")

  # TODO: Maybe should only save if actually sent? Not sure how to check that.
  Message.create(user: user, task: task, body: text, sent_by_us: true)
  $twilio_client.account.messages.create(
    :from => from,
    :to => user.phone_number,
    :body => text
  )
end
