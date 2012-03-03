package entities
{	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		/*** Drawing ***/
		private static var img:Image = new Image(Assets.PLAYER);
		public static var height:Number = img.height;
		
		/*** Movement ***/
		public var xv:Number = 0;
		private static const xinc:Number = 70;
		
		public function Player()
		{
			graphic = img;
			y = 384;
			x = 512 - img.width/2;
			
			// Input groups
			Input.define("walk_left", Key.A, Key.LEFT);
			Input.define("walk_right", Key.D, Key.RIGHT);
		}
		
		override public function update():void
		{
			if(Input.check("walk_left") && xv >= -20)
				xv -= xinc * FP.elapsed;
			if(Input.check("walk_right") && xv <= 20 )
				xv += xinc * FP.elapsed;
			
			xv *= 0.82;
			x += xv;
			
			if(xv < 0 ) { img.flipped = true; } else { img.flipped = false; }
		}
	}
}