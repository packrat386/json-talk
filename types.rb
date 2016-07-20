require 'json'
require 'msgpack'

data = {
  "boolean" => true,
  "number" => 123.45678,
  "string" => "lorem ipsum",
  "array" => [ "a", "b", "c" ],
  "hash" => {
    "key" => "value"
  }
}

puts data.to_json
puts "#{data.to_json.size} bytes"
puts data.to_msgpack.inspect
puts "#{data.to_msgpack.size} bytes"

proto_data = `go run *.go`

puts proto_data.inspect
puts "#{proto_data.size} bytes"
