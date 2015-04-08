# == Schema Information
#
# Table name: boards
#
#  id          :integer          not null, primary key
#  email       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  description :string
#

require 'rails_helper'

RSpec.describe Board, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
