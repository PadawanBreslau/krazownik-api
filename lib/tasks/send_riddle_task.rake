desc 'Sends recent riddle to users'
task :send_riddle do
  SendRecentRiddleService.new.call
end
