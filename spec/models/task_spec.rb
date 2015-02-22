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
#

require 'rails_helper'

RSpec.describe Task, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
