package com
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.DisplayObject;
    import flash.events.*;
 
    public class Enemy2 extends MovieClip
    {
		
        private var _root:Object;
        private var speed:Number;
        private var direction:int;
        private var Xgravity:Number = 0;
        private var Ygravity:Number = 0; 
        private var gravity:Number = 1;
		
		
        public function Enemy2()
        {
            addEventListener(Event.ADDED, beginClass);
            addEventListener(Event.ENTER_FRAME, eFrame);

        }

        private function beginClass(event:Event):void
        {
            this.x = 750;
			this.y = 500;
            _root = MovieClip(root);
            removeEventListener(Event.ADDED, beginClass);
        }
 
        private function eFrame(event:Event):void
        {
			
            var distance = Math.sqrt( ( this.x - _root.player.x ) * ( this.x - _root.player.x ) + ( this.y - _root.player.y ) * ( this.y - _root.player.y ) );
            this.x += speed * direction;
            if(distance<300 && direction==-1) 
            {
                speed=8;
                direction=-1;
                this.x--;
            }
            else if(distance<300 && direction==1) 
            {
                speed=8;
                direction=1;
                this.x++;
            }
            else
            {
                if(this.x>900)
                {
                    speed=5;
                    direction=-1;
                    gotoAndStop(1);
                }
                if(this.x<400)
                {
                    speed=5;
                    direction=1;
                    gotoAndStop(1);
                }
            }/*

            if(!this.hitTestObject(_root._line))   
            {
                Ygravity += gravity; 
                this.x += Xgravity;
                this.y += Ygravity; 
            }*/
        }
    }
}