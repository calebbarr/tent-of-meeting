require 'rubygems'
require 'active_record'
require 'typhoeus'
require 'hpricot'

$original_words_file = File.open("../resources/all_original_words.rb", "w")
$curr_row = 2
#used in getting long definition from other site
$url_stem = "http://concordances.org/hebrew/"
$hydra = Typhoeus::Hydra.new
$exceptions = []

db_config = YAML::load(File.open("../config/database.yml"))
ActiveRecord::Base.establish_connection(db_config['development'])
require '../app/models/original_word'
require '../app/models/ot_hebrew_word'
require '../app/models/nt_greek_word'

def process_uninflected(strongs_num)
  begin
    link = strongs_num.to_s+".htm"
    url = $url_stem+link
    request = Typhoeus::Request.new(url, :method => :get)
    $hydra.queue(request)
    $hydra.run
    response = request.response
    doc = Hpricot(response.body)
    # puts "strongs number:"
    # puts strongs_num
    form = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td[1]/span[2]/text()").to_s
    # puts "form: "
    # puts form.to_s
    everything_else = (doc/"/html/body/table[2]/tr/td[2]/table[2]/tr/td[1]/text()")[0..3]
    pos = everything_else[0].to_s.gsub("\"","\\\"")
    transliteration = everything_else[1].to_s.gsub("\"","\\\"")
    phonetic_spelling = everything_else[2].to_s.gsub("\"","\\\"")
    short_definition = everything_else[3].to_s.gsub("\"","\\\"")
    # puts "transliteration:"
    # puts transliteration
    # puts "phonetic spelling:"
    # puts phonetic_spelling
    # puts "short def:"
    # puts short_definition
    medium_definition = (doc/"/html/body/table[2]/tr[1]/td[2]/table[2]/tr[1]/td[1]/text()")[-1].to_s.gsub("\"","\\\"")
    if strongs_num != 1 and (strongs_num-1) % 100 == 0 then
      $curr_row = 1
    end
    $curr_row +=1
    #the first time, the row is three, the second time, the row is two
    row_string = $curr_row.to_s
    path = "/html/body/center/table/tr["+row_string+"]/td[3]/p"
    long_definition_url = "http://www.sacrednamebible.com/kjvstrongs/STRHEB"+((strongs_num-1)/100).to_s+".htm"
    request = Typhoeus::Request.new(long_definition_url, :method => :get)
    $hydra.queue(request)
    $hydra.run
    response = request.response
    doc = Hpricot(response.body)
    long_definition = (doc/path).to_s.gsub(/<\/?\s*[^(a|\/a)][^>]*>/,"").gsub(/(\')(?!\}).+\'\s\(<a\shref=\".+\">/, "<a>").gsub(/<\/a>\)/, "</a>").gsub("\"","\\\"")
    ot_hebrew_word_string = "OTHebrewWord.create({"
    ot_hebrew_word_string += "strong_id: "
    ot_hebrew_word_string += strongs_num.to_s + ", "
    ot_hebrew_word_string += "form: "
    ot_hebrew_word_string += "\""+form+"\"" +", "
    ot_hebrew_word_string += "pos: "
    ot_hebrew_word_string += "\""+pos+"\"" +", "
    ot_hebrew_word_string += "transliteration: "
    ot_hebrew_word_string += "\""+transliteration+"\"" +", "
    ot_hebrew_word_string += "phonetic_spelling: "
    ot_hebrew_word_string += "\""+phonetic_spelling+"\"" +", "
    ot_hebrew_word_string += "short_definition: "
    ot_hebrew_word_string += "\""+short_definition+"\"" +", "
    ot_hebrew_word_string += "medium_definition: "
    ot_hebrew_word_string += "\""+medium_definition+"\"" +", "
    ot_hebrew_word_string += "long_definition: "
    ot_hebrew_word_string += "\""+long_definition+"\""
    ot_hebrew_word_string += " })"
    
    # OTHebrewWord.create{strong_id: strongs_num, form: form, pos: pos, transliteration: transliteration, phonetic_spelling: phonetic_spelling, short_definition: short_definition, medium_definition: medium_definition, long_definition: long_definition}
  
    $original_words_file.puts(ot_hebrew_word_string)
    # puts "short def:"
    # puts short_definition
    # puts "medium def:"
    # puts medium_definition
    # puts "long def:"
    # puts long_definition
    # Process.exit!
  rescue
    $exceptions << strongs_num
  end

end

(1..8674).each do |num|
  process_uninflected(num)
end

puts "EXCEPTIONS"
$exceptions.each do |e|
  puts e
end
