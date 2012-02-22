# VerseText.create({id: 31102,verse_id: 31102, language: "eng", content: "The grace of our Lord Jesus Christ be with you all. Amen."})
#<MultipleChoiceQuestion id: 1, verse_id: 1, content: "According to Genesis 1:1, when did God create the h...", a: "after the earth", b: "before the earth", c: "in the beginning", d: "ages ago", correct: "c", created_at: "2012-02-19 07:06:09", updated_at: "2012-02-19 07:06:09"> 
import re,os,sys

new_seeds = open("new_seeds.rb","a")
numbers_letters = {
1 : "a",
2 : "b",
3 : "c",
4 : "d"
}

question_answers = open('quiz_fragment','r').read().split('\n\n')

for question_answer in question_answers:
	output ="MultipleChoiceQuestion.create({"
	lines = question_answer.split("\n")
	if len(lines) != 5:
		print lines
		print "len(lines) != 5:"
		sys.exit()
	question = lines[0]
	tokens = question.split()
	if tokens[0] != "According" or tokens[1] != "to" or tokens[2] != tokens[2].capitalize() or not re.match("[0-9]+:[0-9]", tokens[3]):
		print lines
		print "bad input"
		sys.exit()
	book = tokens[2]
	chapter,verse = tokens[3].split(":")
	verse = verse[:-1]
	print "doing ruby lookup"
	print book,chapter,verse
	verse_id = os.popen("ruby get_verse_id.rb "+ book +" "+ chapter+ " "+verse).read()
	
	correct = None
	for index in range(1,5):
		if lines[index][0] == "*":
			lines[index] = lines[index][1:]
			correct = numbers_letters[index]
			
	if correct == None:
		print lines
		print "correct == None:"
		sys.exit()
	
	output+=" verse_id: "
	output += str(verse_id)
	output+=", "
	output+=" content: \""
	output += 	question
	output+="\", "
	output+=" a: \""
	output += lines[1]
	output+="\", "
	output+=" b: \""
	output += lines[2]
	output+="\", "
	output+=" c: \""
	output += lines[3]
	output+="\", "
	output+=" d: \""	
	output += lines[4]
	output+="\", "
	output+=" correct: \""
	output += correct
	output+=" })"
	new_seeds.write(output+"\n")
	
