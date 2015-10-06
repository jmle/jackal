package ;

import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Bullet extends FlxSprite {
	public function new() {
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

		solid = false;
		alive = false;
		exists = false;
		velocity.set(0, 0);
	}

	public function shoot(location:FlxPoint, angle:Float):Void {
		super.reset(location.x, location.y);

		solid = true;
	}
}
