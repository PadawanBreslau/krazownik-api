desc 'Sends messages to users'
task send_message: :environment do
  SendRecentMessageService.new.call
end
