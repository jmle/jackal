package ;

import flixel.util.FlxPoint;
class Util {
	public static var ZERO:FlxPoint = new FlxPoint(0, 0);

	public static inline function turnLeft(current:Float, target:Float):Bool {
		if (target == 0 && current >= 180)
			target = 360;

		return Math.abs(target - current) <= 180;
	}
}
