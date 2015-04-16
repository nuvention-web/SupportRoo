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
#

require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
