package worlds
{
	import entities.*;
	
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	
	public class Game extends World
	{
		public var level_layers:Array = ["HUD", "Front", "People", "Debug", "Rain"];
		
		public var player:Player;
		
		public var level:Class = Assets.LV_DEBUG;
		public var tiles:Tilemap;
		public var grid:Grid;
		
		public function Game()
		{
			Main.game = this;
						
			Mouse.hide();
			
			player = new Player();
			tiles = new Tilemap(Assets.TILEMAP, 1024, 768, Assets.TILE_WIDTH, Assets.TILE_HEIGHT);
			grid = new Grid(1024, 768, Assets.TILE_WIDTH, Assets.TILE_HEIGHT, 0, 0);
			
			addGraphic(tiles, level_layers.indexOf("Debug"));
			
			add(player);
			
			add(new Cursor());
			
			addGraphic(new Rain(), level_layers.indexOf("Rain"));
			
			load(level);
		}
		
		private function load(level:Class):void
		{
			var xml:XML, o:XML;
			xml = FP.getXML(level);
			
			for each(o in xml.base.tile)
			{
				tiles.setTile(o.@x / Assets.TILE_WIDTH,
					o.@y / Assets.TILE_HEIGHT,
					tiles.getIndex( o.@tx / Assets.TILE_WIDTH, o.@ty / Assets.TILE_HEIGHT));
			}
		}
	}
} 