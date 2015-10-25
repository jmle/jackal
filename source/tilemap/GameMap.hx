package tilemap;

import flixel.addons.editors.tiled.TiledLayer;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;

class GameMap {

	public var layers:Array<FlxTilemap> = new Array<FlxTilemap>();

	/**
	 * Creates a FlxTilemap from a given TiledMap (a map created using Tiled)
	 */
	public function new(tiledMapPath:String, tilesheetPath:String) {
		var tiledLevel:TiledMap = new TiledMap(tiledMapPath);

		var tileSize = tiledLevel.tileWidth;
		var mapW = tiledLevel.width;
		var mapH = tiledLevel.height;

		for (tiledLayer in tiledLevel.layers) {
			var layerData:Array<Int> = tiledLayer.tileArray;
			var tilemapLayer:FlxTilemap = new FlxTilemap();

			tilemapLayer.widthInTiles = mapW;
			tilemapLayer.heightInTiles = mapH;

			tilemapLayer.loadMap(layerData, tilesheetPath, tileSize, tileSize, FlxTilemap.OFF, 1);

			setLayerProperties(tiledLayer, tilemapLayer);

			layers.push(tilemapLayer);
		}
	}

	private function setLayerProperties(tiledLayer:TiledLayer, tilemapLayer:FlxTilemap):Void {
		var tileTypes:Iterator<Int> = Util.unique(tiledLayer.tileArray);
		var collisionDir:Int = tiledLayer.properties.get("collide") == "true" ? FlxObject.ANY : FlxObject.NONE;

		for (tileType in tileTypes) {
			if (tileType != 0)
				tilemapLayer.setTileProperties(tileType, collisionDir);
		}
	}

}

