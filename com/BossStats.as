package com  {
	
	public class BossStats{
		private var HP:Number;
		private var speed:Number;
		private var vx:Number;
		private var vy:Number;
		private var gravity:Number;
		private var canJump:Boolean;

		public function BossStats() {
			// constructor code
			
			// Set properties
			HP = 100;
			speed = 0;
			vx = 0;
			vy = 0;
			gravity = 0;
			canJump = false;
			
			// Set position
			x = Main.STAGE_WIDTH/2;
			y = Main.STAGE_HEIGHT;
		}
		
		public function dead():void { 
			if (stage.contains(this)){
				stage.removeChild(this);
			}				
		}
	}	
}
