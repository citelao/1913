package entities
{	
	import flash.text.StaticText;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{		
		/*** Body Parts ***/
		public var arm:Entity = new Entity();
		private var body:Image = new Image(Assets.PLAYER);
		private var arm_image:Image = Image.createRect(5,50,0xff55728b);
		
		/*** Movement ***/
		private var xv:Number = 0;
		private var moving:Boolean = false;
		private static var xinc:Number = 150;
		private static var xslow:Number = 0.82;
		private static var xmax:Number = 20;
		private static var xcut:Number = 2;

		/*** Gun ***/
		private static var sdelay:Number = 0.2;
		private var stimer:Number = 0;
		
		private static var maxammo:int = 6;
		private var ammo:int = 6;
		
		public function Player()
		{			
			/*** Graphics ***/
			graphic = body;
			
			arm.graphic = arm_image;
			arm_image.originX = 3;
			arm_image.originY = 5;
			
			/*** Input Groups ***/
			Input.define("walk_left", Key.A, Key.LEFT);
			Input.define("walk_right", Key.D, Key.RIGHT);
			Input.define("pick_up", Key.W, Key.UP);
			Input.define("drop", Key.S, Key.DOWN);
			Input.define("fire", Key.X);
			Input.define("reload", Key.R, Key.F);
			
			/*** Default Start Pos ***/
			y = 384;
			x = 457;
		}
		
		override public function update():void
		{
			/*** Check for input ***/
			if(Input.check("walk_left") && xv >= -xmax) {
				xv -= xinc * FP.elapsed;
				moving = true;
			}
			
			if(Input.check("walk_right") && xv <= xmax) {
				xv += xinc * FP.elapsed;
				moving = true;
			}
			
			if((Input.pressed("fire") || Input.mousePressed) && stimer <= 0.1 && ammo > 0) {
				world.add(new Bullet(x, y, arm_image.angle - 180));
				stimer = sdelay;
				ammo--;
			}
			
			if(Input.check("reload")) {
				ammo = maxammo;
			}
			
			/*** Bullet Timing ***/
			stimer -= FP.elapsed;
			
			/*** Friction ***/
			xv *= xslow;
			x += xv;
			
			if(!moving && xv < xcut && xv > -xcut)
				xv = 0;
			
			moving = false;
			
			/*** Face correct direction ***/
			if(Input.mouseX < x) {
				body.flipped = true; //face left
				arm.x = x+20;
			} else {
				body.flipped = false; //face right
				arm.x = x+4;
			}
			
			arm.y = y+20;
			
			/*** Point Arm ***/
			arm_image.angle = 180 + 180 * Math.atan2(arm.x - Input.mouseX, arm.y - Input.mouseY) / Math.PI;					
		}
	}
}