#!/usr/bin/ruby

require 'net/http'
require 'pp'
require 'json'

username = 'sample_connection'
password = 'sample_connection'
uri = URI "https://connect-testing.urbanairship.com/api/events/"

buffer=""

Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|

  request = Net::HTTP::Post.new uri.path

  request.basic_auth 'sample_connection', 'sample_connection'
  request.body = "{}"

  http.request request do |response|
    puts "#{response.code} - #{response.message}"
    response.read_body do |chunk|
      buffer+=chunk
      while line = buffer.slice!(/.+\r?\n/)
        event = JSON.parse(line)
        puts JSON.pretty_generate event
        puts
      end
    end
  end

end
