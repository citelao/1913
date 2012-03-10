package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	import worlds.Game;
	
	public class Main extends Engine
	{
		
		public static var game:Game;
		
		public function Main()
		{
			super(1024, 768);
			
			FP.world = new Game();
		}
		
	}
}