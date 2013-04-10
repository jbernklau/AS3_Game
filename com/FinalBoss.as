package com {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.*;
	
	
	public class FinalBoss extends MovieClip {
		var gfx1:MovieClip = new FinalBoss1;
		var gfx2:MovieClip = new FinalBoss2;
		var gfxGun:MovieClip = new FinalBossGun;
		private var numBullets:Number = 3;
		private var spread = 5;
		//private var canShoot:Boolean=false;
		
		
		public function FinalBoss() {
			// constructor code
			trace('finalboss on stage');
			addChild(gfx1);
			gfx1.x = 700;
			gfx1.y = Main.STAGE_HEIGHT/2;
			addChild(gfxGun);
			gfxGun.x = 825;
			gfxGun.y = 405;
			
		}
		
		
		public function fartBomb():void{
			addChild(gfx2);
		}
	}	
}
