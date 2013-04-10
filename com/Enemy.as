package com {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Enemy extends MovieClip {
		private var speed:int;
		private var gfx:MovieClip = new BirdEnemy;
		
		public function Enemy() {
			// constructor code
			addChild(gfx);
			speed = 5;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void{
			x = x + -speed;
			
			if(x < -250){
				x = Main.STAGE_WIDTH + Math.round(Math.random()*(2000 - Main.STAGE_WIDTH)); //Random x position
				y = 0 + Math.round(Math.random()*(Main.STAGE_HEIGHT - 0)); //Random y position
			}
			
		}
		
		private function removeSelf():void {
			removeEventListener(Event.ENTER_FRAME, update);
 
			if (stage.contains(this))
				stage.removeChild(this);
		}
		
		public function takeHit() : void
		{
			removeSelf();
		}

	}
	
}
