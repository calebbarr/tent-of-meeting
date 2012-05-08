# encoding: utf-8
$hebrew_consonants = ["א", "ב", "ג", "ד", "ה", "ו", "ז", "ח", "ט", "י", "ך", "כ", "ל","ם","מ","ן", "נ", "ס", "ע", "ף", "פ", "ץ", "צ", "ק", "ר", "ש","ת"]
$greek_letters =  ["Α", "α", "Β", "β", "Γ", "γ", "Δ", "δ", "Ε", "ε", "Ζ", "ζ", "Η", "η", "Θ", "θ", "Ι", "ι", "Κ", "κ", "Λ", "λ", "Μ", "μ", "Ν", "ν", "Ξ", "ξ", "Ο", "ο", "Π", "π", "Ρ", "ρ", "Σ", "σ", "ς", "Τ", "τ", "Υ", "υ", "Φ", "φ", "Χ", "χ", "Ψ", "ψ", "Ω", "ω"]
$greek_accent_map = {
"02" => "Α",
"01" => "α",
 # "Β",
 # "β",
 # "Γ",
 # "γ",
 # "Δ",
 # "δ",
"12" => "Ε",
"11" => "ε",
 # "Ζ",
 # "ζ",
"22" => "Η",
"21" => "η",
 # "Θ",
 # "θ",
"32" => "Ι",
"31" => "ι",
 # "Κ",
 # "κ",
 # "Λ",
 # "λ",
 # "Μ",
 # "μ",
 # "Ν",
 # "ν",
 # "Ξ",
 # "ξ",
"42" => "Ο",
"41" => "ο",
 # "Π",
 # "π",
 # "Ρ",
 # "ρ",
 # "Σ",
 # "σ",
 # "ς",
 # "Τ",
 # "τ",
"52" => "Υ",
"51" => "υ",
 # "Φ",
 # "φ",
 # "Χ",
 # "χ",
 # "Ψ",
 # "ψ",
"62" => "Ω",
"61" => "ω",
"70" => "α",
"71" => "α",
"72" => "ε",
"73" => "ε",
"74" => "η",
"75" => "η",
"76" => "ι",
"77" => "ι",
"78" => "ο",
"7a" => "ο",
"7a" => "υ",
"7b" => "υ",
"7c" => "ω",
"7d" => "ω",
"81" => "αι",
"82" => "Αι",
"91" => "ηι",
"92" => "Ηι",
"a1" => "ωι",
"a2" => "Ωι",
"b0" => "α",
"b1" => "α",
"b2" => "αι",
"b3" => "αι",
"b4" => "αι",
"b6" => "α",
"b7" => "αι",
"b8" => "Α",
"b9" => "Α",
"ba" => "Α",
"bb" => "Α",
"bc" => "Αι",
"c2" => "ηι",
"c3" => "ηι",
"c4" => "ηι",
"c6" => "η",
"c7" => "ηι",
"c8" => "H",
"c9" => "H",
"ca" => "H",
"cb" => "H",
"cc" => "Hι",
"d1" => "ι",
"d2" => "Ι",
"e0" => "υ",
"e1" => "υ",
"e2" => "υ",
"e3" => "υ",
"e4" => "ρ",
"e5" => "ρ",
"e6" => "υ",
"e7" => "υ",
"e8" => "Υ",
"e9" => "Υ",
"ea" => "Υ",
"eb" => "Υ",
"ec" => "Ρ",
"f2" => "ωι",
"f3" => "ωι",
"f4" => "ωι",
"f6" => "ω",
"f7" => "ωι",
"f8" => "Ω",
"f9" => "Ω",
"fa" => "Ω",
"fb" => "Ω",
"fc" => "Ωι"
}


def normalize(form) 
  normalized = ""
  (0...form.length).each do |index|
    normalized +=  form[index] if $hebrew_consonants.include?(form[index])
    # puts "NORMALIZED[-1]="+normalized[-1]
  end
  # puts "NORMALIZED"
  # puts normalized
  # puts "NORMALIZED.LENGTH="+normalized.length.to_s
  return normalized
end

def normalize_greek(form) 
  normalized = ""
  (0...form.length).each do |index|
    # normalized +=  form[index] if $greek_letters.include?(form[index])
    letter = form[index]
    if $greek_letters.include?(letter)
      normalized +=  letter
    else
      hex = "%4.4x" % letter.ord
      if hex[0,2] == "1f"
        if hex[2] == "0"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["01"] : $greek_accent_map["02"]
          rescue
            normalized += $greek_accent_map["02"]
          end
        elsif hex[2] == "1"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["11"] : $greek_accent_map["12"]
          rescue
            normalized += $greek_accent_map["12"]
          end
        elsif hex[2] == "2"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["21"] : $greek_accent_map["22"]
          rescue
            normalized += $greek_accent_map["22"]
          end
        elsif hex[2] == "3"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["31"] : $greek_accent_map["32"]
          rescue
            normalized += $greek_accent_map["32"]
          end
        elsif hex[2] == "4"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["41"] : $greek_accent_map["42"]
          rescue
            normalized += $greek_accent_map["42"]
          end
        elsif hex[2] == "5"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["51"] : $greek_accent_map["52"]
          rescue
            normalized += $greek_accent_map["52"]
          end
        elsif hex[2] == "6"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["61"] : $greek_accent_map["62"]
          rescue
            normalized += $greek_accent_map["62"]
          end
        elsif hex[2] == "7"
          case hex[3]          
            when "0","1"
              normalized += $greek_accent_map["70"]
            when "2","3"
              normalized += $greek_accent_map["72"]
            when "4","5"
              normalized += $greek_accent_map["74"]
            when "6","7"
              normalized += $greek_accent_map["76"]
            when "8","9"
              normalized += $greek_accent_map["78"]
            when "a","b"
              normalized += $greek_accent_map["7a"]
            when "c","d"
              normalized += $greek_accent_map["7c"]
            else
              normalized += letter
          end
        elsif hex[2] == "8"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["81"] : $greek_accent_map["82"]
          rescue
            normalized += $greek_accent_map["82"]
          end
        elsif hex[2] == "9"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["91"] : $greek_accent_map["92"]
          rescue
            normalized += $greek_accent_map["92"]
          end
        elsif hex[2] == "a"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["a1"] : $greek_accent_map["a2"]
          rescue
            normalized += $greek_accent_map["a2"]
          end
        elsif hex[2] == "b"
          begin
            placer = Integer(hex[3])
            case placer
              when 0,1,6
                normalized += $greek_accent_map["b0"]
              when 2,3,4,7
                normalized += $greek_accent_map["b2"]
              when 8,9
                normalized += $greek_accent_map["b8"]
            else
              normalized += letter
            end
          rescue
            case hex[3]
            when "a","b"
              normalized += $greek_accent_map["ba"]
            when "c"
              normalized += $greek_accent_map["bc"]
            else
              normalized += letter
            end
          end
        elsif hex[2] == "c"
          case hex[3]
          when "2","3","4","7"
            normalized += $greek_accent_map["c2"]
          when "6" 
            normalized += $greek_accent_map["c6"]
          when "8", "9","a","b"
            normalized += $greek_accent_map["c8"]
          when "c"
            normalized += $greek_accent_map["cc"]
          else
            normalized += letter
          end
        elsif hex[2] == "d"
          begin
            placer = Integer(hex[3])
            normalized += placer <= 7 ? $greek_accent_map["d1"] : $greek_accent_map["d2"]
          rescue
            normalized += $greek_accent_map["d2"]
          end
        elsif hex[2] == "e"
          case hex[3]
            when "0","1","2","3","6","7"
              normalized += $greek_accent_map["e0"]
            when "4","5"
              normalized += $greek_accent_map["e4"]
            when "8","9","a","b"
              normalized += $greek_accent_map["e8"]
            when "c"
              normalized += $greek_accent_map["ec"]
            else
              normalized += letter
          end
        elsif hex[2] == "f"
          case hex[3]
            when "2","3","4","7"
              normalized += $greek_accent_map["f2"]
            when "6"
              normalized += $greek_accent_map["f6"]
            when "8","9"
              normalized += $greek_accent_map["f8"]
            when "a","b"
              normalized += $greek_accent_map["fa"]
            when "c"
              normalized += $greek_accent_map["fc"]
            else
              normalized += letter
          end
        else
          normalized += letter
        end
      else
        case hex
        when "03ce"
          normalized += "ω"
        when "03ac"
          normalized += "α"
        when "03ad"
          normalized += "ε"
        when "03ae"
          normalized += "η"
        when "03af"
          normalized += "ι"
        when "03ca"
          normalized += "ι"
        when "03cb"
          normalized += "υ"
        when "03cc"
          normalized += "ο"
        when "03cd"
          normalized += "υ"
        when "03ce"
          normalized += "ω"
        else
          normalized += letter
        end
      end
    end
    # puts "NORMALIZED[-1]="+normalized[-1]
  end
  # puts "NORMALIZED"
  # puts normalized
  # puts "NORMALIZED.LENGTH="+normalized.length.to_s
  return normalized.split(" ")[0]
end

# original_words_file_path = "../resources/all_original_words.rb"
# original_words_file = open(original_words_file_path, "r")
# new_original_words_file_path = "../resources/all_original_hebrew_words.rb"
# original_hebrew_words_file = open(new_original_words_file_path, "w")
# (1..8667).each do |index|
# # (1..2).each do |index|  
#   line = original_words_file.gets
#   # line_array = line.split(/([a-z]|_)+:/)
#   form = line.split(/([a-z]|_)+:/)[4].strip().gsub(/\"|,/,"")
#   # puts form
#   # puts line_array
#   new_line = line.sub(/(?<=, )(?=form: \")/,"normalized_form: \""+normalize(form)+"\", ")
#   original_hebrew_words_file.puts(new_line)
# end

original_greek_words_file_path = "../resources/all_original_greek_words.rb"
new_original_greek_words_file_path = "../resources/new_original_greek_words.rb"
new_original_greek_words_file = open(new_original_greek_words_file_path, "w")
original_greek_words_file = open(original_greek_words_file_path, "r")
(1..5612).each do |index|
# (1..10).each do |index|
  line = original_greek_words_file.gets
  form = line.split(/([a-z]|_)+:/)[4].strip().gsub(/\"|,/,"")
  # line_array = line.split(/([a-z]|_)+:/)
  puts normalize_greek(form)
  if form == ""
    new_line = line.sub(/(?<=, )(?=form: \")/,"normalized_form: \"\", ")
  else
    new_line = line.sub(/(?<=, )(?=form: \")/,"normalized_form: \""+normalize_greek(form)+"\", ")
  end
  new_original_greek_words_file.puts(new_line)
end