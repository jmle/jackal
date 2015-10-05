package jeep;

import String;
import flixel.FlxSprite;
import jeep.CombatJeepComponent;

class Jeep extends jeep.CombatJeepComponent {

	public function new() {
		super();

		loadGraphic("assets/images/jeep-spritesheet.png", true, 32, 32);
		initialise();
	}

	public override function update():Void {
		updateAnimation();

		super.update();
	}
}
