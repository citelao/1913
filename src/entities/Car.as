package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import worlds.Game;

	public class Car extends Entity
	{
		public var img:Image;
		
		public function Car(car:Class = null)
		{
			img = new Image(car);
			graphic = img;
			x = 512 - img.width/2;
			y = 384 - img.height/2 + 42;
		}
		
		override public function update():void
		{
//			if((Math.random()) >= .95 ) {
//				y = 380 - img.height/2;
//			} else {
//				y = 384 - img.height/2;
//			}
		}
	}
}