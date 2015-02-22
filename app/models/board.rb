# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Board < ActiveRecord::Base
  has_many :tasks
end
