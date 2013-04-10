package com
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	import flash.display.DisplayObjectContainer;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.*;
	import com.greensock.easing.*;
	import flash.text.TextFormat;

	public class initGame extends MovieClip
	{
		// Variables
		private var keyboard_input:Keys;
		private var player:Player = new Player();
		private var enemy:Enemy = new Enemy();
		private var boss3:Level3Enemy = new Level3Enemy();
		private var enemy3:Level3Enemy = new Level3Enemy();
		private var boss:Boss = new Boss();
		private var finalboss:FinalBoss = new FinalBoss();
		private var plus:Plus = new Plus();
		private var bg1:Background;
		private var bg2:Background2;
		private var bg3:Background3;
		private var bg4:FinalLevelBackground;
		private var backgroundContainer = new BackgroundContainer  ;
		private var restartButton:SimpleButton = new RestartButton  ;
		private var gameOverScreen:MovieClip = new GameOver  ;
		private var gameWinScreen:MovieClip = new GameWin  ;
		public var staminabar:StaminaBar;
		public var playerHealth:HealthBar;
		public var bossHealth:HealthBar;
		public var enemy3Health:HealthBar;
		private var finalbossHealth:HealthBar;
		public var currentLevel:Levels;
		public var enemyNum:Number = 0;
		public var enemyList:Array = new Array();
		private var bulletList:Array = new Array();
		private var food:Food;
		public var foodList:Array = new Array();
		public var foodNum:Number = 0;
		private var foodCt:foodCount;
		private var bulletCount:TextField;
		private var bulletNum:Number = 20;
		private var raindrop:Rain = new Rain();
		private var timer:int;
		private var formatfont:TextFormat = new TextFormat();
		private var plusTimer:Timer;
		private var shootTimer:Timer;

		private var flyingBoss:FlyingBoss = new FlyingBoss();
		public var flyingBossHealth:HealthBar;
		private var flyingBossAttack:Number = 15;
		private var enemyFireTimer:Timer = new Timer(1500,1);//causes delay between fires
		public var enemyCanFire:Boolean = true;//can you fire a laser

		private var playerFireTimer:Timer = new Timer(500,1);
		private var playerCanFire:Boolean = true;

		private var playerHealthText:Game_txt = new Game_txt();
		private var staminaText:Game_txt = new Game_txt();

		private var bossFireTimer:Timer = new Timer(2000,1);
		private var bossCanFire:Boolean = true;
		private var numBullets:Number = 3;
		private var spread = 5;
		private var bossBulletList:Array = new Array();
		private var bosstarget:bossTarget = new bossTarget();
		private var sound:Sound = new ShootingSound;


		//---> Game control         
		public function startGame():void
		{
			//Checks if there is a stage
			if (! stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			else
			{
				init(null);
			}
		}


		// Initializing the game: Add the object on the stage
		private function init(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME,update,false,0,true);
			Mouse.hide();

			// Add graphics 
			create_enviroment();
			currentLevel = new Levels(1);
			setBackgroundImage();

			// Add controls
			var keyboard = new MovieClip();
			addChild(keyboard);
			keyboard_input = new Keys(keyboard);
		}

		public function stopGame():void
		{
			this.removeEventListener(Event.ENTER_FRAME,update);
			bossFireTimer.removeEventListener(TimerEvent.TIMER, bossFireTimerHandler);
			// Remove all children from stage;
			while (this.numChildren > 1)
			{
				this.removeChildAt(this.numChildren-1);
			}
		}


		//---> Graphics control        
		private function create_enviroment():void
		{
			// Add background
			/**Note: This is a level container. The level BGs will replace the container**/
			backgroundContainer = new BackgroundContainer();
			addChild(backgroundContainer);

			bg1 = new Background();
			bg2 = new Background2();
			bg3 = new Background3();
			bg4 = new FinalLevelBackground();

			// Set font size
			formatfont.size = 30;

			// Display bullet count
			bulletCount = new TextField();
			addChild(bulletCount);
			bulletCount.x = 290;
			bulletCount.y = 0;
			bulletCount.defaultTextFormat = formatfont;
			bulletCount.text = String(bulletNum);


			// Add bullet/food count image
			foodCt = new foodCount();
			foodCt.x = 270;
			foodCt.y = 5;
			addChild(foodCt);

			// Add healthbar
			playerHealth = new HealthBar(0,32);
			addChild(playerHealth);

			// Stamina & Health Text
			addChild(playerHealthText);
			playerHealthText.game_txt.text = 'Player Health';
			playerHealthText.x = 160;
			playerHealthText.y = 32;

			addChild(staminaText);
			staminaText.game_txt.text = 'Stamina Bar';
			staminaText.x = 160;
			staminaText.y = 0;


			// Add StaminaBar
			staminabar = new StaminaBar(0,0);
			addChild(staminabar);

			// Add Boss1health
			bossHealth = new HealthBar(800,10);
			addChild(bossHealth);

			// Add Boss2health
			flyingBossHealth = new HealthBar(800,10);

			// Add Boss3health
			enemy3Health = new HealthBar(800,10);

			// Add FinalBossHealth
			finalbossHealth = new HealthBar(800,10);

			// Add player
			player = new Player();
			addChild(player);

			enemy3 = new Level3Enemy();

			finalboss = new FinalBoss();

			currentLevel = new Levels(1);
			setBackgroundImage();
		}

		// Game loop update
		private function update(e:Event):void
		{
			// Move player
			addEventListener(Event.ENTER_FRAME, movePlayer);


			// Levels
			if (bossHealth.getHealth() == currentLevel.bossDie)
			{
				currentLevel = new Levels(currentLevel.stageLevel + 1);
				setBackgroundImage();
			}
			else if (flyingBossHealth.getHealth() == currentLevel.boss2Die)
			{
				currentLevel = new Levels(currentLevel.stageLevel + 1);
				setBackgroundImage();
			}
			else if (enemy3Health.getHealth() == currentLevel.boss3Die)
			{
				currentLevel = new Levels(currentLevel.stageLevel + 1);
				setBackgroundImage();
			}
			else if (finalbossHealth.getHealth() == currentLevel.boss4Die)
			{
				removeChild(finalboss);
				removeChild(finalbossHealth);
				removeEventListener(Event.ENTER_FRAME, finalBossFight);
				gameWin();
			}

			checkBulletCollisions();


			if (boss.hitTestPoint(player.x,player.y,true))
			{
				playerHealth.subtractHealth(10);

				if (playerHealth.getHealth() <= 0)
				{
					playerHealth.stopHealth(0);
					player.dead();
					removeEventListener(Event.ENTER_FRAME, movePlayer);
					gameOver();
				}
			}
			else if (flyingBoss.hitTestPoint(player.x, player.y, true))
			{
				playerHealth.subtractHealth(10);

				if (playerHealth.getHealth() <= 0)
				{
					playerHealth.stopHealth(0);
					player.dead();
					removeEventListener(Event.ENTER_FRAME, movePlayer);
					gameOver();
				}
			}



			for (var i:int = 0; i < enemyList.length; i++)
			{
				if (enemyList[i].hitTestPoint(player.x,player.y,true))
				{
					playerHealth.subtractHealth(10);

					if (playerHealth.getHealth() <= 0)
					{
						playerHealth.stopHealth(0);
						player.dead();
						removeEventListener(Event.ENTER_FRAME, movePlayer);
						gameOver();
					}
				}
			}

			for (var bb:int = 0; bb < bossBulletList.length; bb++)
			{
				if (bossBulletList[bb].hitTestObject(player))
				{
					playerHealth.subtractHealth(5);
					bossBulletList[bb].visible = false;
					bossBulletList[bb].x -=  1000;
					if (playerHealth.getHealth() <= 0)
					{
						playerHealth.stopHealth(0);
						player.dead();
						removeEventListener(Event.ENTER_FRAME, movePlayer);
						gameOver();
					}
				}
			}

			//Food Setup
			if (foodNum < 10)
			{

				var food:Food = new Food();

				food.addEventListener(Event.REMOVED_FROM_STAGE, removeFood, false, 0, true);
				foodList.push(food);

				this.addChild(food);
				food.x = stage.stageWidth + Math.round(Math.random() * (2000 - stage.stageWidth));//Random x position
				food.y = 0 + Math.round(Math.random()*(stage.stageHeight - 0));//Random y position
				foodNum++;
			}

			//If player hits food - stamina bar is incremented 
			for (var f:int = 0; f < foodList.length; f++)
			{
				if (player.hitTestObject(foodList[f]))
				{
					foodList[f].takeHit();
					foodNum--;
					bulletNum += 2;
					bulletCount.text = String(bulletNum);
					staminabar.addMana(25);


					//Plus graphic
					plusTimer = new Timer(500,1);
					addChild(plus);
					plus.visible = true;
					plus.x = 275;
					plus.y = 20;
					plusTimer.addEventListener(TimerEvent.TIMER, timerListener);
					plusTimer.start();
					TweenLite.to(plus, 0.5, {scaleX:2, scaleY:2, alpha:0});


					if (staminabar.getMana() >= 100)
					{
						staminabar.stopMana(0);
						player.scaleY = 1.6;
					}
					else
					{
						player.scaleY = 1;
						player.scaleX = 1;
					}
				}
			}
		}

		private function gameWin():void
		{
			// Stop gameloop
			stopGame();

			// Make mouse visible
			Mouse.show();

			// Add game over graphics
			backgroundContainer.addChild(gameWinScreen);
			backgroundContainer.addChild(restartButton);
			gameWinScreen.x = 436;
			gameWinScreen.y = 416;
			restartButton.x = 500;
			restartButton.y = 400;
			//gameWinScreen.alpha = 50;
			restartButton.alpha = 50;

			restartButton.addEventListener(MouseEvent.MOUSE_DOWN,returnToMenu);
		}

		private function gameOver():void
		{
			// Stop gameloop
			stopGame();

			// Make mouse visible
			Mouse.show();

			// Add game over graphics
			backgroundContainer.addChild(gameOverScreen);
			backgroundContainer.addChild(restartButton);
			gameOverScreen.x = 500;
			gameOverScreen.y = 300;
			restartButton.x = 500;
			restartButton.y = 400;
			gameOverScreen.alpha = 50;
			restartButton.alpha = 50;

			restartButton.addEventListener(MouseEvent.MOUSE_DOWN,returnToMenu);
		}

		private function returnToMenu(e:MouseEvent):void
		{
			trace('returnToMenu');
			// Empty the display list of this instance
			var _scope:DisplayObjectContainer = this;

			while (_scope.numChildren > 0)
			{
				_scope.removeChildAt(_scope.numChildren - 1);
			}

			// Dispatch event to be caught by GameBasis
			dispatchEvent(new Event("GAME_OVER"));

		}

		// Player functionality
		private function movePlayer(e:Event):void
		{
			if (keyboard_input.is_left())
			{
				player.apply_force(-1, 0);
				player.scaleX = -1;
			}
			if (keyboard_input.is_right())
			{
				player.apply_force(1, 0);
				player.scaleX = 1;
			}
			if (keyboard_input.is_up())
			{
				player.apply_force(0, -1);
				decreaseFlight();
			}
			if (keyboard_input.is_down())
			{
				player.apply_force(0, 1);
			}
			if (keyboard_input.is_space())
			{
				if (bulletNum > 0)
				{
					fireBullet();
				}
			}
		}

		public function setBackgroundImage():void
		{

			if (currentLevel.backgroundImage == "level1")
			{
				Main.STAGE_HEIGHT = 500;

				addChild(boss);
				addEventListener(Event.ENTER_FRAME, bossChase);

				backgroundContainer.addChild(bg1);
				trace('level1');
			}
			else if (currentLevel.backgroundImage == "level2")
			{
				Main.STAGE_HEIGHT = 550;
				backgroundContainer.removeChild(bg1);
				backgroundContainer.addChild(bg2);

				this.removeChild(boss);
				//remove boss here or in collision function???;
				this.removeChild(bossHealth);

				addChild(flyingBoss);
				addChild(flyingBossHealth);

				flyingBoss.x = stage.stageWidth + 200;

				addEventListener(Event.ENTER_FRAME, flyingBossBattle);

				trace('level2');
			}
			else if (currentLevel.backgroundImage == "level3")
			{
				Main.STAGE_HEIGHT = 550;
				removeEventListener(Event.ENTER_FRAME, flyingBossBattle);
				backgroundContainer.removeChild(bg2);
				this.removeChild(flyingBossHealth);				
				this.removeChild(flyingBoss);
				
				
				backgroundContainer.addChild(bg3);
				addEnemies();
				addChild(enemy3Health);
				var raindrop:Rain = new Rain();
				raindrop.init(600, 50, 5, 2000, 600, "left");
				addChild(raindrop);
				trace('level3');
			}
			else if (currentLevel.backgroundImage == "level4")
			{
				removeEventListener(Event.ENTER_FRAME, addEnemies);
				Main.STAGE_WIDTH = 550;
				Main.STAGE_HEIGHT = 550;
				//this.removeChild(boss3);
				for (var z:int=0; z<enemyList.length; z++)
				{
					removeChild(enemyList[z]);
				}
				backgroundContainer.removeChild(bg3);
				backgroundContainer.addChild(bg4);
				addChild(finalbossHealth);
				addChild(finalboss);

				//Add boss target
				addChild(bosstarget);
				bosstarget.x = 878;
				bosstarget.y = 310;
				bosstarget.visible = false;

				addEventListener(Event.ENTER_FRAME, finalBossFight);
				bossFireTimer.addEventListener(TimerEvent.TIMER, bossFireTimerHandler);
				trace('level4');

			}
		}

		private function addEnemies():void
		{
			var i:int;
			var maxEnemies:int = 10;

			for (i = 0; i < maxEnemies; i++)
			{
				enemy3 = new Level3Enemy();
				enemyList.push(enemy3);
				addChild(enemy3);
			}

			addEventListener(Event.ENTER_FRAME, follow, false, 0 , true);
		}

		// Need to fix FOLLOW distance!
		private function follow(e:Event):void
		{
			var dx:Number = player.x - enemy3.x;
			var dy:Number = player.y - enemy3.y;
			var bx:Number = player.x - boss3.x;
			var by:Number = player.y - boss3.y;
			var dist:Number = Math.sqrt((dx * dx) + (dy * dy));
			var dist2:Number = Math.sqrt((bx * bx) + (by * by));

			if (dist > player.width + enemy3.width && enemy3.height - player.height)
			{
				enemy3.x +=  0.5 + dx;

			}
			if (dist2 > player.width + boss3.width && boss3.height - player.height)
			{
				boss3.x +=  0.5 + bx;

			}

		}

		// Fire the bullet
		public function fireBullet():void
		{

			playerFireTimer.addEventListener(TimerEvent.TIMER, playerFireTimerHandler);
			if (playerCanFire == true)
			{
				sound.play(0);
				var playerDirection:String;
				if (player.scaleX < 0)
				{
					playerDirection = "left";
				}
				else if (player.scaleX > 0)
				{
					playerDirection = "right";
				}
				var bullet:Bullet = new Bullet(player.x,player.y,playerDirection);
				addChild(bullet);
				bulletList.push(bullet);
				bulletNum--;
				bulletCount.text = String(bulletNum);
				bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved);
				playerCanFire = false;
				playerFireTimer.start();
			}
		}

		private function playerFireTimerHandler(e:TimerEvent):void
		{
			//timer ran, we can fire again.
			playerCanFire = true;
		}

		// Remove the bullets fired
		public function bulletRemoved(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved);
			bulletList.splice(bulletList.indexOf(e.currentTarget), 1);
		}


		//Function to remove gravity when stamina bar is depleted
		public function decreaseFlight():void
		{
			var playerDirection:String;
			playerDirection = "up";

			if (playerDirection)
			{
				staminabar.subtractMana(0.5);
				if (staminabar.getMana() < 0)
				{
					staminabar.stopMana(0);
					player.removeGravity();
				}
			}
		}

		private function removeEnemy(e:Event)
		{
			enemyList.splice(enemyList.indexOf(e.currentTarget), 1);
		}

		//Remove food from stage
		private function removeFood(e:Event)
		{
			foodList.splice(foodList.indexOf(e.currentTarget), 1);
		}

		public function checkBulletCollisions():void
		{
			for (var i:int = 0; i < bulletList.length; i++)
			{
				if (boss.hitTestObject(bulletList[i]))
				{
					removeChild(bulletList[i]);
					bossHealth.subtractHealth(8);
					boss.hit();
					TweenMax.to(boss, 1000, {colorMatrixFilter:{amount:1, saturation:100}});
					TweenMax.to(boss,0.1,{repeat:2, y:boss.y+(1+Math.random()*5), x:boss.x+(1+Math.random()*50), ease:Expo.easeInOut});
         			TweenMax.to(boss,0.1,{y:boss.y+(Math.random()*0), x:boss.x+(Math.random()*50), ease:Expo.easeInOut});

					//bulletList.splice(i,1); 
					if (bossHealth.getHealth() <= 0)
					{
						bossHealth.stopHealth(0);
					}
				}
				else if (flyingBoss.hitTestObject(bulletList[i]))
				{
					removeChild(bulletList[i]);
					flyingBossHealth.subtractHealth(10);
					TweenMax.to(flyingBoss, 1000, {colorMatrixFilter:{amount:1, saturation:100}});
					TweenMax.to(flyingBoss,0.1,{repeat:2, y:flyingBoss.y+(1+Math.random()*2), x:flyingBoss.x+(1+Math.random()*50), delay:0.1, ease:Expo.easeInOut});
         			TweenMax.to(flyingBoss,0.1,{y:flyingBoss.y+(Math.random()*0), x:flyingBoss.x+(Math.random()*50), delay:0.1, ease:Expo.easeInOut});

					if (flyingBossHealth.getHealth() <= 0)
					{
						flyingBossHealth.stopHealth(0);
					}
				}
				else if (enemy3.hitTestObject(bulletList[i]))
				{
					removeChild(bulletList[i]);
					enemy3Health.subtractHealth(18);
					TweenMax.to(enemy3, 1000, {colorMatrixFilter:{amount:1, saturation:100}});
					TweenMax.to(enemy3,0.1,{repeat:2, y:enemy3.y+(1+Math.random()*2), x:enemy3.x+(1+Math.random()*50), delay:0.1, ease:Expo.easeInOut});
         			TweenMax.to(enemy3,0.1,{y:enemy3.y+(Math.random()*0), x:enemy3.x+(Math.random()*50), delay:0.3, ease:Expo.easeInOut});
					if (enemy3Health.getHealth() <= 0)
					{
						enemy3Health.stopHealth(0);
					}
				}
				else if (bosstarget.hitTestPoint(bulletList[i].x,bulletList[i].y,true))
				{
					finalbossHealth.subtractHealth(9);
					TweenMax.to(finalboss, 1000, {colorMatrixFilter:{amount:1, saturation:100}});
					TweenMax.to(finalboss,0.1,{repeat:2, y:finalboss.y+(1+Math.random()*2), x:finalboss.x+(1+Math.random()*30), delay:0.1, ease:Expo.easeInOut});
         			TweenMax.to(finalboss,0.1,{y:finalboss.y+(Math.random()*0), x:finalboss.x+(Math.random()*30), delay:0.3, ease:Expo.easeInOut});
					removeChild(bulletList[i]);
					if (finalbossHealth.getHealth() <= 0)
					{
						finalbossHealth.stopHealth(0);
					}
				}
			}
		}



		private function bossChase(e:Event):void
		{
			//Lvl 1 boss move
			if (boss.x > player.x)
			{
				boss.x -=  4;
				boss.scaleX = 1;
			}
			if (boss.x < player.x)
			{
				boss.x +=  4;
				boss.scaleX = -1;
			}

		}

		public function flyingBossBattle(e:Event):void
		{
			//Stops distance counter from incrementing            
			if (flyingBoss.y > player.y)
			{
				flyingBoss.y -=  3;
			}
			if (flyingBoss.y < player.y)
			{
				flyingBoss.y +=  3;
			}

			//If boss can move
			if (enemyCanFire == true)
			{

				flyingBoss.x -=  flyingBossAttack;

				if (flyingBoss.x < -200)
				{
					//flyingBoss.x += 1300;
					flyingBoss.x = -199;
					flyingBossAttack++;
					enemyCanFire = false;

					enemyFireTimer.start();
				}
				else if (flyingBoss.x > (Main.STAGE_WIDTH + 200))
				{
					flyingBoss.x = Main.STAGE_WIDTH + 200;
					flyingBossAttack--;
					enemyCanFire = false;

					enemyFireTimer.start();
				}

			}

			//enemyFireTimer = new Timer(1500, 1);
			enemyFireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler);

		}
		//End flyingBossBattle;

		private function fireTimerHandler(e:TimerEvent):void
		{
			//timer ran, we can fire again.
			enemyCanFire = true;
			flyingBossAttack *=  -1;
			flyingBoss.scaleX *=  -1;
		}//End fireTimerHandler


		private function timerListener(e:TimerEvent):void
		{
			plus.visible = false;
			TweenLite.to(plus, 0.1, {scaleX:1, scaleY:1, alpha:1});
			//Reset plus tween values ;

			plusTimer.stop();
		}

		public function finalBossFight(e:Event):void
		{
			var dx = player.x;
			var dy = player.y;
			var angle = Math.atan2(dy,dx) / Math.PI * -100;
			finalboss.gfxGun.rotation = angle + 30;

			var bossShootVarX = finalboss.gfxGun.x;
			var bossShootVarY = finalboss.gfxGun.y;

			if (bossCanFire == true)
			{
				if (player.x <= 400 || player.y <= 550)
				{
					var bossbullet:FinalBossBullet = new FinalBossBullet();
					bossbullet.rotation +=  angle + 30;
					bossbullet.x = bossShootVarX - 50;
					bossbullet.y = bossShootVarY;
					bossBulletList.push(bossbullet);
					addChild(bossbullet);

					var shootX = (bossbullet.x - dx);
					var shootY = (bossbullet.y - dy);

					TweenLite.to(bossbullet, 3, {x:-shootX, y:-shootY});
					trace('bullet flies');

					trace('boss fire');
					bossCanFire = false;
					bossFireTimer.start();
					finalboss.gfxGun.play();

				}


			}

		}
		private function bossFireTimerHandler(e:TimerEvent):void
		{
			bossCanFire = true;
			trace('boss can fire');

		}

	}
}