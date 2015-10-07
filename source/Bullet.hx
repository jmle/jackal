package ;

import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Bullet extends FlxSprite {
	private static var SPEED:Float = 180;

	public function new() {
		super();

		loadGraphic("assets/images/bullet.png", false, 8, 8);
	}

	public override function update():Void {
		if (touching != 0) {
			kill();
		}

		super.update();
	}

	public override function kill():Void {
		if (!alive) return;

		super.kill();

		solid = false;
		velocity.set(0, 0);
	}

	public function shoot(location:FlxPoint, angle:Float):Void {
		super.reset(location.x, location.y);

		solid = true;

		FlxAngle.rotatePoint(SPEED, 0, 0, 0, angle, velocity);
	}
}
