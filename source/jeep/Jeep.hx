package jeep;

import flixel.FlxObject;
import String;
import flixel.FlxSprite;

class Jeep extends FlxSprite {
	public var currentAngle:Float = 90;

	public function new() {
		super();

		loadGraphic("assets/images/jeep-spritesheet.png", true, 32, 32);
		width = 16;
		height = 16;
		offset.x += 8;
		offset.y += 8;

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
	}

	public override function update():Void {
		updateAnimation();

		super.update();
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
}
