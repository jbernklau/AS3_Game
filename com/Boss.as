package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*;
	import com.greensock.plugins.*;

	public class Boss extends MovieClip
	{

		private var gfx:MovieClip = new Boss_gfx  ;
		public function Boss()
		{
			// constructor code
			addChild(gfx);
			x = 1800;
			y = 450;

			//Need to position KAPOW on boss
			//pow.x = ?


			addEventListener(Event.ENTER_FRAME, loop);
		}

		private function loop(e:Event):void
		{
			this.rotation = Math.random() * 3;
		}

		public function hit():void
		{

			//addChild(pow);

			//TweenLite.to(pow, 100, {alpha:0});

			/*TweenLite.killTweensOf(pow);
			removeChild(pow);*/
		}


		public function removeBoss():void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(gfx);
		}
	}

}