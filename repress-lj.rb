require 'dotenv'
require 'livejournal'

####################
# Monkey patch to include beforedate param and specify things I want.
# Comes from https://github.com/danhealy via http://pastie.org/4338006
module LiveJournal
  module Request
    class GetEvents
      def initialize(user, repress_before)
        super(user, 'getevents')
        @request['lineendings'] = 'unix'

        @strict = true

        @request['selecttype'] = 'lastn'
        @request['howmany'] = 50
        @request['beforedate'] = repress_before.strftime("%Y-%m-%d %H:%M:%S")
      end
    end
  end
end
# end monkeypatch
####################

##########################
# Set up the environment #
##########################
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


repress_before = Time.now

shameful_memories = []
while repress_before do
  puts "Getting up to 50 posts before " + repress_before.to_s
  posts = LiveJournal::Request::GetEvents.new(user, repress_before).run.values
  if posts && (posts.is_a? Array) && posts.length > 0;
    shameful_memories += posts
    repress_before = posts.last.time
  else
    puts "Done finding posts"
    repress_before = nil
  end
end

shame_count = shameful_memories.length
puts "All together we found #{shame_count} posts"

repressed_count = 0
shameful_memories.each do |post|
  repressed_count = repressed_count + 1
  puts "Repressing post id #{post.itemid}, #{repressed_count} of #{shame_count}"
  post.security = :private
  LiveJournal::Request::EditEvent.new(user, post).run
end
