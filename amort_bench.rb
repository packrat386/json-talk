require 'json'
require 'benchmark'
require 'faraday'
require 'msgpack'

url = 'http://localhost:9000/amortize'
accruing = '100'
interest_rate = '3.65'
start_date = '2012-02-01'
due_dates = ['2012-02-03', '2012-02-06', '2012-02-08']
loan = {
  accruing: accruing,
  interest_rate: interest_rate,
  start_date: start_date,
  due_dates: due_dates
}
req_body = Array.new
10.times do
  req_body << loan
end

puts req_body.to_json

def client
  Faraday.new { |client| client.adapter Faraday.default_adapter }
end

def post(url, body, accept)
  client.post(url) do |req|
    req.headers['Accept'] = accept
    req.headers['Content-Type'] = 'application/json'
    req.body = body.to_json
  end
end

json_body = post(url, req_body, 'application/json').body
msgp_body = post(url, req_body, 'msgpack').body

puts "SIZE"
puts "JSON: #{json_body.size}"
puts "MessagePack #{msgp_body.size}"
puts "\nBENCHMARK\n\n"

N = 100_000

Benchmark.bmbm do |x|
  x.report('json') do
    N.times do
      JSON.parse(json_body)
    end
  end

  x.report('msgpack') do
    N.times do
      MessagePack.unpack(msgp_body)
    end
  end
end
  
