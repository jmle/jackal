package;

import flixel.group.FlxTypedGroup;
import jeep.CombatJeep;
import flixel.FlxState;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var level:TiledLevel;
	private var combatJeep:CombatJeep;
	private var bullets:FlxTypedGroup<Bullet>;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		level = new TiledLevel("assets/maps/desert_1.tmx");
		add(level.foregroundTiles);

		bullets = new FlxTypedGroup<Bullet>();
		bullets.maxSize = 10;

		combatJeep = new CombatJeep(bullets);
		combatJeep.setPosition(0, 0);
		add(combatJeep);

		add(bullets);

		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		level.collideWithLevel(combatJeep);

		super.update();
	}	
}