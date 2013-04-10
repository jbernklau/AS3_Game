package com  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.*
	import com.greensock.plugins.*;
	
	public class FlyingBoss extends MovieClip {
		
		//private var flyBoss:MovieClip = new FlyingBoss();
		private var pow = new Kapow;

		public function FlyingBoss() {
			trace('Boss init');
			// constructor code
			//addChild(flyBoss);
			
			//x = stage.stageWidth + Math.round(Math.random()*(2000 - stage.stageWidth)); //Random x position
			//y = 0 + Math.round(Math.random()*(stage.stageHeight - 0)); //Random y position;			
			addEventListener(Event.ENTER_FRAME, loop);			
		}
		
		private function loop(e:Event):void{
			
		}
		
		public function enemyCantFire():void {
			enemyCanFire = false;
		}
		
		private function removeSelf():void {
			removeEventListener(Event.ENTER_FRAME, update);
 
			if (stage.contains(this))
				stage.removeChild(this);
		}
		
		public function removeEnemyShooter() : void
		{
			removeSelf();
			
		}

	}
	
}
