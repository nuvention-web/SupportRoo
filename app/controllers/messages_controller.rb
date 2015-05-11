class MessagesController < ApplicationController
  require 'twilio-ruby'

  def twilio
    @from = params[:From]
    @body = params[:Body]

    message = Twilio::TwiML::Response.new do |r|
      r.Message "Hey #{@from}, this is SupportRoo! You said #{@body}."
    end

    render xml: message.to_xml
  end
end
