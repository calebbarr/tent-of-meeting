require 'rubygems'
require 'typhoeus'
require 'json'
require 'hpricot'

# the request object
# request = Typhoeus::Request.new("http://www.pauldix.net",
#                                 :body          => "this is a request body",
#                                 :method        => :post,
#                                 :headers       => {:Accept => "text/html"},
#                                 :timeout       => 100, # milliseconds
#                                 :cache_timeout => 60, # seconds
#                                 :params        => {:field1 => "a field"})
# # we can see from this that the first argument is the url. the second is a set of options.
# # the options are all optional. The default for :method is :get. Timeout is measured in milliseconds.
# # cache_timeout is measured in seconds.
# 
# # Run the request via Hydra.
# hydra = Typhoeus::Hydra.new
# hydra.queue(request)
# hydra.run
# 
# # the response object will be set after the request is run
# response = request.response
# response.code    # http status code
# response.time    # time in seconds the request took
# response.headers # the http headers
# response.headers_hash # http headers put into a hash
# response.body    # the response body

# hydra = Typhoeus::Hydra.new
# hydra.queue(request)
# hydra.run

hydra = Typhoeus::Hydra.new
url = "http://biblos.com/job/12-18.htm"


request = Typhoeus::Request.new(url, :method => :get)
hydra.queue(request)
hydra.run
response = request.response
doc = Hpricot(response.body)
# puts url
english_translations = []
(doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td/table/tr/td/table[2]/tr/td/table/tr/td[4]").each do |span|
  english_translations << span/"text()".to_s
  #for some reason the xpath isn't working to get the href attribute
end

puts english_translations.slice(1..-1).join("|")
# 
# 
# 
# 
# response = request.response
# # puts response.body
# doc = Hpricot(response.body)
# (doc/"/html/body/table[2]/tr[1]/td[4]/table[1]/tr[1]/td[1]/p/b/a/text()
# ").each do | reference|
# puts reference.to_s
# end

# response = Typhoeus::Request.get("http://concordances.org/1_samuel/1-1.htm")
# doc = Hpricot(response.body)
# (doc/"/html/body/table[2]/tr[1]/td[4]/table[1]/tr[1]/td[1]/p/b/a/text()
# ").each do | reference|
# puts reference.to_s.split(" ")
# end
# 
# hydra = Typhoeus::Hydra.new
# hydra.queue(request)

# /td[2]/table[2]/tbody/tr/td[2]/table/tbody/tr/td/p/b/a
# response = Typhoeus::Request.head("http://www.pauldix.net")
# response = Typhoeus::Request.put("http://localhost:3000/posts/1", :body => "whoo, a body")
# response = Typhoeus::Request.post("http://localhost:3000/posts", :params => {:title => "test post", :content => "this is my test"})
# response = Typhoeus::Request.delete("http://localhost:3000/posts/1")
