TentOfMeeting::Application.routes.draw do  

  ## application routes
  
  ## users
  devise_for :users
  
  match "/profile", :controller => :profile, :action => :show
  #should be a post here, once that functionality is working
  get "profile/edit"
  
  #should be a post here, once that functionality is working
  get "profile/settings", :as => "settings"
  
  get "users/show"
  
  
  ### Bible navigation -- legacy /debug
  #these should be removed soon, verses, chapters, and books should not be accessible
  # by id
  # resources :verses, :only => :show
  # resources :chapters, :only => :show
  # resources :books, :only => :show
  
  
  ### Bible navigation
  
  get "verses/random", :controller => :verses, :action => :random, :as => "random_verse"
  get "verses/next", :controller => :verses, :action => :next, :as => "next_verse"
  get "verses/prev", :controller => :verses, :action => :prev, :as => "prev_verse"
  get "chapters/next", :controller => :chapters, :action => :next, :as => "next_chapter"
  get "chapters/prev", :controller => :chapters, :action => :prev, :as => "prev_chapter"  
  
  ## Bible Reference URLs
  #these need to be manually specified because each book is a "controller" level specification
  # (top level). otherwise, we could just say /verses(/:book(/:chapter(/:verse))) and interpret
  # the optional parameters in the controller (e.g. /verses/Ruth/2/17)
  
  match "/Genesis", :controller => :books, :action => :show, id: 1
  match "/Genesis/:chapter", :controller => :chapters, :action => :show, book: 1
  match "/Genesis/:chapter/:verse", :controller => :verses, :action => :show, book: 1
  
  match "/Exodus", :controller => :books, :action => :show, id: 2
  match "/Exodus/:chapter", :controller => :chapters, :action => :show, book: 2
  match "/Exodus/:chapter/:verse", :controller => :verses, :action => :show, book: 2
  
  match "/Leviticus", :controller => :books, :action => :show, id: 3
  match "/Leviticus/:chapter", :controller => :chapters, :action => :show, book: 3
  match "/Leviticus/:chapter/:verse", :controller => :verses, :action => :show, book: 3
  
  match "/Numbers", :controller => :books, :action => :show, id: 4
  match "/Numbers/:chapter", :controller => :chapters, :action => :show, book: 4
  match "/Numbers/:chapter/:verse", :controller => :verses, :action => :show, book: 4
    
  match "/Deuteronomy", :controller => :books, :action => :show, id: 5
  match "/Deuteronomy/:chapter", :controller => :chapters, :action => :show, book: 5
  match "/Deuteronomy/:chapter/:verse", :controller => :verses, :action => :show, book: 5
  
  match "/Joshua", :controller => :books, :action => :show, id: 6
  match "/Joshua/:chapter", :controller => :chapters, :action => :show, book: 6
  match "/Joshua/:chapter/:verse", :controller => :verses, :action => :show, book: 6
  
  match "/Judges", :controller => :books, :action => :show, id: 7
  match "/Judges/:chapter", :controller => :chapters, :action => :show, book: 7
  match "/Judges/:chapter/:verse", :controller => :verses, :action => :show, book: 7
  
  match "/Ruth", :controller => :books, :action => :show, id: 8
  match "/Ruth/:chapter", :controller => :chapters, :action => :show, book: 8
  match "/Ruth/:chapter/:verse", :controller => :verses, :action => :show, book: 8
  
  match "/1%20Samuel", :controller => :books, :action => :show, id: 9
  match "/1%20Samuel/:chapter", :controller => :chapters, :action => :show, book: 9
  match "/1%20Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 9
  
  # match "/1Samuel", :controller => :books, :action => :show, id: 9
  match "/1Samuel/:chapter", :controller => :chapters, :action => :show, book: 9
  match "/1Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 9
  
  match "/2%20Samuel", :controller => :books, :action => :show, id: 10
  match "/2%20Samuel/:chapter", :controller => :chapters, :action => :show, book: 10
  match "/2%20Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 10
  
  # match "/2Samuel", :controller => :books, :action => :show, id: 10
  match "/2Samuel/:chapter", :controller => :chapters, :action => :show, book: 10
  match "/2Samuel/:chapter/:verse", :controller => :verses, :action => :show, book: 10
  
  match "/1%20Kings", :controller => :books, :action => :show, id: 11
  match "/1%20Kings/:chapter", :controller => :chapters, :action => :show, book: 11
  match "/1%20Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 11
  
  # match "/1Kings", :controller => :books, :action => :show, id: 11
  match "/1Kings/:chapter", :controller => :chapters, :action => :show, book: 11
  match "/1Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 11
  
  match "/2%20Kings", :controller => :books, :action => :show, id: 12
  match "/2%20Kings/:chapter", :controller => :chapters, :action => :show, book: 12
  match "/2%20Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 12
  
  # match "/2Kings", :controller => :books, :action => :show, id: 12
  match "/2Kings/:chapter", :controller => :chapters, :action => :show, book: 12
  match "/2Kings/:chapter/:verse", :controller => :verses, :action => :show, book: 12
  
  match "/1%20Chronicles", :controller => :books, :action => :show, id: 13
  match "/1%20Chronicles/:chapter", :controller => :chapters, :action => :show, book: 13
  match "/1%20Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 13
  
  # match "/1Chronicles", :controller => :books, :action => :show, id: 13
  match "/1Chronicles/:chapter", :controller => :chapters, :action => :show, book: 13
  match "/1Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 13
  
  match "/2%20Chronicles", :controller => :books, :action => :show, id: 14
  match "/2%20Chronicles/:chapter", :controller => :chapters, :action => :show, book: 14
  match "/2%20Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 14
  
  # match "/2Chronicles", :controller => :books, :action => :show, id: 14
  match "/2Chronicles/:chapter", :controller => :chapters, :action => :show, book: 14
  match "/2Chronicles/:chapter/:verse", :controller => :verses, :action => :show, book: 14
    
  match "/Ezra", :controller => :books, :action => :show, id: 15
  match "/Ezra/:chapter", :controller => :chapters, :action => :show, book: 15
  match "/Ezra/:chapter/:verse", :controller => :verses, :action => :show, book: 15
  
  match "/Nehemiah", :controller => :books, :action => :show, id: 16
  match "/Nehemiah/:chapter", :controller => :chapters, :action => :show, book: 16
  match "/Nehemiah/:chapter/:verse", :controller => :verses, :action => :show, book: 16
  
  match "/Esther", :controller => :books, :action => :show, id: 17
  match "/Esther/:chapter", :controller => :chapters, :action => :show, book: 17
  match "/Esther/:chapter/:verse", :controller => :verses, :action => :show, book: 17
  
  match "/Job", :controller => :books, :action => :show, id: 18
  match "/Job/:chapter", :controller => :chapters, :action => :show, book: 18
  match "/Job/:chapter/:verse", :controller => :verses, :action => :show, book: 18
  
  match "/Psalms", :controller => :books, :action => :show, id: 19
  match "/Psalms/:chapter", :controller => :chapters, :action => :show, book: 19
  match "/Psalms/:chapter/:verse", :controller => :verses, :action => :show, book: 19
  
  match "/Proverbs", :controller => :books, :action => :show, id: 20
  match "/Proverbs/:chapter", :controller => :chapters, :action => :show, book: 20
  match "/Proverbs/:chapter/:verse", :controller => :verses, :action => :show, book: 20
  
  match "/Ecclesiastes", :controller => :books, :action => :show, id: 21
  match "/Ecclesiastes/:chapter", :controller => :chapters, :action => :show, book: 21
  match "/Ecclesiastes/:chapter/:verse", :controller => :verses, :action => :show, book: 21
  
  match "/SongofSongs", :controller => :books, :action => :show, id: 22
  match "/SongofSongs/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/SongofSongs/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  
  match "/SongofSolomon", :controller => :books, :action => :show, id: 22
  match "/SongofSolomon/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/SongofSolomon/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  
  match "/Song%20of%20Songs", :controller => :books, :action => :show, id: 22
  match "/Song%20of%20Songs/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/Song%20of%20Songs/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  
  match "/Song%20of%20Solomon", :controller => :books, :action => :show, id: 22
  match "/Song%20of%20Solomon/:chapter", :controller => :chapters, :action => :show, book: 22
  match "/Song%20of%20Solomon/:chapter/:verse", :controller => :verses, :action => :show, book: 22
  
  match "/Isaiah", :controller => :books, :action => :show, id: 23
  match "/Isaiah/:chapter", :controller => :chapters, :action => :show, book: 23
  match "/Isaiah/:chapter/:verse", :controller => :verses, :action => :show, book: 23

  match "/Jeremiah", :controller => :books, :action => :show, id: 24
  match "/Jeremiah/:chapter", :controller => :chapters, :action => :show, book: 24
  match "/Jeremiah/:chapter/:verse", :controller => :verses, :action => :show, book: 24
  
  match "/Lamentations", :controller => :books, :action => :show, id: 25
  match "/Lamentations/:chapter", :controller => :chapters, :action => :show, book: 25
  match "/Lamentations/:chapter/:verse", :controller => :verses, :action => :show, book: 25
  
  match "/Ezekiel", :controller => :books, :action => :show, id: 26
  match "/Ezekiel/:chapter", :controller => :chapters, :action => :show, book: 26
  match "/Ezekiel/:chapter/:verse", :controller => :verses, :action => :show, book: 26
  
  match "/Daniel", :controller => :books, :action => :show, id: 27
  match "/Daniel/:chapter", :controller => :chapters, :action => :show, book: 27
  match "/Daniel/:chapter/:verse", :controller => :verses, :action => :show, book: 27
  
  match "/Hosea", :controller => :books, :action => :show, id: 28
  match "/Hosea/:chapter", :controller => :chapters, :action => :show, book: 28
  match "/Hosea/:chapter/:verse", :controller => :verses, :action => :show, book: 28
  
  match "/Joel", :controller => :books, :action => :show, id: 29
  match "/Joel/:chapter", :controller => :chapters, :action => :show, book: 29
  match "/Joel/:chapter/:verse", :controller => :verses, :action => :show, book: 29
  
  match "/Amos", :controller => :books, :action => :show, id: 30
  match "/Amos/:chapter", :controller => :chapters, :action => :show, book: 30
  match "/Amos/:chapter/:verse", :controller => :verses, :action => :show, book: 30
  
  match "/Obadiah", :controller => :books, :action => :show, id: 31
  match "/Obadiah/:chapter", :controller => :chapters, :action => :show, book: 31
  match "/Obadiah/:chapter/:verse", :controller => :verses, :action => :show, book: 31
  
  match "/Jonah", :controller => :books, :action => :show, id: 32
  match "/Jonah/:chapter", :controller => :chapters, :action => :show, book: 32
  match "/Jonah/:chapter/:verse", :controller => :verses, :action => :show, book: 32
  
  match "/Micah", :controller => :books, :action => :show, id: 33
  match "/Micah/:chapter", :controller => :chapters, :action => :show, book: 33
  match "/Micah/:chapter/:verse", :controller => :verses, :action => :show, book: 33
  
  match "/Nahum", :controller => :books, :action => :show, id: 34
  match "/Nahum/:chapter", :controller => :chapters, :action => :show, book: 34
  match "/Nahum/:chapter/:verse", :controller => :verses, :action => :show, book: 34
  
  match "/Habakkuk", :controller => :books, :action => :show, id: 35
  match "/Habakkuk/:chapter", :controller => :chapters, :action => :show, book: 35
  match "/Habakkuk/:chapter/:verse", :controller => :verses, :action => :show, book: 35
  
  match "/Zephaniah", :controller => :books, :action => :show, id: 36
  match "/Zephaniah/:chapter", :controller => :chapters, :action => :show, book: 36
  match "/Zephaniah/:chapter/:verse", :controller => :verses, :action => :show, book: 36
  
  match "/Haggai", :controller => :books, :action => :show, id: 37
  match "/Haggai/:chapter", :controller => :chapters, :action => :show, book: 37
  match "/Haggai/:chapter/:verse", :controller => :verses, :action => :show, book: 37
  
  match "/Zechariah", :controller => :books, :action => :show, id: 38
  match "/Zechariah/:chapter", :controller => :chapters, :action => :show, book: 38
  match "/Zechariah/:chapter/:verse", :controller => :verses, :action => :show, book: 38
  
  match "/Malachi", :controller => :books, :action => :show, id: 39
  match "/Malachi/:chapter", :controller => :chapters, :action => :show, book: 39
  match "/Malachi/:chapter/:verse", :controller => :verses, :action => :show, book: 39
  
  match "/Matthew", :controller => :books, :action => :show, id: 40
  match "/Matthew/:chapter", :controller => :chapters, :action => :show, book: 40
  match "/Matthew/:chapter/:verse", :controller => :verses, :action => :show, book: 40
  
  match "/Mark", :controller => :books, :action => :show, id: 41
  match "/Mark/:chapter", :controller => :chapters, :action => :show, book: 41
  match "/Mark/:chapter/:verse", :controller => :verses, :action => :show, book: 41
  
  match "/Luke", :controller => :books, :action => :show, id: 42
  match "/Luke/:chapter", :controller => :chapters, :action => :show, book: 42
  match "/Luke/:chapter/:verse", :controller => :verses, :action => :show, book: 42
  
  match "/John", :controller => :books, :action => :show, id: 43
  match "/John/:chapter", :controller => :chapters, :action => :show, book: 43
  match "/John/:chapter/:verse", :controller => :verses, :action => :show, book: 43
      
  match "/Acts", :controller => :books, :action => :show, id: 44
  match "/Acts/:chapter", :controller => :chapters, :action => :show, book: 44
  match "/Acts/:chapter/:verse", :controller => :verses, :action => :show, book: 44
  
  match "/Romans", :controller => :books, :action => :show, id: 45
  match "/Romans/:chapter", :controller => :chapters, :action => :show, book: 45
  match "/Romans/:chapter/:verse", :controller => :verses, :action => :show, book: 45
  
  # match "/1Corinthians", :controller => :books, :action => :show, id: 46
  match "/1Corinthians/:chapter", :controller => :chapters, :action => :show, book: 46
  match "/1Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 46
  
  match "/1%20Corinthians", :controller => :books, :action => :show, id: 46
  match "/1%20Corinthians/:chapter", :controller => :chapters, :action => :show, book: 46
  match "/1%20Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 46
  
  # match "/2Corinthians", :controller => :books, :action => :show, id: 47
  match "/2Corinthians/:chapter", :controller => :chapters, :action => :show, book: 47
  match "/2Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 47
  
  match "/2%20Corinthians", :controller => :books, :action => :show, id: 47
  match "/2%20Corinthians/:chapter", :controller => :chapters, :action => :show, book: 47
  match "/2%20Corinthians/:chapter/:verse", :controller => :verses, :action => :show, book: 47
  
  match "/Galatians", :controller => :books, :action => :show, id: 48
  match "/Galatians/:chapter", :controller => :chapters, :action => :show, book: 48
  match "/Galatians/:chapter/:verse", :controller => :verses, :action => :show, book: 48
  
  match "/Ephesians", :controller => :books, :action => :show, id: 49
  match "/Ephesians/:chapter", :controller => :chapters, :action => :show, book: 49
  match "/Ephesians/:chapter/:verse", :controller => :verses, :action => :show, book: 49
  
  match "/Phillipians", :controller => :books, :action => :show, id: 50
  match "/Phillipians/:chapter", :controller => :chapters, :action => :show, book: 50
  match "/Phillipians/:chapter/:verse", :controller => :verses, :action => :show, book: 50
  
  match "/Colossians", :controller => :books, :action => :show, id: 51
  match "/Colossians/:chapter", :controller => :chapters, :action => :show, book: 51
  match "/Colossians/:chapter/:verse", :controller => :verses, :action => :show, book: 51
  
  # match "/1Thessalonians", :controller => :books, :action => :show, id: 52
  match "/1Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 52
  match "/1Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 52
  
  match "/1%20Thessalonians", :controller => :books, :action => :show, id: 52
  match "/1%20Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 52
  match "/1%20Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 52
  
  # match "/2Thessalonians", :controller => :books, :action => :show, id: 53
  match "/2Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 53
  match "/2Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 53
  
  match "/2%20Thessalonians", :controller => :books, :action => :show, id: 53
  match "/2%20Thessalonians/:chapter", :controller => :chapters, :action => :show, book: 53
  match "/2%20Thessalonians/:chapter/:verse", :controller => :verses, :action => :show, book: 53
  
  # match "/1Timothy", :controller => :books, :action => :show, id: 54
  match "/1Timothy/:chapter", :controller => :chapters, :action => :show, book: 54
  match "/1Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 54
  
  match "/1%20Timothy", :controller => :books, :action => :show, id: 54
  match "/1%20Timothy/:chapter", :controller => :chapters, :action => :show, book: 54
  match "/1%20Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 54
  
  # match "/2Timothy", :controller => :books, :action => :show, id: 55
  match "/2Timothy/:chapter", :controller => :chapters, :action => :show, book: 55
  match "/2Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 55
  
  match "/2%20Timothy", :controller => :books, :action => :show, id: 55
  match "/2%20Timothy/:chapter", :controller => :chapters, :action => :show, book: 55
  match "/2%20Timothy/:chapter/:verse", :controller => :verses, :action => :show, book: 55
  
  match "/Titus", :controller => :books, :action => :show, id: 56
  match "/Titus/:chapter", :controller => :chapters, :action => :show, book: 56
  match "/Titus/:chapter/:verse", :controller => :verses, :action => :show, book: 56
  
  match "/Philemon", :controller => :books, :action => :show, id: 57
  match "/Philemon/:chapter", :controller => :chapters, :action => :show, book: 57
  match "/Philemon/:chapter/:verse", :controller => :verses, :action => :show, book: 57
  
  match "/Hebrews", :controller => :books, :action => :show, id: 58
  match "/Hebrews/:chapter", :controller => :chapters, :action => :show, book: 58
  match "/Hebrews/:chapter/:verse", :controller => :verses, :action => :show, book: 58
  
  match "/James", :controller => :books, :action => :show, id: 59
  match "/James/:chapter", :controller => :chapters, :action => :show, book: 59
  match "/James/:chapter/:verse", :controller => :verses, :action => :show, book: 59

  # match "/1Peter", :controller => :books, :action => :show, id: 60
  match "/1Peter/:chapter", :controller => :chapters, :action => :show, book: 60
  match "/1Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 60
  
  match "/1%20Peter", :controller => :books, :action => :show, id: 60
  match "/1%20Peter/:chapter", :controller => :chapters, :action => :show, book: 60
  match "/1%20Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 60
  
  # match "/2Peter", :controller => :books, :action => :show, id: 61
  match "/2Peter/:chapter", :controller => :chapters, :action => :show, book: 61
  match "/2Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 61
  
  match "/2%20Peter", :controller => :books, :action => :show, id: 61
  match "/2%20Peter/:chapter", :controller => :chapters, :action => :show, book: 61
  match "/2%20Peter/:chapter/:verse", :controller => :verses, :action => :show, book: 61
  
  # match "/1John", :controller => :books, :action => :show, id: 62
  match "/1John/:chapter", :controller => :chapters, :action => :show, book: 62
  match "/1John/:chapter/:verse", :controller => :verses, :action => :show, book: 62
  
  match "/1%20John", :controller => :books, :action => :show, id: 62
  match "/1%20John/:chapter", :controller => :chapters, :action => :show, book: 62
  match "/1%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 62
  
  # match "/2John", :controller => :books, :action => :show, id: 63
  match "/2John/:chapter", :controller => :chapters, :action => :show, book: 63
  match "/2John/:chapter/:verse", :controller => :verses, :action => :show, book: 63
  
  match "/2%20John", :controller => :books, :action => :show, id: 63
  match "/2%20John/:chapter", :controller => :chapters, :action => :show, book: 63
  match "/2%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 63
  
  # match "/3John", :controller => :books, :action => :show, id: 64
  match "/3John/:chapter", :controller => :chapters, :action => :show, book: 64
  match "/3John/:chapter/:verse", :controller => :verses, :action => :show, book: 64
  
  match "/3%20John", :controller => :books, :action => :show, id: 64
  match "/3%20John/:chapter", :controller => :chapters, :action => :show, book: 64
  match "/3%20John/:chapter/:verse", :controller => :verses, :action => :show, book: 64
  
  match "/Jude", :controller => :books, :action => :show, id: 65
  match "/Jude/:chapter", :controller => :chapters, :action => :show, book: 65
  match "/Jude/:chapter/:verse", :controller => :verses, :action => :show, book: 65
  
  match "/Revelation", :controller => :books, :action => :show, id: 66
  match "/Revelation/:chapter", :controller => :chapters, :action => :show, book: 66
  match "/Revelation/:chapter/:verse", :controller => :verses, :action => :show, book: 66
  
  #should be changed later
  #root :to => something
  #right now there is a JS redirect on public/index.html
  
end
  