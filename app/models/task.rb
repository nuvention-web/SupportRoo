# == Schema Information
#
# Table name: tasks
#
#  id                :integer          not null, primary key
#  description       :string
#  start_time        :datetime
#  end_time          :datetime
#  task_type_id      :integer
#  board_id          :integer
#  shared            :boolean
#  accepted          :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  supporter_email   :string
#  supporter_message :string
#  supporter_name    :string
#

class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :board

  extend SimpleCalendar
  has_calendar attribute: :start_time

  def accepted?
    !self.supporter_email.nil?
  end
end
