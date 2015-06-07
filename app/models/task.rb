# == Schema Information
#
# Table name: tasks
#
#  id                    :integer          not null, primary key
#  description           :string
#  start_time            :datetime
#  end_time              :datetime
#  task_type_id          :integer
#  board_id              :integer
#  shared                :boolean
#  accepted              :boolean
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  supporter_email       :string
#  supporter_message     :string
#  supporter_name        :string
#  title                 :string
#  user_id               :integer
#  completed             :boolean          default("false")
#  pinned                :boolean          default("false")
#  completion_check      :boolean          default("false")
#  completion_check_time :datetime
#

class Task < ActiveRecord::Base
  belongs_to :task_type
  belongs_to :board
  belongs_to :user
  validates_presence_of :completion_check_time, if: -> { self.completion_check }
  validates_presence_of :start_time
  validates_presence_of :task_type_id

  extend SimpleCalendar
  has_calendar attribute: :start_time

  default_scope -> { order('"pinned" DESC, start_time ASC') }
  scope :upcoming, -> { where("start_time > ?", Time.now).order('start_time ASC') }
  scope :not_taken, -> { where("accepted is null").order('start_time ASC') }

  def self.in_category(category)
    joins(:task_type).select do |t|
      t.task_type.category == category
    end
  end

  def accepted?
    user_id.present?
  end

  def complete!
    update_attributes(completed: true)
  end

  def pretty_start_time
    self.start_time.strftime("%B %d, %I:%M %p")
  end

  def pin!
    update_attributes(pinned: true)
  end

  def unpin!
    update_attributes(pinned: false)
  end

  def self.with_outstanding_completion_checks
    where(completion_check: true, completed: false).
    where("completion_check_time < ?", DateTime.now)
  end
end
