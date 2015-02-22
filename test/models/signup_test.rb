# == Schema Information
#
# Table name: signups
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string
#  last_name  :string
#

require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
