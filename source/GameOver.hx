package;

import flixel.FlxState;

/**
 * ...
 * @author Ivan Baigorria
 */
class GameOver extends FlxState 
{
	private var _win:Bool;
	private var _score:Int;
	private var btnMenu:FlxButton;
	private var txtTitulo:FlxText;
	private var txtMensaje:FlxText;
	private var txtScore:FlxText;
	private var sndGano:FlxSound;
	public function new(win:Bool,score:Int) 
	{
		_win = win;
		_score = score;
		sndGano = FlxG.sound.load(AssetPaths.alfGana__ogg);
		super();
	}
	override public function create():Void 
	{
		FlxG.cameras.bgColor = 0xfffee4a0;
		if (_win){
			sndGano.play();
		}
		
		txtTitulo = new FlxText(0, 20, 0, _win ? "Ganaste!" : "Perdiste!", 20);
		txtTitulo.alignment = CENTER;
		txtTitulo.screenCenter(FlxAxes.X);
		add(txtTitulo);
		
		txtMensaje = new FlxText(0, FlxG.height / 3, 0, "Puntaje final", 8);
		txtMensaje.alignment = CENTER;
		txtMensaje.screenCenter(FlxAxes.X);
		add(txtMensaje);
		
		txtScore = new FlxText(0, txtMensaje.y + 10, 0, Std.string(_score), 8);
		txtScore.alignment = CENTER;
		txtScore.screenCenter(FlxAxes.X);
		add(txtScore);
		
		btnMenu = new FlxButton(0, FlxG.height - 30, "Menu", irMenu);
		btnMenu.screenCenter(FlxAxes.X);
		add(btnMenu);
		super.create();
	}
	public function irMenu():Void{
		FlxG.camera.fade(FlxColor.BLACK,.33,false,function(){
			FlxG.switchState(new MenuState());
		});
	}

}