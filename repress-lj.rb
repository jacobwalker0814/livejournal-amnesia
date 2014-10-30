require 'livejournal/login'
require 'dotenv'

Dotenv.load

unless ENV.has_key?('LJ_USERNAME') && ENV.has_key?('LJ_PASSWORD');
  puts "Missing environment variable LJ_USERNAME and/or LJ_PASSWORD"
  exit
end

begin
  puts "Logging in to LiveJournal..."
  user = LiveJournal::User.new(ENV['LJ_USERNAME'],ENV['LJ_PASSWORD'])
  login = LiveJournal::Request::Login.new(user)
  login.run
rescue Exception => e
  puts e.message
  exit
end
