verses_path = "./verses_data"

verses_lines = open(verses_path).readlines()


books = {}

currbook = ""
currchap = ""
currverse = ""

index = 0
while index < len(verses_lines):
	line = verses_lines[index]
	line_array = line.split()
	if len(line_array) == 1:
		currbook = line_array[0]
		index+=1
		line = verses_lines[index]
		line_array = line.split()		
		currchap = line_array[0]
		if currbook not in books:
			books[currbook] = {}
		if currchap not in books[currbook]:
			books[currbook][currchap] = {}
		
		index+=1
		
	line = verses_lines[index]
	line_array = line.split()
	versenum = line_array[0]
	if versenum == "#":
		index +=1
	else:
		if versenum not in books[currbook][currchap]:
			books[currbook][currchap][versenum] = {}
		rest_of_verse = " ".join(line_array[1:len(line_array)])
	
		print "\n\nPlease supply a question for the following verse. Questions are assumed to be within the context of their verse.\n\n"
		next_question = raw_input(rest_of_verse+"\n\n\n")
		while next_question.strip("\n") != "":
			books[currbook][currchap][versenum][next_question.strip("\n")] = { "choices" : []}
		
			counter = 1
			print "please give 4 multiple choice answers for the question"
			while counter < 5:
				books[currbook][currchap][versenum][next_question.strip("\n")]["choices"].append(raw_input("answer "+str(counter)+":"))
				counter +=1
		
			correct = raw_input("which was the correct answer?\n").strip("\n")
			while(correct != "1" and correct != "2" and correct != "3" and correct != "4"):
				print "please input a number 1-4:"
				correct = raw_input("which was the correct answer?\n").strip("\n")
			books[currbook][currchap][versenum][next_question.strip("\n")]["correct"] = correct
			print "Please supply a question for the following verse.  If you want to move on, simply press enter.\n\n"
			next_question = raw_input(rest_of_verse+"\n\n\n")
		index+=1
		
 

quiz = raw_input("These questions are about to be written to a file.  Do you want to take the quiz now? Type 'yes' if so.\n") == "yes"

quiz_file_path = "./quiz_file"
output_file = open(quiz_file_path,'a')


bible_books = books.keys()
for book in bible_books:
	book_chapters= books[book].keys()
	for chapter in book_chapters:
		chapter_verses = books[book][chapter].keys()
		for verse in chapter_verses:
			reference = book + " "+chapter+":"+verse
			questions = books[book][chapter][verse].keys()
			for question in questions:
				answers = books[book][chapter][verse][question]["correct"]
				prompt = "According to " + reference+", "+question
				if question[-1] != '?':
					prompt +="?"
					
				if quiz:
					print prompt
					
				output_file.write(prompt+"\n")
				counter = 1
				
				correct = books[book][chapter][verse][question]["correct"]
				for choice in books[book][chapter][verse][question]["choices"]:
					if quiz:
						print str(counter)+":\t"+choice
					if str(counter) == correct:
						output_file.write("*")
					output_file.write(choice+"\n")
					counter+=1
				output_file.write("\n")	
				if quiz:
					answer = raw_input("Answer: ")

				
				if quiz:
					if answer.strip("\n") != correct:
						print "Sorry, the answer was " + correct
					else:
						print "Correct"
			output_file.write("\n")