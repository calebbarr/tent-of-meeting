Array.prototype.shuffle = function (){ 
	for(var rnd, tmp, i=this.length; i; rnd=parseInt(Math.random()*i), tmp=this[--i], this[i]=this[rnd], this[rnd]=tmp);
	};
	Array.prototype.removeValue = function(val) {
	for(var i=0; i<this.length; i++) {
		if(this[i] == val) {
			this.splice(i, 1);
			break;
		}
	}
};

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}

String.prototype.ltrim = function() {
	return this.replace(/^\s+/,"");
}

String.prototype.rtrim = function() {
	return this.replace(/\s+$/,"");
}

Array.prototype.removeValue = function(val) {
  var i, _results;
  i = 0;
  _results = [];
  while (i < this.length) {
    if (this[i] === val) {
      this.splice(i, 1);
      break;
    }
    _results.push(i++);
  }
  return _results;
};
