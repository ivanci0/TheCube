package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	var botonJugar:FlxButton;
	override public function create():Void
	{
		super.create();
		botonJugar = new FlxButton(0, 0, "Jugar", clickJugar);
		botonJugar.screenCenter();
		add(botonJugar);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	function clickJugar():Void{
		FlxG.switchState(new PlayState());
	}
}
