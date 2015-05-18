# == Schema Information
#
# Table name: supporters
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#  owner      :boolean          default("false")
#

require 'test_helper'

class SupporterTest < ActiveSupport::TestCase
end
