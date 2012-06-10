// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
	bindLayoutButtons(); //should have code to get the object, ... maybe defaults should just be here and this shouldn't be called
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
});

bindLayoutButtons = function(buttonSettings){
	if(buttonSettings != undefined){
		// if(buttonSettings["audio"] != undefined){
		// 	bind_audio_button(buttonSettings["audio"])
		// }
		if(buttonSettings["view"] != undefined){
			if(buttonSettings["view"] != undefined){
				if(buttonSettings["view"] == "book"){
					bindBookButtons();
				}
				else if(buttonSettings["view"] == "chapter"){
					bindChapterButtons();
				}
				else if(buttonSettings["view"] == "verse"){
					bindVerseButtons();
				}
			}
		}	
	}
}

bindChapterButtons = function(){
	// alert($("#skip_forward_nav").attr("onClick"));
	// $.ajax( {url: "/nav?mode=chapter", method: "POST" } )
	$("#skip_forward_nav").attr("onClick",'next_chapter("chapter");');
	$("#skip_backward_nav").attr("onClick",'prev_chapter("chapter");');
	$("#down_arrow_nav").attr("onClick",'next_book("chapter");');
	$("#up_arrow_nav").attr("onClick",'prev_book("chapter");');
}

bindBookButtons = function(){
	// alert($("#skip_forward_nav").attr("onClick"));
	$("#skip_forward_nav").attr("onClick",'next_chapter("chapter");');
	$("#skip_backward_nav").attr("onClick",'prev_chapter("chapter");');
	$("#down_arrow_nav").attr("onClick",'next_book("book");');
	$("#up_arrow_nav").attr("onClick",'prev_book("book");');
}

// bind_audio_button = function(mode){
// 	if(mode === "verse"){
// 		// also need to set image? through .html("img src")??
// 		$("#sidebar_button_1").click("show_verse_audio();");
// 	} else if(mode === "chapter"){
// 		$("#sidebar_button_1").attr("onClick","show_chapter_audio();");
// 	} else if(mode === "book"){
// 		$("#sidebar_button_1").attr("onClick","show_book_audio();");
// 	}
// }

prev_book = function(mode){
	url = "/books/prev";
	if(mode != null){
		url+="?mode="+mode
	}
	// alert($("#skip_forward_nav").attr("onClick"));
	window.location.href = url;
}
next_book = function(mode){
	url = "/books/next";
	if(mode != null){
		url+="?mode="+mode
	}
	// alert($("#skip_forward_nav").attr("onClick"));
	window.location.href = url;
}

prev_chapter = function(mode){
	url = "/chapters/prev";
	if(mode != null){
		url+="?mode="+mode
	}
	// alert($("#skip_forward_nav").attr("onClick"));
	window.location.href = url;
}

next_chapter = function(mode){
	var url = "/chapters/next"
	if(mode != null){
		url+="?mode="+mode
	}
	// alert($("#skip_forward_nav").attr("onClick"));
	window.location.href = url;
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

toggle_audio = function() {
	$("#audio").toggle();
	$("#audio_placeholder").toggle();
}

// show_verse_audio = function() {
// 	$("#verse_audio").dialog({position:['center',330], height: 100});
// }

// show_chapter_audio = function() {
// 	$("#chapter_audio").dialog({position:['center',330], height: 100});
// }

// show_book_audio = function() {
// 	$("#book_audio").dialog({position:['center',330], height: 100});
// }


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

toggleFavorite = function(verse_id, user_id, is_favorite){
	url = is_favorite? "/verses/favorites/delete/"+verse_id : "/verses/favorites/add/"+verse_id;
	$.ajax(url);
	// the title of the favorite link might not have changed
}

memorize = function(url) {
	window.location.href = url;
}

verseNotes = function(verse_id, new_note){
	
	deleteNote = function(id){
		url = "/notes/delete?id="+id;
		$("#delete"+id).parent().parent().remove();
		$.ajax(url);
	}
	
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
				div_content += "<img id='delete"+note["id"]+"' onClick='deleteNote("+note["id"]+")' src='http://localhost:3000/close_x.gif'/>"
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

quiz = function(url){
	window.location.href = url;	
}


// toggle_original_language = function(nt){
// 	var url = nt ? "/verses/toggle_original_languages.json?nt=true" : "/verses/toggle_original_languages.json?nt=false";
// 	//@TODO
// 	//for some reason .done() is is not working?  need to fix
// 	$.ajax(url).error(function(){
// 		// $("#stage").load();
// 		//@TODO
// 		//this needs to be redone with ajax on the div only, rather than refreshing the page
// 		location.reload(true);
// 		$("#stage").fadeOut('fast');
// 	});
// }

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
			method : "GET"
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
			$("#related_button").attr("onClick","show_related("+id+");")
			$("#channel").html(data["link"]);
			$("#chat_room").fadeOut("slow").html("").show();
		});
}

setCurrChapter = function(id){
	var url = "/chapters/current.json?id="+id;
	$.ajax({
		url: url,
		type: "POST"
		}).done(function(data){
			$("#channel").html(data["link"]);
			$("#chat_room").fadeOut("slow").html("").show();
		});
}

expandChapter = function(name,id) {
	//re-show all the other chapter_id_previews
	$(".chapter_preview").show();
	//hide this one
	$("#chapter_"+name+"_preview").hide();
	//set chapter
	setCurrChapter(id);
}

clearFlash = function() {
	$("#flash").fadeIn("slow").delay(2500).fadeOut("slow");
}