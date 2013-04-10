package com  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.easing.Linear;
	import flash.display.DisplayObject;
	import com.*;
	
	
	public class Background2 extends MovieClip{
		
		public var scrollSpeed:int = 2;
		public var bg1:BGTwo;
		public var bg2:BGTwo;
		

		public function Background2():void {
			trace('Background INITIALIZED');			
			
			 addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event):void{		
			
			bg1 = new BGTwo();
			bg2 = new BGTwo();
			
			addChild(bg1);
			addChild(bg2);
			
			bg1.x = 0;
			bg2.x = bg1.width;
			//bg1.y = 600;
			//bg2.y = 600;			
			
			stage.addEventListener(Event.ENTER_FRAME, update);			
		}
		
		private function update(e:Event):void{
			
			bg1.x -= scrollSpeed;
			bg2.x -= scrollSpeed;
			
			if(bg1.x < -bg1.width){
				bg1.x = bg1.width;
			}else if(bg2.x < -bg2.width){
				bg2.x = bg2.width;
			}
		}
	}
}

