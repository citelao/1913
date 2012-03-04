package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class Cursor extends Entity
	{
		public function Cursor():void
		{
			graphic = new Image(Assets.CURSOR);
		}
		
		override public function update():void
		{
			x = Input.mouseX;
			y = Input.mouseY;
		}
	}
}