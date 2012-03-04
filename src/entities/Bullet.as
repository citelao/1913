package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		private var img:Image  = Image.createRect(1,4);
		private static var vel:Number = 20;
		private var angleRad:Number;
		private var xvel:Number;
		private var yvel:Number;
		
		public function Bullet(x:Number=0, y:Number=0, angle:Number = 0)
		{
			super(x, y, img);
			
			img.angle = 180 + angle;
			angleRad = angle * Math.PI / 180 + (.5 * Math.PI);
			
			trace(angleRad);
			
			xvel = vel * Math.cos(-angleRad);
			yvel = vel * Math.sin(-angleRad);
		}
		
		override public function update():void
		{
			x += xvel;
			y += yvel;
		}
	}
}