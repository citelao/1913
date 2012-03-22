package
{
	public class Assets
	{
		[Embed(source="../assets/graphics/Player-Sill.png")] public static const PLAYER:Class;
		[Embed(source="../assets/graphics/Boxcar.png")] public static const	BOXCAR:Class;
		[Embed(source="../assets/graphics/Cursor.png")] public static const	CURSOR:Class;
		[Embed(source="../assets/graphics/Rain.png")] public static const RAIN:Class;
		
		
		public static const TILE_WIDTH:Number = 32;
		public static const TILE_HEIGHT:Number = 32;
		[Embed(source="../assets/graphics/Tilemap.png")] public static const TILEMAP:Class;
		[Embed(source="../ogmo/Debug.oel", mimeType="application/octet-stream")] public static const LV_DEBUG:Class;
		
		[Embed(source = "../assets/sounds/reload_temp.mp3")] public static const SN_RELOAD:Class;
		[Embed(source = "../assets/sounds/shoot_temp.mp3")] public static const SN_FIRE:Class;
	}
}