(function(window) {
player = function() {
	this.initialize();
}
player._SpriteSheet = new SpriteSheet({images: ["CharSheet.png"], frames: [[2,198,119,45,0,55,18.85],[123,198,119,45,0,55,18.85],[244,198,119,45,0,55,18.85],[365,198,119,45,0,55,18.85],[2,245,119,45,0,55,18.85],[123,245,119,45,0,55,18.85],[244,245,119,45,0,55,18.85],[365,245,119,45,0,55,18.85],[2,2,119,47,0,55,24.85],[123,2,119,47,0,55,24.85],[244,2,119,47,0,55,24.85],[365,2,119,47,0,55,24.85],[2,51,119,47,0,55,24.85],[123,51,119,47,0,55,24.85],[244,51,119,47,0,55,24.85],[365,51,119,47,0,55,24.85],[2,292,119,45,0,55,18.85],[123,292,119,45,0,55,18.85],[244,292,119,45,0,55,18.85],[365,292,119,45,0,55,18.85],[2,339,119,45,0,55,18.85],[123,339,119,45,0,55,18.85],[244,339,119,45,0,55,18.85],[365,339,119,45,0,55,18.85],[2,100,119,47,0,55,24.85],[123,100,119,47,0,55,24.85],[244,100,119,47,0,55,24.85],[365,100,119,47,0,55,24.85],[2,149,119,47,0,55,24.85],[123,149,119,47,0,55,24.85],[244,149,119,47,0,55,24.85],[365,149,119,47,0,55,24.85]]});
var player_p = player.prototype = new BitmapAnimation();
player_p.BitmapAnimation_initialize = player_p.initialize;
player_p.initialize = function() {
	this.BitmapAnimation_initialize(player._SpriteSheet);
	this.paused = false;
}
window.player = player;
}(window));

