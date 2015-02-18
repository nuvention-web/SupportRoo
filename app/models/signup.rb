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

class Signup < ActiveRecord::Base
end
