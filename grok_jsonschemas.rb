#!/usr/bin/ruby

require 'fileutils'

if (File.exists?('./jsonschemas'))
  raise ArgumentError.new "Refusing to overwrite ./jsonschemas directory"
end

Dir.mkdir 'jsonschemas'

Dir.glob("./out/*") do |path|
  filename = File.basename path
  event_type = filename.gsub(/\.\w+$/, '')
  Dir.mkdir "jsonschemas/#{event_type}"
  Dir.mkdir "jsonschemas/#{event_type}/jsonschema"
  FileUtils.cp("./out/#{filename}","jsonschemas/#{event_type}/jsonschema/1-0-0", :verbose => true)
end
