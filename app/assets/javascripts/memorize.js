var index = 0
var remove = 3
var not_removed = [];
victory_round = false;

memorizeGame = {
	id: -1
}

function writeVerse(verse) {
	words = verse.split(" ");
	remove = words.length /5
	for(var i = 0; i < words.length; i++){
		var wordSpan = "<span onclick='toggleHide("+i+")' id='word"+i+"'>"+words[i]+" "+"</span>";
		$('#verse_text').append(wordSpan);
		not_removed.push(i);
	}
	not_removed.shuffle();
	$('#word'+0).toggleClass('highlighted');
}

function removeWords(){
	if(victory_round == true){
		window.location.href = "/memorize/next";
		//do some Ajax
	}
	limit = remove
	if(not_removed.length <= remove){
		limit = not_removed.length;
		victory_round = true;
	}
	for(var i = 0; i < limit; i++){
		var remove_index = not_removed.pop();
		var removed_word = $('#word'+remove_index).html();
		$('#word'+remove_index).addClass("hidden");
	}
	index = 0;
	$('#word'+0).addClass("highlighted")
}

function toggleHide(id){
	if($('#word'+id).hasClass('hidden')){
		not_removed.push(id);
		not_removed.shuffle();
		victory_round = false
	} else {
		not_removed.removeValue(id);
		if(not_removed.length == words.length){
			victory_round = true;
		}
	}
	$('#word'+id).toggleClass('hidden');
}

function processInput(){
	var typed_words = $("#type_verse").val().split(" ");
	var typed_index = 0;
	$("#type_verse").val("");
	for(var i = 0; i < typed_words.length; i++){
		var typed_word = typed_words[i]
		var verse_word = words[index]
		if(typed_word.toLowerCase().replace(/[^A-Za-z0-9]/g,"") == verse_word.toLowerCase().replace(/[^A-Za-z0-9]/g,"")){ //change to ignore case and punctuation
			$('#word'+index).removeClass('highlighted');
			if(index == words.length-1){
				removeWords();
			} else{
				index +=1;
				$('#word'+index).addClass('highlighted');
			}
		}
	}
}