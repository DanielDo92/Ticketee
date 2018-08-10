require "httparty"
token = "5f214e7bbe8d2d3ed8c035f382184ff7"
url = "http://localhost:3000/api/projects/1/tickets/16.json"

response  = HTTParty.get(url,
                         headers: {
                             Authorization: "Token token=#{token}"
                         })
puts response.parsed_response
