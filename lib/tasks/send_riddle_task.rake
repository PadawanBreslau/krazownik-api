desc 'Sends recent riddle to users'
task send_riddle: :environment do
  SendRecentRiddleService.new.call
end
