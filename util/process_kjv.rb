kjv = File.new(ARGV[0], "r")

book_id = 0
book_name = ""
chapter_id = 0
chapter_name = 0
verse_id = 0
verse_name = 0

content = ""
while(line = kjv.gets)
  line.chomp!
  if line =~ /Book .*/ then
    book_id_str,book_name = line.split(/(?<=Book [0-9]{2})\s/)
    book_id =  book_id+1
    print "Book.create({id: "+book_id.to_s+", name: \""+book_name.to_s+"\"})\n"
    # line = kjv.gets
  elsif line.length == 0 then
    # puts book_name+" "+chapter_name.to_s+":"+verse_name.to_s
    # puts content
    print "Verse.create({id: "+verse_id.to_s+", name: "+verse_name.to_s+", chapter_id: "+chapter_id.to_s+"})\n"
    print "VerseText.create({id: "+verse_id.to_s+",verse_id: "+verse_id.to_s+", language: \"eng\", content: \""+content+"\"})\n"
    content = ""
  else
    if line[0,8] =~/[0-9]{3}:[0-9]{3}/ then
      chapter_verse,content = line.split(/(?<=[0-9]{3}:[0-9]{3})\s/)
      chapter_verse = chapter_verse.split(":")
      next_chapter_name = chapter_verse[0].to_i
      verse_name = chapter_verse[1].to_i
      verse_id +=1
      if next_chapter_name != chapter_name then
        chapter_name = next_chapter_name
        chapter_id+=1
        print "Chapter.create({id: "+chapter_id.to_s+", name: "+chapter_name.to_s+", book_id: "+book_id.to_s+"})\n"
      end
    else
      content+= " "+line.lstrip!
    end
  end
end
kjv.close