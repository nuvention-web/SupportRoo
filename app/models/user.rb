# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :supporters
  has_many :tasks
  has_many :boards, through: :supporters
  before_validation { self.phone_number = sanitize_number(self.phone_number) }
  validates_format_of :phone_number, with: /\+1\d{10}/, if: -> { self.phone_number }

  before_save { |user| user.email.downcase! }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
    presence: true,
    uniqueness: {
      case_sensitive: false
  }

  def add_board(board, owner=false)
    owner ||= false
    Supporter.create(user_id: id, board_id: board.id, owner: owner)
  end

  def owned_boards
    boards.includes(:supporters).where({ supporters: { owner: true } })
  end

  def supporting_boards
    boards.includes(:supporters).where({ supporters: { owner: false } })
  end

  def supporter_for(board)
    supporting_boards.any? { |b| b.id == board.id }
  end

  def accept_task(task, message=nil)
    task.update_attributes!({ user_id: id,
                              supporter_message: message
    })
  end

  def tasks_from_board(board)
    tasks.where({ board_id: board.id })
  end

  def friendly_name
    if self.first_name && self.last_name
      "#{self.first_name} #{self.last_name[0]}."
    end
  end

  def sanitize_number(number)
    return unless number
    number.gsub!(/[^\d\+]/,'')
    number = "+1" + number if number[0..1] != "+1"
    number
  end
end
