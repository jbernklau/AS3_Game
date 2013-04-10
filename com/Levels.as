package com {
	
	public class Levels {

		public var backgroundImage:String;
		public var bossDie:Number;
		public var boss2Die:Number;
		public var boss3Die:Number;
		public var boss4Die:Number;
		public var stageLevel:Number;
		
		public function Levels(levelNumber:Number) {
			// constructor code
			
			stageLevel = levelNumber;
			
			if (levelNumber == 1) 
			{
				backgroundImage = "level1";
				bossDie = 0;
			}
			else if (levelNumber == 2)
			{
				backgroundImage = "level2";
				boss2Die = 0;					// Input different boss e.g.  boss2Die
			}
			else if (levelNumber == 3)
			{
				backgroundImage = "level3";
				boss3Die = 0;
			}
			else if (levelNumber == 4)
			{
				backgroundImage = "level4";
				boss4Die = 0;
			}
			
		}

	}
	
}
