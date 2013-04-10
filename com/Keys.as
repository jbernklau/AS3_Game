package com {
	
	import flash.events.KeyboardEvent;
	
	public class Keys {
		private var press_left = false;
		private var press_right = false;
		private var press_up = false;
		private var press_down = false;
		private var press_space = false;
		
		public function Keys(movieclip) {
			movieclip.stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			movieclip.stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
		}
		
		public function is_left() {
			return press_left;
		}
		
		public function is_right() {
			return press_right;
		}
		
		public function is_up() {
			return press_up;
		}
		
		public function is_down() {
			return press_down;
		}
		
		public function is_space() {
			return press_space;
		}
		
		private function key_down(event:KeyboardEvent) {
			if (event.keyCode == 32) {
				press_space = true;
			}
			if (event.keyCode == 37) {
				press_left = true;
			}
			if (event.keyCode == 38) {
				press_up = true;
			}
			if (event.keyCode == 39) {
				press_right = true;
			}
			if (event.keyCode == 40) {
				press_down = true;
			}
		}
		
		private function key_up(event:KeyboardEvent) {
			if (event.keyCode == 32) {
				press_space = false;
			}
			if (event.keyCode == 37) {
				press_left = false;
			}
			if (event.keyCode == 38) {
				press_up = false;
			}
			if (event.keyCode == 39) {
				press_right = false;
			}
			if (event.keyCode == 40) {
				press_down = false;
			}
		}
	}
}