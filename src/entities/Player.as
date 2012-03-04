package entities
{	
	import flash.geom.Point;
	import flash.text.StaticText;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{		
		// Body Parts
		public var arm:Entity = new Entity();
		private var arm_image:Image = Image.createRect(5,50,0xff55728b);
		private var body:Image = new Image(Assets.PLAYER);
		
		// Movement
		private var speed:Point = new Point();
		private var acceleration:Point = new Point(1500, 1500);
		private var maxSpeed:Point = new Point(2000, 2000);
		private var friction:Number = 1200;

		// Gun
		private var wouldReload:Boolean = false;
		private var reloading:Boolean = false;
		private var reloadUser:Boolean = false;
		private var reloadSound:Sfx = new Sfx(Assets.SN_RELOAD);
		private var reloadTimer:Number = 0;
		private var reloadCount:Number = 0;
		private var reloadDelay:Array = [1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
		
		private var wouldFire:Boolean = false;
		private var firing:Boolean = false;
		
		private var ammo:int = 6;
		private var maxAmmo:int = 6;
		
		public function Player()
		{			
			// Graphics
			graphic = body;
			
			arm.graphic = arm_image;
			arm_image.originX = 3;
			arm_image.originY = 5;
			
			// Input Groups
			Input.define("walk_left", Key.A, Key.LEFT);
			Input.define("walk_right", Key.D, Key.RIGHT);
			Input.define("pick_up", Key.W, Key.UP);
			Input.define("drop", Key.S, Key.DOWN);
			Input.define("fire", Key.X);
			Input.define("reload", Key.R, Key.F);
			
			// Default Start Pos
			y = 384;
			x = 457;
		}
		
		override public function update():void
		{
			getInput();
			
			applyPhysics();
			
			applyGun();
			
			moveBy(speed.x * FP.elapsed, 0);
			
			drawPlayer();
		}
		
		public function getInput():void
		{
			if(Input.check("walk_left"))
				speed.x -= acceleration.x * FP.elapsed;			
			if(Input.check("walk_right"))
				speed.x += acceleration.x * FP.elapsed;
			
			
			// wouldFire & wouldReload are ternaries: if the () statement is true, set them to true. Otherwise false.
			wouldFire = (Input.pressed("fire") || Input.mousePressed)? true : false; 
			wouldReload = (Input.pressed("reload"))? true : false;
		}
		
		public function applyPhysics():void
		{
			// Friction
			if(!Input.check("walk_left") && !Input.check("walk_right"))
			{
				var dir:int = FP.sign(speed.x);
				speed.x -= dir * friction * FP.elapsed;
				
				if(dir != FP.sign(speed.x))
					speed.x = 0.0;
			}
			
			if(Math.abs(speed.x) > maxSpeed.x)
				speed.x = FP.sign(speed.x) * maxSpeed.x;					
		}
		
		public function applyGun():void
		{
			var canFire:Boolean = (ammo > 0)? true : false;
			
			firing = (wouldFire && canFire)? true : false;
			
			if((wouldReload && ammo < maxAmmo) || (wouldFire && ammo <= 0)) 
			{
				reloadUser = wouldReload;
				reloading = true;
			}
			
			if(firing) 
			{
				world.add(new Bullet(x+15, y+24, arm_image.angle - 180));
				ammo--;
				reloadCount = 0;
				return;
			}
			
			/**
			 * Reloading works like this:
			 * - 1st bullet in reload sequence takes longer
			 * - successive bullets take shorter, but the delay makes it less efficient than firing
			 *
			 * reloading sequence resets after each fire.
			 *
			 * if `userReload` –– ie user hit "reload" –– then reward them by lowering reload time.
			 * 
			 * primary goal: 	prevent players from going down to 1 bullet, tapping r, and firing away.
			 * secondary goal:	reward players who take time for full reload
			 */
			
			if(reloading) 
			{
				reloadTimer += FP.elapsed;
				
				//if(reloadCount)
				//	play("continueReload");
				//else
				//	play("beginReload");
				
				var currentReloadDelay:Number = (reloadUser)? reloadDelay[reloadCount + 1] : reloadDelay[reloadCount];
				
				if(reloadTimer >= currentReloadDelay)
				{
					trace("Reloading, delay:", reloadTimer);
					
					ammo++;
					reloadCount++;
					reloadTimer = 0.0;
					reloadSound.play();
				}
				
				if(ammo == maxAmmo)
					reloading = false;
			}
		}
		
		public function drawPlayer():void 
		{
			// Face correct direction & Draw arm
			if(Input.mouseX < x)
			{
				body.flipped = true; //face left
				arm.x = x+20;
			} else {
				body.flipped = false; //face right
				arm.x = x+4;
			}
			
			arm.y = y+20;
			
			arm_image.angle = 180 + 180 * Math.atan2(arm.x - Input.mouseX, arm.y - Input.mouseY) / Math.PI;
		}
	}
}