package entities
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class Level extends Entity
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function Level(xml:Class = null)
		{
			_tiles = new Tilemap(Assets.TILEMAP, 1024, 768, Assets.TILE_WIDTH, Assets.TILE_HEIGHT);
			graphic = _tiles;
			layer = 1;
			
			_grid = new Grid(1024, 768, Assets.TILE_WIDTH, Assets.TILE_HEIGHT, 0, 0);
			mask = _grid;
			
			type = "level";
			
			loadLevel(xml);
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			trace(xmlData);
			
			var dataList:XMLList = xmlData.base.tile;
			var dataElement:XML;
			
			for each (dataElement in dataList)
			{
				_tiles.setTile(dataElement.@x /Assets.TILE_WIDTH, 
					dataElement.@y / Assets.TILE_HEIGHT, 
					_tiles.getIndex(dataElement.@tx / Assets.TILE_WIDTH, dataElement.@ty / Assets.TILE_HEIGHT));
			}
			
		}
	}
}