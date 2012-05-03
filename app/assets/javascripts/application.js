// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

bindLayoutButtons = function(buttonSettings){
	if(buttonSettings != undefined){
		if(buttonSettings["audio"] != undefined){
			bind_audio_button(buttonSettings["audio"])
		}	
	}
}

bind_audio_button = function(mode){
	if(mode === "verse"){
		// also need to set image? through .html("img src")??
		$("#sidebar_button_1").click("show_verse_audio();");
	} else if(mode === "chapter"){
		$("#sidebar_button_1").attr("onClick","show_chapter_audio();");
	}
}

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

show_chapter_audio = function() {
	$("#chapter_audio").dialog({position:['center',330], height: 100});
}


show_related = function(id) {
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
				div_content += "<img id='delete"+note["id"]+"' onClick='deleteNote("+note["id"]+")' src='http://cbarr.dyndns.org/close_x.gif'/>"
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
		return "<img src='http://cbarr.dyndns.org/loader2.gif'></img>";
	};
	
	$("#verse_notes").html(new_note ? "<h3> new note: </h3> <form accept-charset='UTF-8' action='/notes' class='new_note' id='new_note' method='post'><div style='margin:0;padding:0;display:inline'><input name='utf8' type='hidden' value='&#x2713;' /></div> <label for='note_name'>Name</label> <br> <input id='note_name' name='note[name]' size='30' type='text' /> <br> <label for='note_content'>Content</label> <br> <textarea cols='40' id='note_content' name='note[content]' rows='20'></textarea> <br> <input id='note_verse_id' name='note[verse_id]' type='hidden' value='1' /> <!-- the 1 here is just a stand-in for session-based code if not authenticated --> <input id='note_user_id' name='note[user_id]' type='hidden' value='1' /> <input name='commit' type='submit' value='Create Note' /> <br> </form>	</div>" : showNotes());
	$("#verse_notes").dialog({position:['center',330], height: 200});
}

quiz = function(url){
	window.location.href = url;	
}
