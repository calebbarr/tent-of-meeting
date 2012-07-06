var POLLING_INTERVAL = 4000;

$(document).ready(function(){
	checkBrowser();
	$( ".navigation_button" ).button();
	$( ".sidebar_button" ).button();
	$( ".user_navigation_menu_item" ).button();
	$( "#favorite_button" ).button();
	$("#strongs_dropdown")
					.button( {
						text: false,
						icons: {
							primary: "ui-icon-triangle-1-s"
						}
					}).parent().buttonset();
	clearFlash();
	var strongs_hover_config = {
		over: function(){rollDownStrongs();},
		timeout: 2500,
		out: function(){rollUpStrongs();}
	}
	$("#strongs_dropdown").hoverIntent(strongs_hover_config);
	setStage();
	setInterval("pollUsers()",POLLING_INTERVAL);
});

checkBrowser = function(){
	if(!($.browser.mozilla)){
			window.location.href = "/firefox_warning.html";
	}
}

pollUsers = function() {
	$.ajax(
		{
			url: "/nav/current_users.json"
		}
	).done(function(data){
		populateUsers(data);
	});
}

setStage = function(mode) {
	$.ajax({
		url: "/nav",
		type: "GET"
	}).done(function(nav_hash){		
		//if any other information needs to be
		// posted to nav, this can be refactored
		clearNavDirection();
		
		// it'd be nice if everything that consults the session could be
		// triggered from here
		var mode = nav_hash["mode"];
		var direction = nav_hash["direction"];
		var verse_id = nav_hash["verse"];
		var users = nav_hash["users"]
		data = {
			nt: nav_hash["nt"]
		}
		subscribe(verse_id);
		populateUsers(users);
		//should be last thing done:
		switch(mode){
			case "verse":
				bindLayoutButtons({view: "verse", data: data})
				switch(direction) {
					case "next":
						$("#stage").show("slide", { direction: "right" }, 500);
						break;
					case "prev":
						$("#stage").show("slide", { direction: "left" }, 500);
						break;
					case "random":
						$("#stage").show("explode");
						break;
					default:
						$("#stage").fadeIn("fast");
						break;
				}
				break;
			case "chapter":
				bindLayoutButtons({view: "chapter"})
				setChapterStage();
				switch(direction) {
					case "next":
						$("#stage").show("slide", { direction: "right" }, 500);
						break;
					case "prev":
						$("#stage").show("slide", { direction: "left" }, 500);
						break;
					default:
						$("#stage").show("blind");
						break;
				}
				break;
			case "book":
				bindLayoutButtons({view: "book"})
				setBookStage();
				switch(direction) {
					//different functionality can be added here later
					case "next":
						$("#stage").show("blind", 500);
						break;
					case "prev":
						$("#stage").show("blind", 500);
						break;
					default:
						$("#stage").show("blind", 500);
						break;
				}
				break;
			case "bible":
				bindLayoutButtons({view: "bible"})
				setBibleStage();
				$("#stage").show("scale", 500);
				break
			case "profile":
				bindLayoutButtons({view: "profile"});
				// different functionality can be added here later
				// idea is to get the user back to the Bible as quickly as possible
				setProfileStage();
				$("#stage").show("blind", 500);
				break;
			case "strongs":
				bindLayoutButtons({view: "strongs"});
				setProfileStage();
				// @TODO
				// this needs to be changed to setStrongsStage (to be written)
				$("#stage").show("blind", 500);
				break;
			case "search":
				//@TODO it'd be cool to do bindKeys("search") and be able to flip through
				// search results
				// layoutButtons, maybe, too
				bindLayoutButtons();
				$("#stage").show("scale", 500);
				break;
			default:
				bindLayoutButtons();
				$("#stage").fadeIn("fast");
				break;
		}
		
	});
}

populateUsers = function(users){
	var people = $("#people").html();
	var new_people = ""
	for(var i = 0; i < users.length; i++){
		user = users[i];
		var img = '';
		img += '<a ';
		img += 'href="/meet/'+user["name"]+'">'
		img += '<img id="'+user["name"]+'" src="'+user["thumb"]+'"';
		img += ' title="'+user["headline"]+'"';
		img += ">";
		img += "</a>"
		new_people += img;
		// $("#"+user["name"]).fadeIn("slow");
	}
	if(people.length == 8){ // 8 is currently the length of people when it is functionally blank
		$("#people").html(new_people);
	}else if(people != new_people){
		$("#people").html(new_people);
	} else {
		// else they're the same, no need to do anything... this might not be relevant if we include the 'since'
		 // information into every user's div... have to come up with new logic in that case
	}
}

/*
	specific functionality for viewing chapters
*/
setChapterStage = function() {
	$(".bible_verse_row").each(function() {
	  var row_name, verse_id;
	  verse_id = $(this).data("verse_id");
	  row_name = $(this).attr("id");
	  return $(this).hoverIntent((function() {
	    return highlightCurrVerse(row_name, verse_id);
	  }), function() {
	    return transitionFromCurrVerse(row_name);
	  });
	});
}

/*
	specific functionality for viewing Bible
*/
setBibleStage = function() {
	//none yet
}


/*
	specific functionality for viewing books
*/
setBookStage = function() {
	$("#book").accordion();
	expandChapter("1",null);
}

/*
	specific functionality for viewing profiles
*/
setProfileStage = function() {
	$("#audio_placeholder").hide();
	$("#audio").hide();
	$( "#tabs" ).tabs({
			collapsible: true
		});
	$("#favorite_verses").accordion();
}

clearNavDirection = function() {
	$.ajax({
		url: "/nav?direction=nil",
		type: "POST"
	});
}

bindLayoutButtons = function(buttonSettings){
	if(buttonSettings != undefined){
		if(buttonSettings["view"] != undefined){
			if(buttonSettings["view"] != undefined){
				if(buttonSettings["view"] == "bible"){
					bindStandardButtons();
					bindBookButtons();
					bindKeys("bible", "bible");
				}
				if(buttonSettings["view"] == "book"){
					bindStandardButtons();
					bindBookButtons();
					bindKeys("bible", "book");
				}
				else if(buttonSettings["view"] == "chapter"){
					bindStandardButtons();
					bindChapterButtons();
					bindKeys("bible", "chapter");
				}
				else if(buttonSettings["view"] == "verse"){
					bindStandardButtons();
					//bindVerseButtons();
					bindKeys("bible", "verse",buttonSettings["data"]);
				}
				else if(buttonSettings["view"] == "strongs"){
					bindKeys("strongs", "word");
				} else if(buttonSettings["view"] == "profile") {
					bindProfileButtons();
					bindKeys();
				}
			} else {
				bindStandardButtons();
				bindKeys();
			}
		}else {
			bindStandardButtons();
			bindKeys();
		}
	} else{
		bindStandardButtons();
		bindKeys();
	}
}

bindStandardButtons = function() {
	$("#sidebar_button_1").attr("onClick","toggle_audio()")
}
rollDownStrongs = function() {
	$.ajax().done(function(){
		$(".browse_strongs").slideDown("fast");
	});
	$("#stage").fadeOut("fast")
}

rollUpStrongs = function() {
	$.ajax().done(function(){
		$("#stage").fadeIn("fast")
	});
	$(".browse_strongs").slideUp("fast");
}

displayStrongs = function() {
	$(".browse_strongs").show();
}

bindProfileButtons = function() {
	// @TODO change audio button
	$("#sidebar_button_1").off();
	//$("#sidebar_button_1").click(function(){alert('what up')});
	// @TODO change favorite button
}

bindChapterButtons = function(){
	$("#skip_forward_nav").attr("onClick",'next_chapter("chapter");');
	$("#skip_backward_nav").attr("onClick",'prev_chapter("chapter");');
	$("#down_arrow_nav").attr("onClick",'next_book("chapter");');
	$("#up_arrow_nav").attr("onClick",'prev_book("chapter");');
}

bindBookButtons = function(){
	$("#skip_forward_nav").attr("onClick",'next_chapter("chapter");');
	$("#skip_backward_nav").attr("onClick",'prev_chapter("chapter");');
	$("#down_arrow_nav").attr("onClick",'next_book("book");');
	$("#up_arrow_nav").attr("onClick",'prev_book("book");');
}

/*
	binds keypresses to navigation functionality
	mode = e.g. bible, strongs, search
	mode2 = e.g. book, chapter, verse
*/
bindKeys = function(mode,mode2,data){
	bibleMode = false;
	// this hack is only to get random_verse()
	// to be called while the person is doing shift + up
	// while viewing the whole Bible
	if(mode2 == "bible"){
		bibleMode = true;
		mode2="book";
		//changes mode2 back to "book", because all that behavior should be the same
	}
	switch(mode){
		case "strongs":
			//@TODO do rest of strongs keyboard functionality
			$(document).keydown(function(e){
				//down arrow
			    if (e.keyCode == 40) {
					if(e.shiftKey){
							curr_verse();//should be random strongs word
					}else {
						curr_verse();
					}
				}
			       return false;
			    });
			//@TODO do rest of strongs keyboard functionality
			break;
		default: // case "bible":
			$(document).keydown(function(e){
				//left arrow
			    if (e.keyCode == 37) {
					if(e.shiftKey){
						mode2 != null ? prev_chapter(mode2) : prev_chapter();
					} else {
						mode2 != null ? prev_verse(mode2) : prev_verse();
					}
			    return false;
			    }
				//right arrow
			    if (e.keyCode == 39) {
					if(e.shiftKey){
						mode2 != null ? next_chapter(mode2) : next_chapter();
					 }else {
						mode2 != null ? next_verse(mode2) : next_verse();
					}
			       return false;
			    }
				//up arrow
			    if (e.keyCode == 38) {
					if(e.shiftKey){
						if(mode2 != null){
							switch(mode2){
								case "verse":
									curr_chapter();
									break;
								case "chapter":
									curr_book();
									break;
								case "book":
									bibleMode ? random_verse() : bible();
									break;
								default: //case "verse":
									curr_chapter();
									break;
							}
						} else {
							curr_chapter();
						}
					 }else {
						mode2 != null ? prev_book(mode2)  : prev_book();
				}
			       return false;
			    }
				//down arrow
			    if (e.keyCode == 40) {
					if(e.shiftKey){
						if(mode2 != null){
							switch(mode2){
								case "verse":
									if(e.ctrlKey){
										toggle_original_language(data["nt"]);
									}else{
										random_verse();
									}
									break;
								case "chapter":
									curr_verse();
									break;
								case "book":
									curr_chapter();
									break;
								default: 
									random_verse();
									break;
							}
						} else {
							curr_verse();
						}
					 }else {
						mode2 != null ? next_book(mode2) : next_book();	
				}
			       return false;
			    }
			});
	}
}

bible = function(){
	url = "/Bible"
	window.location.href = url;
}

prev_book = function(mode){
	url = "/books/prev";
	if(mode != null){
		url+="?mode="+mode
	}
	window.location.href = url;
}

curr_book = function(){
	url = "/books/current";
	window.location.href = url;
}

next_book = function(mode){
	url = "/books/next";
	if(mode != null){
		url+="?mode="+mode
	}
	window.location.href = url;
}

prev_chapter = function(mode){
	url = "/chapters/prev";
	if(mode != null){
		url+="?mode="+mode
	}
	window.location.href = url;
}

curr_chapter = function(){
	url = "/chapters/current";
	window.location.href = url;
}


next_chapter = function(mode){
	var url = "/chapters/next"
	if(mode != null){
		url+="?mode="+mode
	}
	window.location.href = url;
}

prev_verse = function(){
	window.location.href = "/verses/prev";
}

curr_verse = function(){
	url = "/verses/current";
	window.location.href = url;
}

next_verse = function(){
	window.location.href = "/verses/next";
}

random_verse = function(){
	window.location.href = "/verses/random";
}

toggle_audio = function() {
	// creative use of ajax to make a "ker-snap" visual effect
	// @TODO remove, dont need more requests coming in than necessary
	if( $("#audio").is(":visible") ){
		$.ajax().done(function(){
			$("#audio").slideUp("fast");
		});
		$("#audio_placeholder").slideDown("slow");
	} else {
		$.ajax().done(function(){
			$("#audio_placeholder").slideUp("fast");
		});
		$("#audio").slideDown("slow");
	}
}

show_related = function(id) {
	url = "/verses/related.json?verse="+id
	$("#related").html("<img src='http://localhost:3000/loader2.gif'></img>");
	$.ajax(url).done(function(related){
		var related_table = "<table>";
		if(related.length == 0){
			$("#related").html("No related verses yet");
		} else {
			for(var i = 0; i < related.length; i++){
				var related = related[i]
				related_table +="<tr class='bible_verse_row', onclick=\"location.href='"+ related["path"] + "\'\">";
				related_table +="<td>";
				related_table += related["link"]
				related_table +="</td>";
				related_table +="<td>";
				related_table += related["content"]
				related_table +="</td>";
				related_table +="</tr>";
			}
			related_table+="</table>";
			$("#related").html(related_table);	
		}
	});
	
	$("#related").dialog({position:['center',260],height: 200, width: 550});
}

// toggleFavorite = function(verse_id, user_id, is_favorite){
// 	url = is_favorite? "/verses/favorites/delete/"+verse_id : "/verses/favorites/add/"+verse_id;
// 	$.ajax(url);
// 	// the title of the favorite link might not have changed
// }

toggleFavorite = function(id) {
	url = "/verses/favorite?id="+id
	$.ajax(url);
}

memorize = function(id) {
	url = "/memorize?id="+id
	window.location.href = url;
}


showNotes = function(id) {
	var url = "/notes/show?verse_id="+id
	window.location.href = url;
}

/*
   NOTE:  NOT CURRENTLY BEING USED
*/
deleteNote = function(id){
	url = "/notes/delete.json?id="+id;
	$("#delete_note_"+id).parent().parent().remove();
	$.ajax(url);
}

verseNotes = function(verse_id, new_note){	
	var showNotes = function(){
		var path ="/notes/show.json?verse_id="+verse_id;
		$.ajax(path).done(function(notes){
			var div_content = "<table>";
			for(var i = 0; i < notes.length; i++){
				div_content += "<tr class='note_row'>";
				var note = notes[i];
				div_content += "<td>";
				div_content += "<b>"
				div_content += note["name"];
				div_content += "</b>"
				div_content += "</td>";
				div_content += "<td>";
				div_content += note["content"];
				div_content += "</td>";
				div_content += "<td style:'float:top'>";
				div_content += "<img id='delete_note_"+note["id"]+"' onClick='deleteNote("+note["id"]+")' src='http://cbarr.dyndns.org/close_x.gif'/>"
				div_content += "</td>";
				// div_content += "<td>";
				// div_content += note["created_at"];
				// div_content += "</td>";
				// div_content += "<td>";
				// div_content += note["id"];
				// div_content += "</td>";
				// div_content += "<td>";
				// div_content += note["updated_at"];
				// div_content += "</td>";
				//user_id
				//verse_id
				div_content += "</tr>";
			}
			
			div_content +="</table>";
			$("#verse_notes").html(div_content);
		});
		return "<img src='http://localhost:3000/loader2.gif'></img>";
	};
	
	$("#verse_notes").html(new_note ? "<h3> new note: </h3> <form accept-charset='UTF-8' action='/notes' class='new_note' id='new_note' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /></div> <label for='note_name'>Name</label> <br> <input id='note_name' name='note[name]' size='30' type='text' /> <br> <label for='note_content'>Content</label> <br> <textarea cols='40' id='note_content' name='note[content]' rows='20'></textarea> <br> <input id='note_verse_id' name='note[verse_id]' type='hidden' value='1' /> <!-- the 1 here is just a stand-in for session-based code if not authenticated --> <input id='note_user_id' name='note[user_id]' type='hidden' value='1' /> <input name='commit' type='submit' value='Create Note' /> <br> </form>	</div>" : showNotes());
	$("#verse_notes").dialog({position:['center',330], height: 200});
}

quiz = function(id){
	// this is kind of loopy
	// its checking to see if it has quiz here
	// but when setCurrVerse is called that data is available to it
	// the below makes sense in verse mode, but not in chapter
	// @TODO sync up this functionality
	url = "/verses/quiz?id="+id;
	window.location.href = url;
}

toggle_original_language = function(nt){
	var url = nt ? "/verses/toggle_original_languages.json?nt=true" : "/verses/toggle_original_languages.json?nt=false";
	//@TODO
	//for some reason .done() is is not working?  need to fix
	$.ajax(url).error(function(){
		// $("#stage").load();
		//@TODO
		//this needs to be redone with ajax on the div only, rather than refreshing the page
		var currPath = $(location).attr('pathname').replace(/%20/g," ");
		$.ajax({
			url : "/nav",
			type : "GET"
		}).done(function(data){
			if( currPath != data["path"]){
				window.location.href = data["path"];
				$("#stage").fadeOut('fast');
			} else {
				location.reload(true);
				$("#stage").fadeOut('fast');
			}
		});		
	});
}


browseStrongs = function() {
	window.location.href = "/strongs";	
}

profile = function() {
	window.location.href = "/profile";	
}

settings = function() {
	window.location.href = "/profile/settings";	
}

login = function(url) {
	$.ajax({
		url: url,
		type: "GET"
	}).done(function(){
		window.location.href = url;	
	});
}

logout = function(url) {
	$.ajax({
		url: url,
		type: "DELETE"
	}).done(function(){
		window.location.href = "/";
	});
}

highlightCurrVerse = function(name, id){
	$(".highlighted_bible_verse_row").each(function(){
		$(this).removeClass("highlighted_bible_verse_row")
		$(this).addClass("bible_verse_row")
		//for some reason this isn't working
		// $(this).switchClass("highlighted_bible_verse_row", "bible_verse_row", 200)
	});
	$("#"+name).switchClass("bible_verse_row", "highlighted_bible_verse_row", 200)
	setCurrVerse(id);
}

transitionFromCurrVerse = function(row_name){
	//maybe do something graphical later
	// $("#"+row_name).removeClass("highlighted_bible_verse_row")
	// $("#"+row_name).addClass("bible_verse_row")
	//$("#"+name).switchClass("highlighted_bible_verse_row", "bible_verse_row", 200)
	// $("#"+row_name).removeClass("highlighted_bible_verse_row")
}

setCurrVerse = function(id){
	var url = "/verses/current.json?id="+id;
	$.ajax({
		url: url,
		type: "POST"
		}).done(function(data){
			populateUsers(data["users"]);
			button_data = {
				"favorite" : data["favorite"],
				"has_quiz" : data["quiz"]
			}
			updateButtons(id,button_data);
			$("#channel").html(data["link"]);
			$("#chat_room").fadeOut("slow").html("").show();
		});
		
		updateButtons = function(id,data) {
			$("#related_button").attr("onClick","show_related("+id+");");
			$("#notes_button").attr("onClick","showNotes("+id+");");
			$("#quiz_button").attr("onClick","quiz("+id+");");
			if(data["quiz"]){
				$("#quiz_button").attr("title", "take quiz");
			}else{
				$("#quiz_button").attr("title", "create quiz");
			}
			$("#memorize_button").attr("onClick","memorize("+id+");");
			$("#favorite_button").attr("onClick","toggleFavorite("+id+");");
			$("#favorite_button").prop("checked", data["favorite"]);
			$("#favorite_button").button("refresh");
		}
		
}

setCurrChapter = function(chapter_id){
	if(chapter_id != null){
		var url = "/chapters/current.json?id="+id;
		$.ajax({
			url: url,
			type: "POST"
			}).done(function(data){
				$("#channel").html(data["link"]);
				$("#chat_room").fadeOut("slow").html("").show();
			});
	} else {
		//not sure if there is any functionality needed
		// somehow, probably through the navigation controller filters
		// chapter is getting set correctly
	}
}

expandChapter = function(chapter_name,chapter_id) {
	//re-show all the other chapter_id_previews
	$(".chapter_preview").show();
	//hide this one
	$("#chapter_"+chapter_name+"_preview").hide();
	//set chapter
	setCurrChapter(chapter_id);
}

clearFlash = function() {
	$("#flash").fadeIn("slow").delay(2500).fadeOut("slow");
}

showPasswordFields = function(){
	$("#change_password_expand").remove();
	$(".change_password_field").show("blind");
}