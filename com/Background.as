package com
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.easing.Linear;
	import flash.display.DisplayObject;
	import com.*;


	public class Background extends MovieClip
	{

		public var scrollSpeed:int = 2;
		public var bg1:backGround1;
		public var bg2:backGround2;

		public function Background():void
		{
			trace('Background INITIALIZED');

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void
		{

			bg1 = new backGround1();
			bg2 = new backGround2();

			addChild(bg1);
			bg1.x = 0;
			bg1.y = 600;

			addChild(bg2);
			bg2.x = bg1.width;
			bg2.y = 600;

			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{

			bg1.x -=  scrollSpeed;
			bg2.x -=  scrollSpeed;

			if (bg1.x < -1999)
			{
				bg1.x +=  3998;
			}
			if (bg2.x < -1999)
			{
				bg2.x +=  3998;
			}
		}
	}
}