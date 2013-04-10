package com {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip{
		// Properties
		private var bulletSpeed:int;
		private var initialX:int;
		private var gfx:MovieClip = new Bullet_gfx;
	 	
		public function Bullet(playerX:int, playerY:int, playerDirection:String) {	
			
			if(playerDirection == "left"){
				bulletSpeed = -16;
				x = playerX - 15;
			}else if(playerDirection == "right"){
				bulletSpeed = 15;
				x = playerX + 90;
			}		
			
			y = playerY - 10;
			addEventListener(Event.ENTER_FRAME, loop);			
		}
		
		public function loop(e:Event):void{
			addChild(gfx); 
			x += bulletSpeed;
			
			this.rotation += 5;  			
			
			// Remove bullet off stage if it reaches 600pixel(Change if you like)
			if(bulletSpeed > 0) { 
				if(x > initialX + 1000) { 
					removeChild(gfx);
				}
			} else { 
				if(x < initialX) {
					removeChild(gfx);
				}
			}
		}
	}	
}

//http://www.newgrounds.com/bbs/topic/1305215
