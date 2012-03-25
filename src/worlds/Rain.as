package worlds
{
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	
	public class Rain extends Emitter
	{
		public function Rain()
		{			
			super(Assets.RAIN, 55, 74);
			
			newType("Main", [0]);
			setMotion("Main", 270-30, 600, 0.5, 0, 30, 0.2, null);
			
		}
		
		override public function update():void
		{
			super.update();
			
			emit("Main", Math.random() * FP.width + 200, -96);
		}
	}
}