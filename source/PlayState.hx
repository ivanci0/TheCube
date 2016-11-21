package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;
import openfl.display.Tilemap;
import Sierra;

class PlayState extends FlxState
{
	// el nivel
	var ogmoLoader:FlxOgmoLoader;
	var tileMap:FlxTilemap;
	
	//personaje
	var jugador:Player;
	
	//pinches
	var grupoPinches:FlxTypedGroup<Pinches> = new FlxTypedGroup<Pinches>();
	var contPinches:Int = 0;
	var timerPinche:FlxTimer;
	
	//sierras
	var grupoSierras:FlxTypedGroup<Sierra> = new FlxTypedGroup<Sierra>();
	var contSierras:Int = 0;
	
	//flores
	var grupoFlores:FlxTypedGroup<Flor> = new FlxTypedGroup<Flor>();
	var contFlores:Int = 0;
	
	//HUD
	var _HUD:HUD;
	
	//puntaje y vidas
	var puntaje:Int = 15000;
	var vidas:Int = 3;
	
	//detalles de fin de partida
	var finalizo:Bool;
	var win:Bool;
	
	override public function create():Void
	{
		super.create();
		ogmoLoader = new FlxOgmoLoader(AssetPaths.RetroAdventure1__oel);
		tileMap = ogmoLoader.loadTilemap(AssetPaths.tiles__png, 32, 32, "tiles");
		
		FlxG.worldBounds.set(0, 0, tileMap.width, tileMap.height);
		FlxG.camera.setScrollBounds(0, tileMap.width, 0, tileMap.height);
		
		tileMap.setTileProperties(0, FlxObject.ANY);
		tileMap.setTileProperties(1, FlxObject.ANY);
		tileMap.setTileProperties(2, FlxObject.NONE);
		tileMap.setTileProperties(3, FlxObject.ANY);
		tileMap.setTileProperties(4, FlxObject.ANY);
		tileMap.setTileProperties(5, FlxObject.NONE);
		tileMap.setTileProperties(6, FlxObject.ANY);
		tileMap.setTileProperties(7, FlxObject.ANY);
		tileMap.setTileProperties(8, FlxObject.NONE);
		tileMap.setTileProperties(9, FlxObject.ANY);
		tileMap.setTileProperties(10, FlxObject.ANY);
		tileMap.setTileProperties(11, FlxObject.NONE);
		
		ogmoLoader.loadEntities(funsionPosicionar, "entities");
		
		FlxG.camera.follow(jugador);
		
		//timers
		timerPinche = new FlxTimer();
		timerPinche.start(1, completa, 0);
		//HUD
		_HUD = new HUD();
		
		add(tileMap);
		add(jugador);
		for (pinche in grupoPinches) 
		{
			add(pinche);
		}
		for (sierra in grupoSierras) 
		{
			add(sierra);
		}
		for (flor in grupoFlores) 
		{
			add(flor);
		}
		add(_HUD);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(tileMap, jugador);
		_HUD.actHUD(vidas, puntaje);
		colisionConPinche();
		colisionSierraTilemap();
		colisionConSierra();
		colisionConFlores();
		
		if (finalizo) 
		{
			return;
		}
		super.update(elapsed);
	}
	
	private function funsionPosicionar(entityName:String, entityData:Xml):Void{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "player") 
		{
			jugador = new Player(x, y);
		}
		if (entityName == "Pinche") 
		{
			grupoPinches.members[contPinches] = new Pinches(x, y, Tipete.On);
			contPinches++;
		}
		if (entityName == "PincheOff") 
		{
			grupoPinches.members[contPinches] = new Pinches(x, y, Tipete.Off);
			contPinches++;
		}
		if (entityName == "SierraHor") 
		{
			grupoSierras.members[contSierras] = new Sierra(x, y, Tipete.Horizontal);
			contSierras++;
		}
		if (entityName == "SierraVer") 
		{
			grupoSierras.members[contSierras] = new Sierra(x, y, Tipete.Vertical);
			contSierras++;
		}
		if (entityName == "Flor") 
		{
			grupoFlores.members[contFlores] = new Flor(x, y);
			contFlores++;
		}
	}
	//colisiones
	private function colisionConPinche():Void{
		for (pinche in grupoPinches) 
		{
			if (FlxG.collide(pinche,jugador)) 
			{
				if (vidas > 1) 
				{
					vidas--;
				}
				else 
				{
					jugador.kill();
				}
			}
		}
	}
	private function colisionConSierra():Void{
		for (sierra in grupoSierras) 
		{
			if (FlxG.overlap(sierra,jugador)) 
			{
				if (vidas > 1) 
				{
					vidas--;
				}
				else 
				{
					jugador.kill();
				}
			}
		}
	}
	private function colisionSierraTilemap():Void{
		for (sierra in grupoSierras) 
		{
			FlxG.collide(sierra, tileMap);
		}
	}
	private function colisionConFlores():Void{
		for (flor in grupoFlores) 
		{
			if (FlxG.overlap(flor,jugador)) 
			{
				jugador.setInfectado(!jugador.getInfectado());
				flor.kill();
			}
		}
	}
	private function completa(timerPinche:FlxTimer):Void{
		for (pinche in grupoPinches) 
		{
			pinche.setEncendido(!pinche.getEncendido());
		}
	}
}