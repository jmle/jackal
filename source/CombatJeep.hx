package ;

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

	public function new() {
		super();

		jeep = new Jeep();
		cannon = new Cannon();

		add(jeep);
		add(cannon);
	}

	public override function update():Void {
		super.update();

		calculateTargetAngle();
	}

	// TODO: refactor method
	private function calculateTargetAngle():Void {
		var up:Bool = FlxG.keys.anyPressed(["UP"]);
		var down:Bool = FlxG.keys.anyPressed(["DOWN"]);
		var left:Bool = FlxG.keys.anyPressed(["LEFT"]);
		var right:Bool = FlxG.keys.anyPressed(["RIGHT"]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right) {
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

			// Facing direction must vary according to the current angle, not the target one
			if (currentAngle < 90 || currentAngle > 270)
				facing = FlxObject.RIGHT;
			else if (currentAngle > 90 && currentAngle < 270)
				facing = FlxObject.LEFT;
			else if (currentAngle == 90)
				facing = FlxObject.UP;
			else
				facing = FlxObject.DOWN;

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

			FlxAngle.rotatePoint(SPEED, 0, 0, 0, mA, velocity);
		} else {
			velocity = new FlxPoint(0, 0);
		}

		jeep.currentAngle = currentAngle;
		cannon.currentAngle = currentAngle;
	}

}

