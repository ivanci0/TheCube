package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	var jugador:Player;
	override public function create():Void
	{
		super.create();
		jugador = new Player(10, 10);
		add(jugador);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
