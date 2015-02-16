class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :board

  extend SimpleCalendar
  has_calendar attribute: :start_time

  def accepted?
    !self.supporter_email.nil?
  end
end
