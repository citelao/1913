package worlds
{
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	
	public class Rain extends Emitter
	{
		public function Rain()
		{
			super(Assets.RAIN, 5, 96);
			
			newType("Main", [0]);
			setMotion("Main", 270, 500, 0.1, -0, 30, 0.2, null);
		}
		
		override public function update():void
		{
			super.update();
			
			emit("Main", Math.random() * FP.width, 0);
			
			emit("Main", Math.random() * FP.width, 0);
			
			emit("Main", Math.random() * FP.width, 0);
			
			emit("Main", Math.random() * FP.width, 0);
		}
	}
}