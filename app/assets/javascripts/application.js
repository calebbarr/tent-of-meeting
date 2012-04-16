// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
prev_book = function(){
	window.location.href = "/books/prev";
}
next_book = function(){
	window.location.href = "/books/next";
}

prev_chapter = function(){
	window.location.href = "/chapters/prev";
}

next_chapter = function(){
	window.location.href = "/chapters/next";
}

prev_verse = function(){
	window.location.href = "/verses/prev";
}
next_verse = function(){
	window.location.href = "/verses/next";
}
random_verse = function(){
	window.location.href = "/verses/random";
}

show_verse_audio = function() {
	$("#verse_audio").dialog({position:['center',330], height: 100});
}