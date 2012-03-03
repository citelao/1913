package worlds
{
	import entities.*;
	
	import net.flashpunk.World;
	
	public class Game extends World
	{
		
		public static var player:Player;
		
		public function Game()
		{
			add(new Car(Assets.BOXCAR));
			
			Game.player = new Player;
			add(player);
		}
	}
}