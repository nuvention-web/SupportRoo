# == Schema Information
#
# Table name: supporters
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#  owner      :boolean
#

class Supporter < ActiveRecord::Base
  belongs_to :board
  belongs_to :user
end
