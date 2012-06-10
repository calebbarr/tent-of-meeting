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

$url_stem = "http://concordances.org/hebrew/"
$hydra = Typhoeus::Hydra.new
$curr_row = 2
#used in getting long definition from other site
url = $url_stem


def process_inflected(link)
  process_inflection(link_array[0].lstrip(),link_array[1].sub(".htm",""))
end

$exceptions = []

def process_uninflected(strongs_num)
  begin
    link = strongs_num.to_s+".htm"
    url = $url_stem+link
    request = Typhoeus::Request.new(url, :method => :get)
    $hydra.queue(request)
    $hydra.run
    response = request.response
    doc = Hpricot(response.body)
    puts "strongs number:"
    puts strongs_num
    original_word = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td[1]/span[2]/text()")
    puts "form: "
    puts original_word.to_s
    everything_else = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td[1]/text()")[0..3]
    pos = everything_else[0]
    transliteration = everything_else[1]
    phonetic_spelling = everything_else[2]
    short_def = everything_else[3]
    puts "pos:"
    puts pos
    puts "transliteration:"
    puts transliteration
    puts "phonetic spelling:"
    puts phonetic_spelling
    puts "short definition:"
    puts short_def
    medium_def = (doc/"/html/body/table[2]/tr[1]/td[2]/table[2]/tr[1]/td[1]/text()")[-1]
    # long_def = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr[1]/td[1]/p[3]").to_s.gsub(/<\/?\s*[^a|\/a].+>/,"")
    # long_def = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td/p[17]/text()")[0].to_s.gsub(/<\/?\s*[^(a|\/a)][^>]*>/,"")
    # if long_def == "" then
    #   long_def = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td/p[2]").to_s.gsub(/<\/?\s*[^(a|\/a)][^>]*>/,"")
    # end
    # /html/body/table[2]/tr/td[2]/table[2]/tr/td/p[16]

    long_def_url = "http://www.sacrednamebible.com/kjvstrongs/STRHEB"+((strongs_num-1)/100).to_s+".htm"
    request = Typhoeus::Request.new(long_def_url, :method => :get)
    $hydra.queue(request)
    $hydra.run
    response = request.response
    doc = Hpricot(response.body)
    if strongs_num != 1 and (strongs_num-1) % 100 == 0 then
      $curr_row = 1
    end
    $curr_row +=1
    #the first time, the row is three, the second time, the row is two
    row_string = $curr_row.to_s
    path = "/html/body/center/table/tr["+row_string+"]/td[3]/p"
    long_def = (doc/path).to_s.gsub(/<\/?\s*[^(a|\/a)][^>]*>/,"").gsub(/(\')(?!\}).+\'\s\(<a\shref=\".+\">/, "<a>").gsub(/<\/a>\)/, "</a>")
    # long_def = # long_d = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td/p[5]/text()")[0]
    puts "short def:"
    puts short_def
    puts "medium def:"
    puts medium_def
    puts "long def:"
    puts long_def
  rescue
    $exceptions << strongs_num
  end
  # Process.exit!
end

(1..8674).each do |num|
  process_uninflected(num)
end

puts "EXCEPTIONS"
$exceptions.each do |e|
  puts e
end

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
# response = Typhoeus::Request.put("http://localhost:3000:3000/posts/1", :body => "whoo, a body")
# response = Typhoeus::Request.post("http://localhost:3000:3000/posts", :params => {:title => "test post", :content => "this is my test"})
# response = Typhoeus::Request.delete("http://localhost:3000:3000/posts/1")
