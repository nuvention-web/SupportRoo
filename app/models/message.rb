# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  sent_by_us :boolean
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  def sent?
    sent_by_us
  end

  def received?   
    !sent_by_us 
  end
end
