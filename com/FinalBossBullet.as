package com
{

	import flash.display.Sprite;
	import flash.events.Event;
	import com.*;


	public class FinalBossBullet extends MovieClip
	{
		private var speed:int;
		private var initialX:int = 500;
		var gfxBullet:MovieClip = new FinalBossBullet;

		public function FinalBossBullet(playerX:int, playerY:int)
		{
			// constructor code
			trace("boss bullet init");
			addChild(gfxBullet);
			speed = 10;
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			x +=  speed;

			if (speed > 0)
			{
				if (x > initialX + 700)
				{
					removeBullet();
				}
			}
			else
			{
				if (x < initialX - 700)
				{
					removeBullet();
				}
			}
		}
	}

}