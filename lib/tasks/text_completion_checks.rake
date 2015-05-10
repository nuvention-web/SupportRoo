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
  puts "sending message to #{user}"
end
