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
#  title             :string
#  user_id           :integer
#  completed?        :boolean          default("false")
#

class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :board
  belongs_to :user

  extend SimpleCalendar
  has_calendar attribute: :start_time

  default_scope { order('start_time ASC') }
  scope :upcoming, -> { where("start_time > ?", Time.now).order('start_time ASC') }
  scope :not_taken, -> { where("accepted is null").order('start_time ASC') }

  def accepted?
    !user_id.nil?
  end

  def complete!
    update_attributes(completed?: true)
  end
end
