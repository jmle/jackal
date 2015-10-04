package ;

import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

class Cannon extends FlxSprite {
	public var currentAngle:Float;

	public function new() {
		super();

		loadGraphic("assets/images/jeep-cannon.png", true, 32, 32);

		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);

		// north/northwest/west/southwest/south
		animation.add("n", [0], 1, true);
		animation.add("n-nw", [1], 1, true);
		animation.add("nw", [2], 1, true);
		animation.add("w-nw", [3], 1, true);
		animation.add("w", [4], 1, true);
		animation.add("w-sw", [5], 1, true);
		animation.add("sw", [6], 1, true);
		animation.add("s-sw", [7], 1, true);
		animation.add("s", [8], 1, true);
		animation.play("n");

		origin = new FlxPoint(16, 22);
	}

	public override function update():Void {
		super.update();

		updateAnimation();
		updateOrigin();
		rotateCannon();

		FlxG.log.add("origin: " + origin);
	}

	private function updateAnimation():Void {
		if (currentAngle == 90) {
			animation.play("n");
		} else if (currentAngle > 90 && currentAngle < 120 || currentAngle < 90 && currentAngle > 45) {
			animation.play("n-nw");
		} else if (currentAngle >= 120 && currentAngle < 150 || currentAngle >= 30 && currentAngle < 60) {
			animation.play("nw");
		} else if (currentAngle >= 150 && currentAngle < 180 || currentAngle > 0 && currentAngle < 30) {
			animation.play("w-nw");
		} else if (currentAngle == 180 || currentAngle == 0) {
			animation.play("w");
		} else if (currentAngle > 180 && currentAngle < 210 || currentAngle >= 330 && currentAngle < 360) {
			animation.play("w-sw");
		} else if (currentAngle >= 210 && currentAngle < 240 || currentAngle >= 300 && currentAngle < 330) {
			animation.play("sw");
		} else if (currentAngle >= 240 && currentAngle < 270 || currentAngle > 270 && currentAngle <= 300) {
			animation.play("s-sw");
		} else if (currentAngle == 270) {
			animation.play("s");
		}
	}

	private function updateOrigin():Void {
		if (currentAngle == 90) {
			setOrigin(16, 22);
		} else if (currentAngle > 90 && currentAngle < 120) {
			setOrigin(18, 22);
		} else if (currentAngle >= 120 && currentAngle < 150) {
			setOrigin(21, 22);
		} else if (currentAngle >= 150 && currentAngle < 180) {
			setOrigin(23, 20);
		} else if (currentAngle == 180) {
			setOrigin(25, 17);
		} else if (currentAngle > 180 && currentAngle < 210) {
			setOrigin(25, 14);
		} else if (currentAngle >= 210 && currentAngle < 240) {
			setOrigin(21, 11);
		} else if (currentAngle >= 240 && currentAngle < 270) {
			setOrigin(20, 9);
		} else if (currentAngle == 270) {
			setOrigin(16, 11);
		} else if (currentAngle < 90 && currentAngle > 45) {
			setOrigin(14, 22);
		} else if (currentAngle >= 30 && currentAngle < 60) {
			setOrigin(11, 22);
		} else if (currentAngle > 0 && currentAngle < 30) {
			setOrigin(9, 20);
		} else if (currentAngle == 0) {
			setOrigin(7, 17);
		} else if (currentAngle >= 330 && currentAngle < 360) {
			setOrigin(8, 15);
		} else if (currentAngle >= 300 && currentAngle < 330) {
			setOrigin(11, 12);
		} else if (currentAngle > 270 && currentAngle <= 300) {
			setOrigin(12, 10);
		}
	}

	private function setOrigin(X:Float, Y:Float):Void {
		origin.x = X;
		origin.y = Y;
	}

	private function rotateCannon():Void {
		var dy:Float = FlxG.mouse.x - x;
		var dx:Float = y - FlxG.mouse.y;

		angle = FlxAngle.asDegrees(Math.atan2(dy, dx));
	}
}
