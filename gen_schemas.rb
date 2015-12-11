#!/usr/bin/env ruby

require 'json'

def run_schema_guru(path, event_type)
  puts "schema-guru schema --vendor com.urbanairship.connect --name #{event_type} --schemaver 1-0-0 --no-length #{path}"
  %x(schema-guru schema --vendor com.urbanairship.connect --name #{event_type} --schemaver 1-0-0 --no-length #{path})
end

def fix(tree)
  tree.each_with_object({}) do | (key, value), hash |
   if value.is_a?(Hash)
      hash[key] = fix(value)
   else
      if (key=="additionalProperties")
        value=true
      end
      hash[key] = value
    end
  end
end

def fix_additional_properties(jsonstr)
  tree = JSON.parse jsonstr
  JSON.pretty_generate fix(tree)
end


if (`which schema-guru` == "") then
  raise ArgumentError.new "no schema-guru in path"
end

if File.exists?('./out')
  raise ArgumentError.new "output directory '.out/' already exists, wont overwrite"
end

jsonschemas = {}

Dir.glob("./in/*") do |path|
  event_type = File.basename path
  schema = run_schema_guru(path, event_type)
  jsonschemas[event_type] = schema
end


Dir.mkdir "out"
Dir.chdir "out"

jsonschemas.each do |event_key, json_schema|
  puts "writing to #{Dir.pwd}/#{event_key}.json"
  File.write("#{event_key}.json", fix_additional_properties(json_schema))
end
