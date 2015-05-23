# TODO: move this to env variables
require 'twilio-ruby'
 
account_sid = "AC263f5a2d0b65c94573defc726e02357a"
auth_token = "229b37e8a2f948876066f509427264c8" 
$twilio_client = Twilio::REST::Client.new account_sid, auth_token