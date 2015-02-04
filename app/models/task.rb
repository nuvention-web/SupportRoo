class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :board

  def accepted?
    !self.supporter_email.nil?
  end
end
