#!/usr/bin/ruby

require 'yajl/gzip'
require 'yajl/deflate'
require 'yajl/http_stream'
require 'uri'
require 'pp'

##unless (username = ARGV[0]) && (password = ARGV[1])
#  puts "\nUsage: ruby examples/http/twitter_stream_api.rb username password\n\n"
#  exit(0)
#end

username = 'sample_connection'
password = 'sample_connection'

captured = 0
uri = URI.parse("https://#{username}:#{password}@connect-testing.urbanairship.com/api/events/")

trap('INT') {
  puts "\n\nCaptured #{captured} objects from the stream"
  puts "CTRL+C caught, later!"
  exit(0)
}

evt = Yajl::HttpStream.post(uri, :symbolize_keys => true)
pp evt
evt do |hash|
  STDOUT.putc '.'
  STDOUT.flush
  captured += 1
end
