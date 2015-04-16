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

class Board < ActiveRecord::Base
  has_many :supporters
  has_many :users, through: :supporters

  has_many :tasks

  validates :name, { presence: true }
  validates :description, { presence: true }


  def owners
    supporters.where( { owner: true } )
  end

  def owned_by user
    supporters.any? { |s| s.user_id == user.id && s.owner }
  end

end
