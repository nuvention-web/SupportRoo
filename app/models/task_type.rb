# == Schema Information
#
# Table name: task_types
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TaskType < ActiveRecord::Base
end
