require 'livejournal/login'
require 'dotenv'

Dotenv.load

user = LiveJournal::User.new(ENV['LJ_USERNAME'],ENV['LJ_PASSWORD'])
login = LiveJournal::Request::Login.new(user)
login.run
