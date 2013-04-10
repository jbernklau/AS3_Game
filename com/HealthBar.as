/**Credits go to username Johnny from http://www.newgrounds.com/bbs/topic/1056553**/

package com
{
	import flash.display.*;
	
	public class HealthBar extends Sprite
	{
		var bar:Sprite;
		
		public function HealthBar(xLoc:Number, yLoc:Number, wid:Number = 150, high:Number = 20,
								  bc:uint = 0xCCCCCC, fc:uint = 0xFF0000)
		{
			this.x = xLoc;
			this.y = yLoc;
			
			var hbol:Sprite = new Sprite();
			addChild(hbol);

			var ol:Graphics = hbol.graphics;
			ol.lineStyle(3, 0x000000);
			ol.beginFill(bc);
			ol.lineTo(wid,0);
			ol.lineTo(wid,high);
			ol.lineTo(0,high);
			ol.lineTo(0,0);
			ol.endFill();
			
			var hb:Sprite = new Sprite();
			hbol.addChild(hb);
			bar = hb;
			
			var ins:Graphics = hb.graphics;
			ins.lineStyle(2, 0x000000);
			ins.beginFill(fc);
			ins.lineTo(wid,0);
			ins.lineTo(wid,high);
			ins.lineTo(0,high);
			ins.lineTo(0,0);
			ins.endFill();
		}
		
			public function subtractHealth(amount:Number)
			{
				bar.scaleX -= amount/100;
			}
			public function addHealth(amount:Number)
			{
				bar.scaleX += amount/100;
			}
			public function getHealth():Number
			{
				return bar.scaleX*100;
			}
			public function stopHealth(amount:Number)
			{
				bar.scaleX = 0;
			}
		}
}