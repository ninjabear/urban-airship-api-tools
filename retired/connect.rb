#!/usr/bin/ruby

require 'rubygems'
require 'em-http'
require 'json'

require 'pp'


EM.run {

  username = 'sample_connection'
  password = 'sample_connection'

  buffer = ""

  opts = { :proxy => {
       :host => '127.0.0.1',
       :port => 8888 }
     }

  conn = EventMachine::HttpRequest.new('https://connect-testing.urbanairship.com/')

  pipe = conn.post({
    :path => '/api/events/',
    :head => { 'authorization' => [ username, password ], 'Accept-Encoding' => 'gzip, compressed' },
    :body => {}
  })

  pp pipe

  pipe.callback {

    pp pipe.response_header.status

    unless pipe.response_header.status == 200
      puts "Call failed with response code #{pipe.response_header.status}"
      pp pipe.response_header
      EM.stop
    end
  }

  pipe.stream do |chunk|
    pp chunk
    EM.stop
    buffer += chunk
    while line = buffer.slice!(/.+\r\n/)
      pp JSON.parse(line)
    end
  end

}
