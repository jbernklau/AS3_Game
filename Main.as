package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import com.greensock.TweenLite;
	import com.*;
	
	TweenPlugin.activate([VolumePlugin]);

	public class Main extends MovieClip
	{
		// Game container
		private var g:initGame;
		private var intro1 = new Introduction1;
		private var intro2 = new Introduction2;
		// Intro BG
		private var BGSound = new IntroBGM();
		private var BGSoundChannel:SoundChannel;

		// Start button
		private var startbutton:SimpleButton = new StartButton  ;
		private var menuBG = new MenuBG  ;

		//Instruction page
		private var instructionsbutton:SimpleButton = new InstructionsButton  ;
		private var instructionsBG = new InstructionsBG  ;
		private var backbutton:SimpleButton = new BackButton  ;

		// Static vars
		public static var STAGE:Stage;
		public static var STAGE_WIDTH:int = 1000;
		public static var STAGE_HEIGHT:int = 600;
		
		// Timer
		var timer:Timer = new Timer(12000);
		var timer2:Timer = new Timer(7900);
		
		public function Main():void
		{
			// Set stage instances
			STAGE = stage;			

			// menuBG
			menuBG.x = STAGE_WIDTH / 2 + 5;
			menuBG.y = STAGE_HEIGHT / 2 + 53;

			// Start button
			startbutton.x = STAGE_WIDTH / 2;
			startbutton.y = STAGE_HEIGHT /2 + 40;
			startbutton.addEventListener(MouseEvent.MOUSE_DOWN,startGame);

			//Instructions Page
			instructionsBG.x = STAGE_WIDTH / 2;
			instructionsBG.y = STAGE_HEIGHT / 2;

			// Instructions button
			instructionsbutton.x = STAGE_WIDTH / 2;
			instructionsbutton.y = STAGE_HEIGHT / 2 + 130;
			instructionsbutton.addEventListener(MouseEvent.MOUSE_DOWN,instructionsPage);

			// Sound;
			BGSoundChannel = BGSound.play(1,999);
			
			//addChild(intro1);
			addChild(intro1);
			intro1.visible = false;
			addChild(intro2);
			intro2.visible = false;
			intro1.x = -763.45;
			intro1.y = 409.1;	
			intro2.x = Main.STAGE_WIDTH + 10;
			intro2.y = Main.STAGE_HEIGHT/2;	
			introScene();
			
		}
		
		private function introScene():void{		
			intro1.visible = true;
			intro1.gotoAndPlay(2);
			TweenLite.to(intro1, 10, {scaleX:.9, scaleY:.9});						
			
			timer.addEventListener(TimerEvent.TIMER, stopFirstScene);
			timer.start();
		}
		
		private function stopFirstScene(event:TimerEvent):void{
			intro2.visible = true;
			intro2.gotoAndPlay(2);			
			
			timer2.addEventListener(TimerEvent.TIMER, gotoMain);
			timer2.start();
		}
		
		private function gotoMain(event:TimerEvent):void{
			intro1.visible = false;
			intro2.visible = false;
			intro1.stop();
			intro2.stop();
			timer.removeEventListener(TimerEvent.TIMER, stopFirstScene);
			timer2.removeEventListener(TimerEvent.TIMER, gotoMain);
			showMainMenu();
		}
		
		
		public function startGame(e:MouseEvent):void
		{			
			// Game init
			g = new initGame();
			g.addEventListener("GAME_OVER",resetGame);
			g.startGame();
			addChild(g);

			// Remove menu
			hideMainMenu();
			
			trace('Starting Game');
			
		}

		public function instructionsPage(e:MouseEvent):void
		{
			addChild(instructionsBG);
			
			backbutton.x = STAGE_WIDTH / 2;
			backbutton.y = STAGE_HEIGHT / 2;
			backbutton.addEventListener(MouseEvent.MOUSE_DOWN, backToMenu);
			addChild(backbutton);

		}

		public function resetGame(e:Event):void
		{
			removeChild(g);
			g.removeEventListener("GAME_OVER",resetGame);
			g = null;
			showMainMenu();
			BGSoundChannel = BGSound.play(1,999);
		}

		public function showMainMenu():void
		{
			addChild(menuBG);
			addChild(startbutton);
			addChild(instructionsbutton);
			
		}

		public function backToMenu(e:MouseEvent):void
		{
			removeChild(backbutton);
			removeChild(instructionsBG);
			showMainMenu();
		}

		public function hideMainMenu():void
		{
			removeChild(startbutton);
			removeChild(menuBG);			
			TweenLite.to(BGSoundChannel, 1, {volume:0});
			// Fade out menu to game
			//TweenLite.to(this, 20, {alpha:0});  Need to create menu container
		}
	}
}