/**
 * Enemy AI - Random movement
 * ---------------------
 * VERSION: 1.0
 * DATE: 1/25/2011
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.FreeActionScript.com
 **/
package com 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.*;
	
	public class Level3Enemy extends MovieClip
	{
		// player settings		
		private var _moveSpeedMax:Number = 1000;
		private var _rotateSpeedMax:Number = 50;
		private var _decay:Number = .98;
		private var _destinationX:int = Main.STAGE_WIDTH;
		private var _destinationY:int = Main.STAGE_HEIGHT;
		
		private var _minX:Number = 0;
		private var _minY:Number = 0;
		private var _maxX:Number = Main.STAGE_WIDTH;
		private var _maxY:Number = Main.STAGE_HEIGHT;
		
		// player
		public var gfx:MovieClip = new Enemy3;
		
		// global		
		private var _dx:Number = 0;
		private var _dy:Number = 0;
		
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		
		private var _trueRotation:Number = 0;
		
		/**
		 * Constructor
		 */
		public function Level3Enemy() 
		{
			// create player object
			createPlayer();
			
			// add listeners
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/**
		 * Creates player
		 */
		private function createPlayer():void
		{			
			
			gfx.x = Main.STAGE_WIDTH;
			gfx.y = Main.STAGE_WIDTH;
			addChild(gfx);
		}
		
		/**
		 * EnterFrame Handlers
		 */
		private function enterFrameHandler(event:Event):void
		{	
			if(gfx.x > Main.STAGE_WIDTH){
				gfx.x = Main.STAGE_WIDTH;
			}
			if(gfx.y > Main.STAGE_HEIGHT){
				gfx.y = Main.STAGE_HEIGHT;
			}
			if(gfx.x < 0){
				gfx.x = 0;
			}
			if(gfx.y < 0){
				gfx.y = 0;
			}
			updateCollision();
			updatePosition();
			updateRotation();
		}
		
		/**
		 * Calculate Rotation
		 */
		private function updateRotation():void
		{
			// calculate rotation
			_dx = gfx.x - _destinationX;
			_dy = gfx.y - _destinationY;
			
			// which way to rotate
			var rotateTo:Number = getDegrees(getRadians(_dx, _dy));	
			
			// keep rotation positive, between 0 and 360 degrees
			if (rotateTo > gfx.rotation + 180) rotateTo -= 360;
			if (rotateTo < gfx.rotation - 180) rotateTo += 360;
			
			// ease rotation
			_trueRotation = (rotateTo - gfx.rotation) / _rotateSpeedMax;
			
			// update rotation
			gfx.rotation += _trueRotation;			
		}
		
		/**
		 * Calculate Position
		 */
		private function updatePosition():void
		{
			// update velocity
			_vx += (_destinationX - gfx.x) / _moveSpeedMax;
			_vy += (_destinationY - gfx.y) / _moveSpeedMax;
			
			// if close to target
			if (getDistance(_dx, _dy) < 50)
			{
				getRandomDestination();
			}
			
			// apply decay (drag)
			_vx *= _decay;
			_vy *= _decay;
			
			// update position
			gfx.x += _vx;
			gfx.y += _vy;
		}
		
		/**
		 * updateCollision
		 */
		protected function updateCollision():void
		{
			// Check X
			// Check if hit top
			if (((gfx.x - gfx.width / 2) < _minX) && (_vx < 0))
			{
			  _vx = -_vx;
			}
			// Check if hit bottom
			if ((gfx.x + gfx.width / 2) > _maxX && (_vx > 0))
			{
			  _vx = -_vx;
			}
			
			// Check Y
			// Check if hit left side
			if (((gfx.y - gfx.height / 2) < _minY) && (_vy < 0))
			{
			  _vy = -_vy
			}
			// Check if hit right side
			if (((gfx.y + gfx.height / 2) > _maxY) && (_vy > 0))
			{
			  _vy = -_vy;
			}
		}
		
		/**
		 * Calculates a random destination based on stage size
		 */
		private function getRandomDestination():void
		{
			_destinationX = Math.random() * (_maxX - gfx.width) + gfx.width / 2;
			_destinationY = Math.random() * (_maxY - gfx.height) + gfx.height / 2;
		}
		
		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
	}
	
}