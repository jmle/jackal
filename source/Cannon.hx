package ;

import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Cannon extends FlxSprite {
	public var currentAngle:Float;
	public var currentPosition:FlxPoint;

	public function new() {
		super();

		loadGraphic("assets/images/jeep-cannon.png", false, 32, 32);
		currentPosition = new FlxPoint(0, 0);
		origin = new FlxPoint(16, 22);
	}

	public override function update():Void {
		super.update();

//		placeCannon();
		rotateCannon();

		FlxG.log.add("cannon: " + new FlxPoint(x, y));
	}

	private function placeCannon():Void {
		if (currentAngle == 90) {
			setPosition(currentPosition.x, currentPosition.y);
		} else if (currentAngle > 90 && currentAngle < 120) {
			setPosition(currentPosition.x + 2, currentPosition.y);
		} else if (currentAngle >= 120 && currentAngle < 150) {
			setPosition(currentPosition.x + 3, currentPosition.y - 1);
		} else if (currentAngle >= 150 && currentAngle < 180) {
			setPosition(currentPosition.x + 7, currentPosition.y - 4);
		} else if (currentAngle == 180) {
			setPosition(currentPosition.x + 8, currentPosition.y - 7);
		} else if (currentAngle < 90 && currentAngle > 60) {
			setPosition(currentPosition.x - 2, currentPosition.y);
		} else if (currentAngle >= 60 && currentAngle < 30) {
			setPosition(currentPosition.x, currentPosition.y - 1);
		} else if (currentAngle <= 30 && currentAngle > 0) {
			setPosition(currentPosition.x - 7, currentPosition.y - 4);
		} else if (currentAngle == 0) {
			setPosition(currentPosition.x - 8, currentPosition.y - 7);
		} else if (currentAngle > 180 && currentAngle < 210) {
			setPosition(currentPosition.x + 8, currentPosition.y - 9);
		} else if (currentAngle >= 210 && currentAngle < 240) {
			setPosition(currentPosition.x + 6, currentPosition.y - 12);
		} else if (currentAngle >= 240 && currentAngle < 270) {
			setPosition(currentPosition.x + 6, currentPosition.y - 12);
		} else if (currentAngle == 270) {
			setPosition(currentPosition.x, currentPosition.y - 13);
		} else if (currentAngle > 270 && currentAngle < 300) {
			setPosition(currentPosition.x - 2, currentPosition.y - 13);
		} else if (currentAngle >= 300 && currentAngle < 330) {
			setPosition(currentPosition.x - 2, currentPosition.y - 13);
		} else if (currentAngle >= 330 && currentAngle < 360) {
			setPosition(currentPosition.x - 5, currentPosition.y - 9);
		}
	}

	private function rotateCannon():Void {
		var dy:Float = FlxG.mouse.x - currentPosition.x;
		var dx:Float = currentPosition.y - FlxG.mouse.y;

		angle = FlxAngle.asDegrees(Math.atan2(dy, dx));
	}
}
