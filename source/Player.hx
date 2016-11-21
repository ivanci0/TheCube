package;

import flixel.FlxG;
import flixel.FlxObject;
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
	var velocidad:Float = 0;
	var ang:Float;
	var infectado:Bool;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.RetroVirus__png, true, 32, 32);
		drag.x = drag.y = 1600;
		
		setFacingFlip(FlxObject.DOWN, false, true);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.UP, false, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		animation.add("quieto", [0], 0, false);
		animation.add("movHor", [8, 9, 10, 11, 12, 13], 6, true);
		animation.add("movVer", [1, 2, 3, 4, 5, 6], 6, true);
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
		
		if (!infectado) 
		{
			arriba = FlxG.keys.anyPressed([UP, W]);
			abajo = FlxG.keys.anyPressed([DOWN, S]);
			izq = FlxG.keys.anyPressed([LEFT, A]);
			der = FlxG.keys.anyPressed([RIGHT, D]);
		}
		else 
		{
			arriba = FlxG.keys.anyPressed([DOWN, S]);
			abajo = FlxG.keys.anyPressed([UP, W]);
			izq = FlxG.keys.anyPressed([RIGHT, D]);
			der = FlxG.keys.anyPressed([LEFT, A]);
		}
		
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
				else if (der && x < FlxG.worldBounds.width - width) 
				{
					ang += 45;
				}
				facing = FlxObject.UP;
			}
			else if (abajo && y < FlxG.worldBounds.height - height) 
			{
				ang = 90;
				if (izq && x > FlxG.camera.x) 
				{
					ang += 45;
				}
				else if (der && x < FlxG.worldBounds.width - width) 
				{
					ang -= 45;
				}
				facing = FlxObject.DOWN;
			}
			else if (izq && x > FlxG.camera.x) 
			{
				ang = 180;
				facing = FlxObject.LEFT;
			}
			else if (der && x < FlxG.worldBounds.width - width) 
			{
				ang = 0;
				facing = FlxObject.RIGHT;
			}
			else 
			{
				velocidad = 0;
			}
			velocity.set(velocidad, 0);
			velocity.rotate(FlxPoint.weak(0, 0), ang);
			
			if (velocity.x != 0 || velocity.y != 0) 
			{
				switch (facing) 
				{
					case FlxObject.UP:
						animation.play("movVer");
					case FlxObject.DOWN:
						animation.play("movVer");
					case FlxObject.LEFT:
						animation.play("movHor");
					case FlxObject.RIGHT:
						animation.play("movHor");
					default:
						animation.play("quieto");
				}
			}
		}
	}
	public function getInfectado():Bool{
		return infectado;
	}
	public function setInfectado(_infectado:Bool):Void{
		infectado = _infectado;
	}
}