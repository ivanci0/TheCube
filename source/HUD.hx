package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Ivan Baigorria
 */
class HUD extends FlxTypedGroup<FlxSprite>
{

	private var txtVida:FlxText;
	private var txtPuntuacion:FlxText;
	private var sprVida:FlxSprite;
	public function new()
	{
		super();
		txtVida = new FlxText(FlxG.camera.scroll.x + 10, FlxG.camera.scroll.y + 2, 0, "3", 8);
		txtPuntuacion = new FlxText(FlxG.camera.width - 30, txtVida.y, 0, "0", 8);
		sprVida = new FlxSprite(txtVida.x + txtVida.fieldWidth, txtVida.y, AssetPaths.vida__png);
		
		add(txtVida);
		add(txtPuntuacion);
		add(sprVida);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	public function actHUD(vidas:Int = 0, puntaje:Int = 0):Void{
		txtVida.text = Std.string(vidas);
		txtPuntuacion.text = Std.string(puntaje);
	}

	
}