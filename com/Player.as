//Need to change player registration point for turning smoother

package com  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Player extends MovieClip {
		private var x_speed:Number;
		private var y_speed:Number;
		private var power:Number;
		private var friction:Number;
		private var gravity:Number;
		private var stopGravity:Number;
		private var canJump:Boolean;
		private var yVelocity:Number;
		private var jumpPower:Number;
		var playerHalfWidth:Number = width / 2 + 10; 
		var playerHalfHeight:Number = height / 2; 
		var gfx:MovieClip = new Player_gfx;
		var gfx2:MovieClip = new DeadPlayer();
		
		
		public function Player() {
			// constructor code
			addChild(gfx);			
			canJump = false;
			jumpPower = 30;
			yVelocity = -10;
			gravity = 1;
			power = 2.5;
			friction = 0.75;
			x_speed = 0;
			y_speed = 0;
			x = 150;
			y = 300;
			
			trace('player class init');
			addEventListener(Event.ENTER_FRAME, movement);
		}
		
		private function movement(event:Event):void{
			
			if (x + playerHalfWidth > Main.STAGE_WIDTH) 
			{
       			x = Main.STAGE_WIDTH - playerHalfWidth;
  			}
			else if (x -  playerHalfWidth < 0) 
			{
				x = 0 + playerHalfWidth;   
	        }
			if (y + playerHalfHeight > Main.STAGE_HEIGHT) 
			{
	            y = Main.STAGE_HEIGHT - playerHalfHeight;
	        }
			else if (y -  playerHalfHeight < 0) 
			{
				y = 0 + playerHalfHeight;   
	        }
			
			x+=x_speed;
			y+=y_speed;
			y_speed += gravity;
			x_speed *= friction;
			y_speed *= friction;
		}
		
		//Apply speed to player
		public function apply_force(x_force,y_force):void {
			x_speed += (x_force*power);
			y_speed += (y_force*power);
		}
		
		//Remove gravity function
		public function removeGravity():void{
			y_speed += gravity*3;
		}
		
		public function removeFlight():void{
			gravity = 2;
		}
		
		//Limit how high player can jump
		//If jumpPower exceeds 100, canJump is turned off
		public function jump():void{
			if(canJump = true){
				y_speed -= jumpPower;
			}			
			if(y_speed > 50){
				canJump = false;
			}
		}
		
		public function dead():void{
			removeChild(gfx);
			addChild(gfx2);			
		}
		
	}	
}
