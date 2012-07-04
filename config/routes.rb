TentOfMeeting::Application.routes.draw do  
  match "/strongs", controller: :strongs, action: :index
  
  get "/nav", controller: :navigation, action: :get_nav
  post "/nav", controller: :navigation, action: :set_nav
  get "/nav/current_users", controller: :navigation, action: :current_users
  
  get "messages/index"

  get "messages/create"

  get "chats/room"

  get "nt_greek_words/index"

  get "nt_greek_words/show"

  get "ot_hebrew_words/index"

  get "ot_hebrew_words/show"

  get "memorize/show"

  ## application routes
  
  ## users
  devise_for :users
  match "/profile", :controller => :profile, :action => :show
  #should be a post here, once that functionality is working
  get "profile/edit"
  get "profile/settings", :as => "settings"
  post "profile/settings", :controller => :profile, :action => :update, as: "update_settings"
  get "users/show"
  get "/meet/:name", :controller => :profile, :action => :public
  
  #possibly rewrite routes for favorite chapters and books later
  get "verses/favorites/add/:id", controller: :verses, action: :add_favorite_verse, as: "add_favorite_verse"
  get "verses/favorites", controller: :verses, action: :favorite_verses, as: "get_favorite_verses"
  get "verses/favorites/delete/:id", controller: :verses, action: :remove_favorite_verse, as: "remove_favorite_verse"
  get "/verses/favorite", controller: :verses, action: :toggle_favorite, as: "toggle_favorite"
  #these need to use the correct HTTP verbs when possible
  
  post "verses/search", :controller => :verses, :action => :search, as: "verse_search"
  get "verses/search", :controller => :verses, :action => :search
  get "verses/related", :controller => :verses, :action => :related
  get "/verses/toggle_original_languages", :controller => :verses, :action => :toggle_original_languages
  
  post "/verses/current", :controller => :verses, :action => :set_current
  get "/verses/current", :controller => :verses, :action => :current
  
  get "/books/current", :controller => :books, :action => :current, :as => "curr_book"
  get "books/next", :controller => :books, :action => :next, :as => "next_book"
  get "books/prev", :controller => :books, :action => :prev, :as => "prev_book"
  
  post "/chapters/current", :controller => :chapters, :action => :set_current
  get "/chapters/current", :controller => :chapters, :action => :current
    
  ### Bible navigation  
  get "verses/random", :controller => :verses, :action => :random, :as => "random_verse"
  get "verses/next", :controller => :verses, :action => :next, :as => "next_verse"
  get "verses/prev", :controller => :verses, :action => :prev, :as => "prev_verse"
  get "chapters/next", :controller => :chapters, :action => :next, :as => "next_chapter"
  get "chapters/prev", :controller => :chapters, :action => :prev, :as => "prev_chapter"
  get "/Bible", :controller => :books, :action => :index, :as => "books_index"
  
  get "/hebrew/:id", :controller => :OT_hebrew_words, :action => :show
  get "/greek/:id", :controller => :NT_greek_words, :action => :show
  
  #root
  match "/", controller: :verses, action: :random
  # this will change later, maybe last visited verse or something
  
  # activity URLs
  get "/quiz/:q_id/:answer", :controller => :quizzes, :action => :answer, :as => :multiple_choice_check_answer
  get "/verses/quiz/:id", :controller => :verses, :action => :has_quiz
  get "memorize/next", :controller => :memorize, :action => :next
  get "/memorize", :controller => :memorize, :action => :redirect_to_verse_url
  resources :messages
  get "/notes/delete", :controller => :notes, :action => :delete
  # resources :notes
  get "/notes/new"
  get "/notes/create"
  get "/notes/index"
  get "/notes/show/:id", action: :show, controller: :notes
  get "/notes/show"
  get "/notes/show/:verse_id", action: :show, controller: :notes
  # resources :notes
  
  match "/greek", controller: :strongs, action: :greek
  match "/hebrew", controller: :strongs, action: :hebrew
  
  
  ## Bible Reference URLs
  #these need to be manually specified because each book is a "controller" level specification
  # (top level). otherwise, we could just say /verses(/:book(/:chapter(/:verse))) and interpret
  # the optional parameters in the controller (e.g. /verses/Ruth/2/17)
  
  match "/Genesis", :controller => :books, :action => :show, id: 1
  match "/Genesis/:chapter", :controller => :chapters, :action => :show, book: 1
  match "/Genesis/:chapter/:verse", :controller => :verses, :action => :show, book: 1
  match "/Genesis/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 1
  match "/Genesis/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 1
  match "/Genesis/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 1
  match "/Genesis/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 1
  
  match "/Exodus", :controller => :books, :action => :show, id: 2
  match "/Exodus/:chapter", :controller => :chapters, :action => :show, book: 2
  match "/Exodus/:chapter/:verse", :controller => :verses, :action => :show, book: 2
  match "/Exodus/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 2
  match "/Exodus/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 2
  match "/Exodus/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 2
  match "/Exodus/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 2
  
  match "/Leviticus", :controller => :books, :action => :show, id: 3
  match "/Leviticus/:chapter", :controller => :chapters, :action => :show, book: 3
  match "/Leviticus/:chapter/:verse", :controller => :verses, :action => :show, book: 3
  match "/Leviticus/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 3
  match "/Leviticus/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 3
  match "/Leviticus/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 3
  match "/Leviticus/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 3
  
  match "/Numbers", :controller => :books, :action => :show, id: 4
  match "/Numbers/:chapter", :controller => :chapters, :action => :show, book: 4
  match "/Numbers/:chapter/:verse", :controller => :verses, :action => :show, book: 4
  match "/Numbers/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 4
  match "/Numbers/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 4
  match "/Numbers/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 4
  match "/Numbers/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 4
      
  match "/Deuteronomy", :controller => :books, :action => :show, id: 5
  match "/Deuteronomy/:chapter", :controller => :chapters, :action => :show, book: 5
  match "/Deuteronomy/:chapter/:verse", :controller => :verses, :action => :show, book: 5
  match "/Deuteronomy/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 5
  match "/Deuteronomy/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 5
  match "/Deuteronomy/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 5
  match "/Deuteronomy/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 5
    
  match "/Joshua", :controller => :books, :action => :show, id: 6
  match "/Joshua/:chapter", :controller => :chapters, :action => :show, book: 6
  match "/Joshua/:chapter/:verse", :controller => :verses, :action => :show, book: 6
  match "/Joshua/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 6
  match "/Joshua/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 6
  match "/Joshua/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 6
  match "/Joshua/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 6  
  
  match "/Judges", :controller => :books, :action => :show, id: 7
  match "/Judges/:chapter", :controller => :chapters, :action => :show, book: 7
  match "/Judges/:chapter/:verse", :controller => :verses, :action => :show, book: 7
  match "/Judges/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 7
  match "/Judges/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 7
  match "/Judges/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 7
  match "/Judges/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 7
    
  match "/Ruth", :controller => :books, :action => :show, id: 8
  match "/Ruth/:chapter", :controller => :chapters, :action => :show, book: 8
  match "/Ruth/:chapter/:verse", :controller => :verses, :action => :show, book: 8
  match "/Ruth/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 8
  match "/Ruth/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 8
  match "/Ruth/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 8
  match "/Ruth/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 8
    
  match "/1%20Samuel", :controller => :books, :action => :show, id: 9
  match "/1%20Samuel/:chapter", :controller => :chapters, :action => :show, book: 9
  match "/1%20Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 9
  match "/1%20Samuel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 9
  match "/1%20Samuel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 9
  match "/1%20Samuel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 9
  match "/1%20Samuel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 9  
  
  # match "/1Samuel", :controller => :books, :action => :show, id: 9
  match "/1Samuel/:chapter", :controller => :chapters, :action => :show, book: 9
  match "/1Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 9
  match "/1Samuel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 9
  match "/1Samuel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 9
  match "/1Samuel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 9
  match "/1Samuel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 9
    
  match "/2%20Samuel", :controller => :books, :action => :show, id: 10
  match "/2%20Samuel/:chapter", :controller => :chapters, :action => :show, book: 10
  match "/2%20Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 10
  match "/2%20Samuel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 10
  match "/2%20Samuel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 10
  match "/2%20Samuel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 10
  match "/2%20Samuel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 10  
  
  # match "/2Samuel", :controller => :books, :action => :show, id: 10
  match "/2Samuel/:chapter", :controller => :chapters, :action => :show, book: 10
  match "/2Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 10
  match "/2Samuel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 10
  match "/2Samuel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 10
  match "/2Samuel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 10
  match "/2Samuel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 10  
  
  match "/1%20Kings", :controller => :books, :action => :show, id: 11
  match "/1%20Kings/:chapter", :controller => :chapters, :action => :show, book: 11
  match "/1%20Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 11
  match "/1%20Kings/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 11
  match "/1%20Kings/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 11
  match "/1%20Kings/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 11
  match "/1%20Kings/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 11  
  
  # match "/1Kings", :controller => :books, :action => :show, id: 11
  match "/1Kings/:chapter", :controller => :chapters, :action => :show, book: 11
  match "/1Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 11
  match "/1Kings/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 11
  match "/1Kings/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 11
  match "/1Kings/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 11
  match "/1%20Kings/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 11  
  
  match "/2%20Kings", :controller => :books, :action => :show, id: 12
  match "/2%20Kings/:chapter", :controller => :chapters, :action => :show, book: 12
  match "/2%20Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 12
  match "/2%20Kings/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 12
  match "/2%20Kings/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 12
  match "/2%20Kings/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 12
  match "/1%20Kings/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 11
  
  # match "/2Kings", :controller => :books, :action => :show, id: 12
  match "/2Kings/:chapter", :controller => :chapters, :action => :show, book: 12
  match "/2Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 12
  match "/2Kings/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 12
  match "/2Kings/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 12
  match "/2Kings/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 12
  match "/2Kings/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 12  
  
  match "/1%20Chronicles", :controller => :books, :action => :show, id: 13
  match "/1%20Chronicles/:chapter", :controller => :chapters, :action => :show, book: 13
  match "/1%20Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 13
  match "/1%20Chronicles/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 13
  match "/1%20Chronicles/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 13
  match "/1%20Chronicles/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 13
  match "/1%20Chronicles/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 13
  
  # match "/1Chronicles", :controller => :books, :action => :show, id: 13
  match "/1Chronicles/:chapter", :controller => :chapters, :action => :show, book: 13
  match "/1Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 13
  match "/1Chronicles/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 13
  match "/1Chronicles/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 13
  match "/1Chronicles/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 13
  match "/1Chronicles/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 13
  
  match "/2%20Chronicles", :controller => :books, :action => :show, id: 14
  match "/2%20Chronicles/:chapter", :controller => :chapters, :action => :show, book: 14
  match "/2%20Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 14
  match "/2%20Chronicles/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 14
  match "/2%20Chronicles/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 14
  match "/2%20Chronicles/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 14
  match "/2%20Chronicles/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 14
  
  # match "/2Chronicles", :controller => :books, :action => :show, id: 14
  match "/2Chronicles/:chapter", :controller => :chapters, :action => :show, book: 14
  match "/2Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 14
  match "/2Chronicles/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 14
  match "/2Chronicles/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 14
  match "/2Chronicles/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 14
  match "/2Chronicles/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 14    
    
  match "/Ezra", :controller => :books, :action => :show, id: 15
  match "/Ezra/:chapter", :controller => :chapters, :action => :show, book: 15
  match "/Ezra/:chapter/:verse", :controller => :verses, :action => :show, book: 15
  match "/Ezra/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 15
  match "/Ezra/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 15
  match "/Ezra/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 15
  match "/Ezra/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 15
  
  match "/Nehemiah", :controller => :books, :action => :show, id: 16
  match "/Nehemiah/:chapter", :controller => :chapters, :action => :show, book: 16
  match "/Nehemiah/:chapter/:verse", :controller => :verses, :action => :show, book: 16
  match "/Nehemiah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 16
  match "/Nehemiah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 16
  match "/Nehemiah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 16
  match "/Nehemiah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 16
  
  match "/Esther", :controller => :books, :action => :show, id: 17
  match "/Esther/:chapter", :controller => :chapters, :action => :show, book: 17
  match "/Esther/:chapter/:verse", :controller => :verses, :action => :show, book: 17
  match "/Esther/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 17
  match "/Esther/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 17
  match "/Esther/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 17
  match "/Esther/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 17
  
  match "/Job", :controller => :books, :action => :show, id: 18
  match "/Job/:chapter", :controller => :chapters, :action => :show, book: 18
  match "/Job/:chapter/:verse", :controller => :verses, :action => :show, book: 18
  match "/Job/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 18
  match "/Job/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 18
  match "/Job/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 18
  match "/Job/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 18
  
  match "/Psalms", :controller => :books, :action => :show, id: 19
  match "/Psalms/:chapter", :controller => :chapters, :action => :show, book: 19
  match "/Psalms/:chapter/:verse", :controller => :verses, :action => :show, book: 19
  match "/Psalms/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 19
  match "/Psalms/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 19
  match "/Psalms/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 19
  match "/Psalms/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 19
  
  match "/Psalm", :controller => :books, :action => :show, id: 19
  match "/Psalm/:chapter", :controller => :chapters, :action => :show, book: 19
  match "/Psalm/:chapter/:verse", :controller => :verses, :action => :show, book: 19
  match "/Psalm/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 19
  match "/Psalm/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 19
  match "/Psalm/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 19
  match "/Psalm/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 19
  
  match "/Proverbs", :controller => :books, :action => :show, id: 20
  match "/Proverbs/:chapter", :controller => :chapters, :action => :show, book: 20
  match "/Proverbs/:chapter/:verse", :controller => :verses, :action => :show, book: 20
  match "/Proverbs/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 20
  match "/Proverbs/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 20
  match "/Proverbs/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 20
  match "/Proverbs/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 20
  
  match "/Ecclesiastes", :controller => :books, :action => :show, id: 21
  match "/Ecclesiastes/:chapter", :controller => :chapters, :action => :show, book: 21
  match "/Ecclesiastes/:chapter/:verse", :controller => :verses, :action => :show, book: 21
  match "/Ecclesiastes/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 21
  match "/Ecclesiastes/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 21
  match "/Ecclesiastes/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 21
  match "/Ecclesiastes/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 21
  
  match "/SongofSongs", :controller => :books, :action => :show, id: 22
  match "/SongofSongs/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/SongofSongs/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  match "/SongofSongs/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 22
  match "/SongofSongs/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 22
  match "/SongofSongs/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 22
  match "/SongofSongs/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 22
  
  match "/SongofSolomon", :controller => :books, :action => :show, id: 22
  match "/SongofSolomon/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/SongofSolomon/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  match "/SongofSolomon/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 22
  match "/SongofSolomon/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 22
  match "/SongofSolomon/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 22
  match "/SongofSolomon/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 22
  
  match "/Song%20of%20Songs", :controller => :books, :action => :show, id: 22
  match "/Song%20of%20Songs/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/Song%20of%20Songs/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  match "/Song%20of%20Songs/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 22
  match "/Song%20of%20Songs/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 22
  match "/Song%20of%20Songs/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 22
  match "/Song%20of%20Songs/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 22
  
  match "/Song%20of%20Solomon", :controller => :books, :action => :show, id: 22
  match "/Song%20of%20Solomon/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 22
  
  match "/Isaiah", :controller => :books, :action => :show, id: 23
  match "/Isaiah/:chapter", :controller => :chapters, :action => :show, book: 23
  match "/Isaiah/:chapter/:verse", :controller => :verses, :action => :show, book: 23
  match "/Isaiah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 23
  match "/Isaiah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 23
  match "/Isaiah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 23
  match "/Isaiah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 23

  match "/Jeremiah", :controller => :books, :action => :show, id: 24
  match "/Jeremiah/:chapter", :controller => :chapters, :action => :show, book: 24
  match "/Jeremiah/:chapter/:verse", :controller => :verses, :action => :show, book: 24
  match "/Jeremiah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 24
  match "/Jeremiah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 24
  match "/Jeremiah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 24
  match "/Jeremiah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 24
  
  match "/Lamentations", :controller => :books, :action => :show, id: 25
  match "/Lamentations/:chapter", :controller => :chapters, :action => :show, book: 25
  match "/Lamentations/:chapter/:verse", :controller => :verses, :action => :show, book: 25
  match "/Lamentations/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 25
  match "/Lamentations/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 25
  match "/Lamentations/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 25
  
  match "/Ezekiel", :controller => :books, :action => :show, id: 26
  match "/Ezekiel/:chapter", :controller => :chapters, :action => :show, book: 26
  match "/Ezekiel/:chapter/:verse", :controller => :verses, :action => :show, book: 26
  match "/Ezekiel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 26
  match "/Ezekiel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 26
  match "/Ezekiel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 26
  match "/Ezekiel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 26
  
  match "/Daniel", :controller => :books, :action => :show, id: 27
  match "/Daniel/:chapter", :controller => :chapters, :action => :show, book: 27
  match "/Daniel/:chapter/:verse", :controller => :verses, :action => :show, book: 27
  match "/Daniel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 27
  match "/Daniel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 27
  match "/Daniel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 27
  match "/Daniel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 27
  
  match "/Hosea", :controller => :books, :action => :show, id: 28
  match "/Hosea/:chapter", :controller => :chapters, :action => :show, book: 28
  match "/Hosea/:chapter/:verse", :controller => :verses, :action => :show, book: 28
  match "/Hosea/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 28
  match "/Hosea/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 28
  match "/Hosea/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 28
  match "/Hosea/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 28
  
  match "/Joel", :controller => :books, :action => :show, id: 29
  match "/Joel/:chapter", :controller => :chapters, :action => :show, book: 29
  match "/Joel/:chapter/:verse", :controller => :verses, :action => :show, book: 29
  match "/Joel/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 29
  match "/Joel/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 29
  match "/Joel/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 29
  match "/Joel/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 29
  
  match "/Amos", :controller => :books, :action => :show, id: 30
  match "/Amos/:chapter", :controller => :chapters, :action => :show, book: 30
  match "/Amos/:chapter/:verse", :controller => :verses, :action => :show, book: 30
  match "/Amos/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 30
  match "/Amos/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 30
  match "/Amos/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 30
  match "/Amos/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 30
  
  match "/Obadiah", :controller => :books, :action => :show, id: 31
  match "/Obadiah/:chapter", :controller => :chapters, :action => :show, book: 31
  match "/Obadiah/:chapter/:verse", :controller => :verses, :action => :show, book: 31
  match "/Obadiah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 31
  match "/Obadiah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 31
  match "/Obadiah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 31
  match "/Obadiah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 31
  
  match "/Jonah", :controller => :books, :action => :show, id: 32
  match "/Jonah/:chapter", :controller => :chapters, :action => :show, book: 32
  match "/Jonah/:chapter/:verse", :controller => :verses, :action => :show, book: 32
  match "/Jonah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 32
  match "/Jonah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 32
  match "/Jonah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 32
  match "/Jonah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 32
  
  match "/Micah", :controller => :books, :action => :show, id: 33
  match "/Micah/:chapter", :controller => :chapters, :action => :show, book: 33
  match "/Micah/:chapter/:verse", :controller => :verses, :action => :show, book: 33
  match "/Micah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 33
  match "/Micah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 33
  match "/Micah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 33
  match "/Micah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 33
  
  match "/Nahum", :controller => :books, :action => :show, id: 34
  match "/Nahum/:chapter", :controller => :chapters, :action => :show, book: 34
  match "/Nahum/:chapter/:verse", :controller => :verses, :action => :show, book: 34
  match "/Nahum/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 34
  match "/Nahum/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 34
  match "/Nahum/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 34
  match "/Nahum/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 34
  
  match "/Habakkuk", :controller => :books, :action => :show, id: 35
  match "/Habakkuk/:chapter", :controller => :chapters, :action => :show, book: 35
  match "/Habakkuk/:chapter/:verse", :controller => :verses, :action => :show, book: 35
  match "/Habakkuk/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 35
  match "/Habakkuk/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 35
  match "/Habakkuk/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 35
  match "/Habakkuk/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 35
  
  match "/Zephaniah", :controller => :books, :action => :show, id: 36
  match "/Zephaniah/:chapter", :controller => :chapters, :action => :show, book: 36
  match "/Zephaniah/:chapter/:verse", :controller => :verses, :action => :show, book: 36
  match "/Zephaniah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 36
  match "/Zephaniah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 36
  match "/Zephaniah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 36
  match "/Zephaniah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 36
  
  match "/Haggai", :controller => :books, :action => :show, id: 37
  match "/Haggai/:chapter", :controller => :chapters, :action => :show, book: 37
  match "/Haggai/:chapter/:verse", :controller => :verses, :action => :show, book: 37
  match "/Haggai/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 37
  match "/Haggai/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 37
  match "/Haggai/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 37
  match "/Haggai/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 37
  
  match "/Zechariah", :controller => :books, :action => :show, id: 38
  match "/Zechariah/:chapter", :controller => :chapters, :action => :show, book: 38
  match "/Zechariah/:chapter/:verse", :controller => :verses, :action => :show, book: 38
  match "/Zechariah/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 38
  match "/Zechariah/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 38
  match "/Zechariah/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 38
  match "/Zechariah/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 38
  
  match "/Malachi", :controller => :books, :action => :show, id: 39
  match "/Malachi/:chapter", :controller => :chapters, :action => :show, book: 39
  match "/Malachi/:chapter/:verse", :controller => :verses, :action => :show, book: 39
  match "/Malachi/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 39
  match "/Malachi/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 39
  match "/Malachi/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 39
  match "/Malachi/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 39
  
  match "/Matthew", :controller => :books, :action => :show, id: 40
  match "/Matthew/:chapter", :controller => :chapters, :action => :show, book: 40
  match "/Matthew/:chapter/:verse", :controller => :verses, :action => :show, book: 40
  match "/Matthew/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 40
  match "/Matthew/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 40
  match "/Matthew/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 40
  match "/Matthew/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 40
  
  match "/Mark", :controller => :books, :action => :show, id: 41
  match "/Mark/:chapter", :controller => :chapters, :action => :show, book: 41
  match "/Mark/:chapter/:verse", :controller => :verses, :action => :show, book: 41
  match "/Mark/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 41
  match "/Mark/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 41
  match "/Mark/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 41
  match "/Mark/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 41
  
  match "/Luke", :controller => :books, :action => :show, id: 42
  match "/Luke/:chapter", :controller => :chapters, :action => :show, book: 42
  match "/Luke/:chapter/:verse", :controller => :verses, :action => :show, book: 42
  match "/Luke/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 42
  match "/Luke/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 42
  match "/Luke/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 42
  match "/Luke/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 42
  
  match "/John", :controller => :books, :action => :show, id: 43
  match "/John/:chapter", :controller => :chapters, :action => :show, book: 43
  match "/John/:chapter/:verse", :controller => :verses, :action => :show, book: 43
  match "/John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 43
  match "/John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 43
  match "/John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 43
  match "/John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 43
      
  match "/Acts", :controller => :books, :action => :show, id: 44
  match "/Acts/:chapter", :controller => :chapters, :action => :show, book: 44
  match "/Acts/:chapter/:verse", :controller => :verses, :action => :show, book: 44
  match "/Acts/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 44
  match "/Acts/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 44
  match "/Acts/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 44
  match "/Acts/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 44
  
  match "/Romans", :controller => :books, :action => :show, id: 45
  match "/Romans/:chapter", :controller => :chapters, :action => :show, book: 45
  match "/Romans/:chapter/:verse", :controller => :verses, :action => :show, book: 45
  match "/Romans/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 45
  match "/Romans/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 45
  match "/Romans/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 45
  match "/Romans/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 45
  
  # match "/1Corinthians", :controller => :books, :action => :show, id: 46
  match "/1Corinthians/:chapter", :controller => :chapters, :action => :show, book: 46
  match "/1Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 46
  match "/1Corinthians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 46
  match "/1Corinthians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 46
  match "/1Corinthians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 46
  match "/1Corinthians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 46
  
  match "/1%20Corinthians", :controller => :books, :action => :show, id: 46
  match "/1%20Corinthians/:chapter", :controller => :chapters, :action => :show, book: 46
  match "/1%20Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 46
  match "/1%20Corinthians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 46
  match "/1%20Corinthians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 46
  match "/1%20Corinthians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 46
  match "/1%20Corinthians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 46
  
  # match "/2Corinthians", :controller => :books, :action => :show, id: 47
  match "/2Corinthians/:chapter", :controller => :chapters, :action => :show, book: 47
  match "/2Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 47
  match "/2Corinthians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 47
  match "/2Corinthians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 47
  match "/2Corinthians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 47
  match "/2Corinthians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 47
  
  match "/2%20Corinthians", :controller => :books, :action => :show, id: 47
  match "/2%20Corinthians/:chapter", :controller => :chapters, :action => :show, book: 47
  match "/2%20Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 47
  match "/2%20Corinthians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 47
  match "/2%20Corinthians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 47
  match "/2%20Corinthians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 47
  match "/2%20Corinthians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 47
  
  match "/Galatians", :controller => :books, :action => :show, id: 48
  match "/Galatians/:chapter", :controller => :chapters, :action => :show, book: 48
  match "/Galatians/:chapter/:verse", :controller => :verses, :action => :show, book: 48
  match "/Galatians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 48
  match "/Galatians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 48
  match "/Galatians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 48
  match "/Galatians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 48  
  
  match "/Ephesians", :controller => :books, :action => :show, id: 49
  match "/Ephesians/:chapter", :controller => :chapters, :action => :show, book: 49
  match "/Ephesians/:chapter/:verse", :controller => :verses, :action => :show, book: 49
  match "/Ephesians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 49
  match "/Ephesians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 49
  match "/Ephesians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 49
  match "/Ephesians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 49
  
  match "/Philippians", :controller => :books, :action => :show, id: 50
  match "/Philippians/:chapter", :controller => :chapters, :action => :show, book: 50
  match "/Philippians/:chapter/:verse", :controller => :verses, :action => :show, book: 50
  match "/Philippians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 50
  match "/Philippians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 50
  match "/Philippians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 50
  match "/Philippians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 50
  
  match "/Colossians", :controller => :books, :action => :show, id: 51
  match "/Colossians/:chapter", :controller => :chapters, :action => :show, book: 51
  match "/Colossians/:chapter/:verse", :controller => :verses, :action => :show, book: 51
  match "/Colossians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 51
  match "/Colossians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 51
  match "/Colossians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 51
  match "/Colossians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 51
  
  # match "/1Thessalonians", :controller => :books, :action => :show, id: 52
  match "/1Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 52
  match "/1Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 52
  match "/1Thessalonians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 52
  match "/1Thessalonians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 52
  match "/1Thessalonians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 52
  match "/1Thessalonians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 52
  
  match "/1%20Thessalonians", :controller => :books, :action => :show, id: 52
  match "/1%20Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 52
  match "/1%20Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 52
  match "/1%20Thessalonians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 52
  match "/1%20Thessalonians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 52
  match "/1%20Thessalonians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 52
  match "/1%20Thessalonians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 52
  
  # match "/2Thessalonians", :controller => :books, :action => :show, id: 53
  match "/2Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 53
  match "/2Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 53
  match "/2Thessalonians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 53
  match "/2Thessalonians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 53
  match "/2Thessalonians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 53
  match "/2Thessalonians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 53
  
  match "/2%20Thessalonians", :controller => :books, :action => :show, id: 53
  match "/2%20Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 53
  match "/2%20Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 53
  match "/2%20Thessalonians/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 53
  match "/2%20Thessalonians/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 53
  match "/2%20Thessalonians/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 53
  match "/2%20Thessalonians/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 53
  
  # match "/1Timothy", :controller => :books, :action => :show, id: 54
  match "/1Timothy/:chapter", :controller => :chapters, :action => :show, book: 54
  match "/1Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 54
  match "/1Timothy/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 54
  match "/1Timothy/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 54
  match "/1Timothy/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 54
  match "/1Timothy/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 54
  
  match "/1%20Timothy", :controller => :books, :action => :show, id: 54
  match "/1%20Timothy/:chapter", :controller => :chapters, :action => :show, book: 54
  match "/1%20Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 54
  match "/1%20Timothy/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 54
  match "/1%20Timothy/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 54
  match "/1%20Timothy/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 54
  match "/1%20Timothy/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 54
  
  # match "/2Timothy", :controller => :books, :action => :show, id: 55
  match "/2Timothy/:chapter", :controller => :chapters, :action => :show, book: 55
  match "/2Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 55
  match "/2Timothy/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 55
  match "/2Timothy/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 55
  match "/2Timothy/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 55
  match "/2Timothy/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 55
  
  match "/2%20Timothy", :controller => :books, :action => :show, id: 55
  match "/2%20Timothy/:chapter", :controller => :chapters, :action => :show, book: 55
  match "/2%20Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 55
  match "/2%20Timothy/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 55
  match "/2%20Timothy/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 55
  match "/2%20Timothy/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 55
  match "/2%20Timothy/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 55
  
  match "/Titus", :controller => :books, :action => :show, id: 56
  match "/Titus/:chapter", :controller => :chapters, :action => :show, book: 56
  match "/Titus/:chapter/:verse", :controller => :verses, :action => :show, book: 56
  match "/Titus/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 56
  match "/Titus/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 56
  match "/Titus/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 56
  match "/Titus/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 56
  
  match "/Philemon", :controller => :books, :action => :show, id: 57
  match "/Philemon/:chapter", :controller => :chapters, :action => :show, book: 57
  match "/Philemon/:chapter/:verse", :controller => :verses, :action => :show, book: 57
  match "/Philemon/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 57
  match "/Philemon/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 57
  match "/Philemon/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 57
  
  match "/Hebrews", :controller => :books, :action => :show, id: 58
  match "/Hebrews/:chapter", :controller => :chapters, :action => :show, book: 58
  match "/Hebrews/:chapter/:verse", :controller => :verses, :action => :show, book: 58
  match "/Hebrews/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 58
  match "/Hebrews/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 58
  match "/Hebrews/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 58
  match "/Hebrews/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 58
  
  match "/James", :controller => :books, :action => :show, id: 59
  match "/James/:chapter", :controller => :chapters, :action => :show, book: 59
  match "/James/:chapter/:verse", :controller => :verses, :action => :show, book: 59
  match "/James/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 59
  match "/James/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 59
  match "/James/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 59
  match "/James/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 59

  # match "/1Peter", :controller => :books, :action => :show, id: 60
  match "/1Peter/:chapter", :controller => :chapters, :action => :show, book: 60
  match "/1Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 60
  match "/1Peter/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 60
  match "/1Peter/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 60
  match "/1Peter/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 60
  match "/1Peter/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 60
  
  match "/1%20Peter", :controller => :books, :action => :show, id: 60
  match "/1%20Peter/:chapter", :controller => :chapters, :action => :show, book: 60
  match "/1%20Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 60
  match "/1%20Peter/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 60
  match "/1%20Peter/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 60
  match "/1%20Peter/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 60
  match "/1%20Peter/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 60
  
  # match "/2Peter", :controller => :books, :action => :show, id: 61
  match "/2Peter/:chapter", :controller => :chapters, :action => :show, book: 61
  match "/2Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 61
  match "/2Peter/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 61
  match "/2Peter/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 61
  match "/2Peter/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 61
  match "/2Peter/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 61
  
  match "/2%20Peter", :controller => :books, :action => :show, id: 61
  match "/2%20Peter/:chapter", :controller => :chapters, :action => :show, book: 61
  match "/2%20Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 61
  match "/2%20Peter/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 61
  match "/2%20Peter/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 61
  match "/2%20Peter/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 61
  match "/2%20Peter/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 61
  
  # match "/1John", :controller => :books, :action => :show, id: 62
  match "/1John/:chapter", :controller => :chapters, :action => :show, book: 62
  match "/1John/:chapter/:verse", :controller => :verses, :action => :show, book: 62
  match "/1John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 62
  match "/1John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 62
  match "/1John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 62
  
  match "/1%20John", :controller => :books, :action => :show, id: 62
  match "/1%20John/:chapter", :controller => :chapters, :action => :show, book: 62
  match "/1%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 62
  match "/1%20John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 62
  match "/1%20John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 62
  match "/1%20John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 62
  match "/1%20John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 62
  
  # match "/2John", :controller => :books, :action => :show, id: 63
  match "/2John/:chapter", :controller => :chapters, :action => :show, book: 63
  match "/2John/:chapter/:verse", :controller => :verses, :action => :show, book: 63
  match "/2John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 63
  match "/2John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 63
  match "/2John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 63
  match "/2John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 63
  
  match "/2%20John", :controller => :books, :action => :show, id: 63
  match "/2%20John/:chapter", :controller => :chapters, :action => :show, book: 63
  match "/2%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 63
  match "/2%20John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 63
  match "/2%20John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 63
  match "/2%20John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 63
  match "/2%20John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 63
  
  # match "/3John", :controller => :books, :action => :show, id: 64
  match "/3John/:chapter", :controller => :chapters, :action => :show, book: 64
  match "/3John/:chapter/:verse", :controller => :verses, :action => :show, book: 64
  match "/3John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 64
  match "/3John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 64
  match "/3John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 64
  match "/3John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 64
  
  match "/3%20John", :controller => :books, :action => :show, id: 64
  match "/3%20John/:chapter", :controller => :chapters, :action => :show, book: 64
  match "/3%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 64
  match "/3%20John/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 64
  match "/3%20John/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 64
  match "/3%20John/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 64
  match "/3%20John/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 64
  
  match "/Jude", :controller => :books, :action => :show, id: 65
  match "/Jude/:chapter", :controller => :chapters, :action => :show, book: 65
  match "/Jude/:chapter/:verse", :controller => :verses, :action => :show, book: 65
  match "/Jude/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 65
  match "/Jude/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 65
  match "/Jude/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 65
  match "/Jude/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 65
  
  match "/Revelation", :controller => :books, :action => :show, id: 66
  match "/Revelation/:chapter", :controller => :chapters, :action => :show, book: 66
  match "/Revelation/:chapter/:verse", :controller => :verses, :action => :show, book: 66
  match "/Revelation/:chapter/:verse/quiz", :controller => :quizzes, :action => :show, book: 66
  match "/Revelation/:chapter/:verse/quiz/new", :controller => :quizzes, :action => :new, book: 66
  match "/Revelation/:chapter/:verse/quiz/create", :controller => :quizzes, :action => :create, book: 66
  match "/Revelation/:chapter/:verse/memorize", :controller => :memorize, :action => :show, book: 66
  
  #should be changed later
  #root :to => something
  #right now there is a JS redirect on public/index.html
  
end
  