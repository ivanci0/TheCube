package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author Ivan Baigorria
 */
class Player extends FlxSprite 
{
	var velocidad:Float;
	var ang:Float;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(48, 48, FlxColor.BLUE);
		drag.x = drag.y = 1600;
	}
	override public function update(elapsed:Float):Void 
	{
		Movimiento();
		super.update(elapsed);
	}
	private function Movimiento():Void{
		var arriba:Bool;
		var abajo:Bool;
		var izq:Bool;
		var der:Bool;
		
		arriba = FlxG.keys.anyPressed([UP, W]);
		abajo = FlxG.keys.anyPressed([DOWN, S]);
		izq = FlxG.keys.anyPressed([LEFT, A]);
		der = FlxG.keys.anyPressed([RIGHT, D]);
		
		if (arriba && abajo) 
		{
			arriba = abajo = false;
		}
		if (der && izq) 
		{
			der = izq = false;
		}
		
		if (arriba || abajo || der || izq) 
		{
			ang = 0;
			velocidad = 300;
			if (arriba && y > FlxG.camera.y) 
			{
				ang = -90;
				if (izq && x > FlxG.camera.x) 
				{
					ang -= 45;
				}
				else if (der && x < FlxG.width - width) 
				{
					ang += 45;
				}
			}
			else if (abajo && y < FlxG.height - height) 
			{
				ang = 90;
				if (izq && x > FlxG.camera.x) 
				{
					ang += 45;
				}
				else if (der && x < FlxG.width - width) 
				{
					ang -= 45;
				}
			}
			else if (izq && x > FlxG.camera.x) 
			{
				ang = 180;
			}
			else if (der && x < FlxG.width - width) 
			{
				ang = 0;
			}
			else 
			{
				velocidad = 0;
			}
			velocity.set(velocidad, 0);
			velocity.rotate(FlxPoint.weak(0, 0), ang);
		}
	}
}