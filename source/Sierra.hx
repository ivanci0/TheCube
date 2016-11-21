package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author Ivan Baigorria
 */
class Sierra extends FlxSprite 
{
	var izq:Bool;
	var arriba:Bool;
	var moverse:Bool = true;
	var timer:FlxTimer;
	var tipo:Tipete;
	var velocidad:Int;
	public function new(?X:Float=0, ?Y:Float=0, _tipo:Tipete) 
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.BLUE);
		timer = new FlxTimer();
		tipo = _tipo;
		velocidad = 200;
	}
	override public function update(elapsed:Float):Void 
	{
		Moverse();
		patron();
		super.update(elapsed);
	}
	public function Moverse():Void{
		if (moverse && tipo == Tipete.Horizontal) 
		{
			if (izq) 
			{
				velocity.x = -velocidad;
			}
			else 
			{
				velocity.x = velocidad;
			}
		}
		else if (moverse && tipo == Tipete.Vertical) 
		{
			if (arriba) 
			{
				velocity.y = -velocidad;
			}
			else 
			{
				velocity.y = velocidad;
			}
		}
		else 
		{
			velocity.x = 0;
			velocity.y = 0;
		}
	}
	public function patron():Void{
		if (isTouching(FlxObject.LEFT) || isTouching(FlxObject.RIGHT) || isTouching(FlxObject.UP) || isTouching(FlxObject.DOWN)) 
		{
			moverse = false;
			timer.start(2, cambiarDireccion);
		}
	}
	public function cambiarDireccion(timer:FlxTimer):Void{
		moverse = true;
		if (izq) 
		{
			izq = false;
		}
		else 
		{
			izq = true;
		}
		
		if (arriba) 
		{
			arriba = false;
		}
		else 
		{
			arriba = true;
		}
	}
}

enum Tipete {
	Vertical;
	Horizontal;
	On;
	Off;
}