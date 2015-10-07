package jeep;

import flixel.group.FlxTypedGroup;
import jeep.Jeep;
import flixel.util.FlxPoint;
import flixel.util.FlxAngle;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

class CombatJeep extends FlxSpriteGroup {
	private static var SMOOTH:Float = 7.5;
	private static var SPEED:Float = 180;

	private var jeep:Jeep;
	private var cannon:Cannon;

	private var currentAngle:Float = 90;
	private var targetAngle:Float;

	private var up:Bool;
	private var down:Bool;
	private var left:Bool;
	private var right:Bool;
	private var fire:Bool;

	public function new(bullets:FlxTypedGroup<Bullet>) {
		super();

		jeep = new Jeep();
		cannon = new Cannon(bullets);

		add(jeep);
		add(cannon);
	}

	public override function update():Void {
		super.update();

		updateKeys();
		updateMouse();

		if (up || down || left || right) {
			calculateTargetAngle();
			updateFacingDirection();
			updateCurrentAngle();
		} else {
			velocity = new FlxPoint(0, 0);
		}

		if (fire) {
			shoot();
		}
	}

	private function updateKeys():Void {
		up = FlxG.keys.anyPressed(["UP"]);
		down = FlxG.keys.anyPressed(["DOWN"]);
		left = FlxG.keys.anyPressed(["LEFT"]);
		right = FlxG.keys.anyPressed(["RIGHT"]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
	}

	private function updateMouse():Void {
		fire = FlxG.mouse.justPressed;
	}

	private function calculateTargetAngle():Void {
		var mA:Float = 0;

		if (up) {
			mA = -90;
			targetAngle = 90;
			if (left) {
				mA -= 45;
				targetAngle = 135;
			}
			else if (right) {
				mA += 45;
				targetAngle = 45;
			}
		}
		else if (down) {
			mA = 90;
			targetAngle = 270;
			if (left) {
				mA += 45;
				targetAngle = 225;
			}
			else if (right) {
				mA -= 45;
				targetAngle = 315;
			}
		}
		else if (left) {
			mA = 180;
			targetAngle = mA;
		}
		else {
			targetAngle = 0;
		}

		FlxAngle.rotatePoint(SPEED, 0, 0, 0, mA, velocity);
	}

	private function updateFacingDirection():Void {
		// Facing direction must vary according to the current angle, not the target one
		if (currentAngle < 90 || currentAngle > 270)
			facing = FlxObject.RIGHT;
		else if (currentAngle > 90 && currentAngle < 270)
			facing = FlxObject.LEFT;
		else if (currentAngle == 90)
			facing = FlxObject.UP;
		else
			facing = FlxObject.DOWN;
	}

	private function updateCurrentAngle():Void {
		if (currentAngle != targetAngle) {
			// Fix angles greater than 360 or negative
			if (currentAngle > 360)
				currentAngle %= 360;
			else if (currentAngle < 0)
				currentAngle = 360 - currentAngle;

			var diff:Float = Math.abs(currentAngle - targetAngle);

			if (currentAngle > targetAngle) {
				if (diff >= 180) {
					currentAngle += SMOOTH;
				}
				else {
					currentAngle -= SMOOTH;
				}
			} else {
				if (diff >= 180) {
					currentAngle -= SMOOTH;
				}
				else {
					currentAngle += SMOOTH;
				}
			}
		}

		jeep.currentAngle = currentAngle;
		cannon.currentAngle = currentAngle;
	}

	private function shoot() {
		if (fire) {
			cannon.shoot();
		}
	}
}

