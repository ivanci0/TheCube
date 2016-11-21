package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import Sierra;

/**
 * ...
 * @author Ivan Baigorria
 */
class Pinches extends FlxSprite 
{
	var encendido:Bool;
	var tipo:Tipete;
	public function new(?X:Float=0, ?Y:Float=0, _tipo:Tipete) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.pinches__png, true, 32, 32);
		animation.add("off", [0]);
		animation.add("on", [1]);
		immovable = true;
		tipo = _tipo;
		
		if (tipo == Tipete.On) 
		{
			encendido = true;
		}
		else 
		{
			encendido = false;
		}
	}
	override public function update(elapsed:Float):Void 
	{
		Activar();
		super.update(elapsed);
	}
	public function Activar():Void{
		if (encendido) 
		{
			solid = true;
			animation.play("on");
		}
		else 
		{
			solid = false;
			animation.play("off");
		}
	}
	public function setEncendido(_encendido:Bool):Void{
		encendido = _encendido;
	}
	public function getEncendido():Bool{
		return encendido;
	}
}