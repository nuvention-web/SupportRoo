class MessagesController < ApplicationController
  require 'twilio-ruby'

  def twilio_receive
    @from = params[:From]
    @body = params[:Body].downcase!

    user = User.find_by(phone_number: @from)
    task = Message.where(user: user, sent_by_us: true).order(:created_at).last.task #UGLY

    if user.present?
      if @body.include? "yes"
        text = "Thanks for completing the task! We'll let #{task.board.creator.friendly_name} know!"
        task.complete!
      elsif @body.include? "no"
        text = "We're sorry to hear that. We'll let #{task.board.creator.friendly_name} know!"
        task.update_attributes(completion_check: false)
      else
        text = "We didn't quite catch that. Please respond with just 'Yes' or 'No'."
      end

      # TODO same as on send side, make sure we only create if twilio sends.
      Message.create(user: user, task: task, body: text, sent_by_us: false)
      message = Twilio::TwiML::Response.new do |r|
        r.Message text
      end

      render xml: message.to_xml
    end
  end

end
