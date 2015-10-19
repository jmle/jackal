package ;

import haxe.io.Path;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;

class PlayState2 {

	override public function create():Void {
		super.create();

		// Load the TMX data
		var tiledLevel:TiledMap = new TiledMap("assets/maps/desert_1.tmx");

		// Get map variables
		var tileSize = tiledLevel.tileWidth;
		var mapW = tiledLevel.width;
		var mapH = tiledLevel.height;

		// Loop through each tile layer and render tile map
		for (layer in tiledLevel.layers) {
			var layerData:Array<Int> = layer.tileArray;

			// "tilesheet" is a custom property inside the map
			var tilesheetName:String = layer.properties.get("tilesheet");
			var tilesheetPath:String = "assets/images/" + tilesheetName;
			tilesheetPath = "assets/maps/desert_1.png";

			var level:FlxTilemap = new FlxTilemap();

			// If we're passing an array of data, the level needs to know
			// how many columns of data to read before it moves to a new row,
			// as noted in the API page:
			// http://api.haxeflixel.com/flixel/tile/FlxTilemap.html#loadMap
			level.widthInTiles = mapW;
			level.heightInTiles = mapH;

			// Note: The tilesheet indices are continuous! This means,
			// if there is more than one tilesheet, the 2nd tilesheet's
			// starting index right after the 1st tilesheet's last index.
			// e.g.
			// - tilesheet 1 has 100 tiles (index = 1-100)
			// - tilesheet 2 has 100 tiles (index = 101-200 instead of 1-100)
			//
			// Note2: that the gid "0" is reserved for empty tiles
			var tileGID:Int = getStartGid(tiledLevel, tilesheetName);

			// Render the map.
			// Note: the StartingIndex is based on the tilesheet's
			// startingGID rather than the default 1.
			level.loadMap(layer.tileArray, tilesheetPath, tileSize, tileSize, FlxTilemap.OFF, tileGID);
			add(level);
		}
	}

	function getStartGid(tiledLevel:TiledMap, tilesheetName:String):Int {
		// This function gets the starting GID of a tilesheet

		// Note: "0" is empty tile, so default to a non-empty "1" value.
		var tileGID:Int = 1;

		for (tileset in tiledLevel.tilesets) {
			// We need to search the tileset's firstGID -- to do that,
			// we compare the tilesheet paths. If it matches, we
			// extract the firstGID value.
			var tilesheetPath:Path = new Path(tileset.imageSource);
			var thisTilesheetName = tilesheetPath.file + "." + tilesheetPath.ext;
			if (thisTilesheetName == tilesheetName) {
				tileGID = tileset.firstGID;
			}
		}

		return tileGID;
	}

	override public function update():Void {
		super.update();
	}

	override public function destroy():Void {
		super.destroy();
	}
}
}
