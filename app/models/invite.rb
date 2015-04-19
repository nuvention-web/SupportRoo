# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  code       :string
#  claimed    :boolean          default("false")
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_invites_on_code  (code)
#

class Invite < ActiveRecord::Base
  require 'securerandom'
  include ApplicationHelper

  belongs_to :board
  before_save { self.code = SecureRandom.hex }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :board_id, presence: true

  def self.send_invites(emails, board_id)
    invites = { valid: [], invalid: [] }
    emails.each do |email|
      invite = Invite.new(email: email, board_id: board_id)
      if invite.save
        invites[:valid] << email
        UserMailer.invite_user(invite).deliver_now!
      else
        invites[:invalid] << email
      end
    end
    invites
  end

end
