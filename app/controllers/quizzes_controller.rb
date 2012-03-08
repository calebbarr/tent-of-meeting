class QuizzesController < ApplicationController
  
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          verse_name = params[:verse]
          @verse = Verse.lookup(book_id, chapter_name, verse_name)
          @verse_text = VerseText.find(@verse.id) #is this being resolved to .first later?
          #this should yield an array, for later when we implement multiple languages and versions
          @chapter = @verse.chapter
          @book = @chapter.book
          
          if @verse.multiple_choice_questions.empty? then
            new_quiz_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s+"/quiz/new"
            redirect_to new_quiz_path
          end
        end
      end
    end
  end
    
  def random_quiz_path
    q_id = session[:q_id] 
  	session[:q_id] = nil #don't remember what i'm storing in the session here
  	next_id = MultipleChoiceQuestion.random
  	return get_quiz_path(next_id)
  end
  
  def answer
    #simple implementation, shouldn't use the session, should have better OOP design
    if params[:q_id] != nil then
      session[:q_id] = params[:q_id]
      question_id = params[:q_id]
      if params[:answer] != nil then
        answer = params[:answer]
        @question = MultipleChoiceQuestion.find(question_id)
        content = @question.content
        random_question = MultipleChoiceQuestion.random
        @verse = random_question.verse
        @chapter = @verse.chapter
        @book = @chapter.book
        
        random_quiz_path = "/"+@book.name.to_s+"/"+@chapter.name.to_s+"/"+@verse.name.to_s + "/quiz"
        correct_notice = ""
        if @question.correct == answer then
          correct_notice += 'Correct. '
        else
          correct_notice += 'Incorrect. '
        end
        correct_notice += "Q: "+content +"  A: "+ ->  {if @question.correct =="a" then return @question.a elsif @question.correct =="b" then return  @question.b elsif @question.correct =="c" then return @question.c elsif @question.correct =="d" then return @question.d end}.call
        redirect_to random_quiz_path, notice: correct_notice
      end
    end
  end
  
  def new
    @question = MultipleChoiceQuestion.new
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          verse_name = params[:verse]          
          @verse = Verse.lookup(book_id, chapter_name, verse_name)
          @verse_text = VerseText.find(@verse.id)
          @chapter = @verse.chapter
          @book = @chapter.book
        end
      end
    end
  end
  
  def create
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          if params[:content] != nil and params[:a] != nil and params[:b] != nil and params[:c] != nil and params[:d] != nil and params[:correct] != nil then
            verse_name = params[:verse]
            @verse = Verse.lookup(book_id, chapter_name, verse_name)
            @verse_text = VerseText.find(@verse.id)
            @chapter = @verse.chapter
            @book = @chapter.book
            
            content = params[:content]
            a = params[:a][0]
            b = params[:b][0]
            c = params[:c][0]
            d = params[:d][0]
            #for some reason, these are coming through as arrays
            #if this is a problem in the view, it needs to be fixed
            #else, if text fields just produce arrays, we'll have to keep
            #a solution like this
            correct = params[:correct]
            
            question = MultipleChoiceQuestion.new(verse_id: @verse.id, content: content, a: a, b: b, c: c, d: d, correct: correct)
            new_quiz_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s+"/quiz/new"
            if question.save then
                #write the code to generate this in a file, gets copied to seeds file each push to staging
                File.open("resources/generated_questions.rb", "a") do |f|
                  f.puts "MultipleChoiceQuestion.create({ verse_id: "+@verse.id.to_s+" , content: \""+content.gsub(/"/,/\"/)+"\", a: \""+a+"\", b: \""+b+"\", c: \""+c+"\", d: \""+d+"\", correct: \""+correct+"\" })"
                  f.close 
                end
                redirect_to new_quiz_path, notice: 'Question was successfully created.'
              else
                redirect_to new_quiz_path, notice: 'Question was not successfully created.'
              end         
          end
        end
      end
    end #this behavior needs to be accounted for in all actions of all controllers, what if we get something we don't expect?
  end
    
end