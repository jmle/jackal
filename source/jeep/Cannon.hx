package jeep;

import flixel.group.FlxTypedGroup;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.util.FlxPoint;
import jeep.CombatJeepComponent;

class Cannon extends jeep.CombatJeepComponent {

	private var bullets:FlxTypedGroup<Bullet>;

	public function new(bullets:FlxTypedGroup<Bullet>) {
		super();

		loadGraphic("assets/images/jeep-cannon.png", true, 32, 32);
		initialise();

		origin = new FlxPoint(16, 22);
		this.bullets = bullets;
	}

	public override function update():Void {
		super.update();

		updateAnimation();
		updateOrigin();
		rotateCannon();
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

	public function shoot():Void {
		// TODO: Fix location
		var location:FlxPoint = new FlxPoint(x + origin.x, y + origin.y);

		bullets.recycle(Bullet).shoot(location, angle);
	}
}
