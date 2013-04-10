package com
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.motion.easing.Linear;
	import flash.display.DisplayObject;
	import com.*;


	public class FinalLevelBackground extends MovieClip
	{
		
		private var bg1:FinalLevel;

		public function FinalLevelBackground():void
		{
			trace('Background INITIALIZED');

			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event):void
		{

			bg1 = new FinalLevel();

			addChild(bg1);
			bg1.x = 477;
			bg1.y = 320;

		}
	}
}