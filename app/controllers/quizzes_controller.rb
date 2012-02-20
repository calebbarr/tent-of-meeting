class QuizzesController < ApplicationController
  def show
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
  
  def get_quiz_path(id)
    #all of this can probably be abstracted to an application helper
    #various helpers can call that one
    #controllers and views should call their helper methods
    
  end
  
  def random_quiz_path
    q_id = session[:q_id] 
  	session[:q_id] = nil 
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
        puts "random_question"
        puts random_question.content
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
  
end