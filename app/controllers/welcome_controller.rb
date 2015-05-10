class WelcomeController < ApplicationController
  require 'twilio-ruby'

  def index
  end

  def twilio
    @from = params[:From]
    @body = params[:Body]

    message = Twilio::TwiML::Response.new do |r|
      r.Message "Hey #{@from}, you said #{@body}"
    end

    render xml: message.to_xml
  end
end
