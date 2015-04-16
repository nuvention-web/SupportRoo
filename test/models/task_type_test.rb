# == Schema Information
#
# Table name: task_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category    :string
#

require 'test_helper'

class TaskTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
