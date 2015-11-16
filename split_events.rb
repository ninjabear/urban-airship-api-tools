#!/usr/bin/ruby

require 'json'
require 'fileutils'

infile = ARGV[0]

if (infile.nil? || !File.exists?(infile)) then
  raise ArgumentError.new "Cannot find input file: #{infile}"
end

jsons = {}
buf = ""
File.open(infile).each do |line|
  if (line.chomp == "") then
    # buf must be a complete json
    json = JSON.parse(buf)
    event_type = json["type"]
    if !jsons.has_key?(event_type) then
      jsons[event_type] = []
    end
    jsons[event_type] << json
    buf=""
  end
  buf += line
end


if !File.directory?('./in') then
  Dir.mkdir('./in')
else
  FileUtils.rm_rf("./in/.", secure: true)
end

Dir.chdir './in'

jsons.keys.each do |key|
  Dir.mkdir key
  jsons[key].each_with_index do |itm, idx|
    File.write("#{key}/#{key}-#{idx}.json", JSON.pretty_generate(itm))
  end
end
