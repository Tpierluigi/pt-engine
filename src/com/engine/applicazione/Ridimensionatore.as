package com.engine.applicazione
{
	import air.update.ApplicationUpdater;
	import com.engine.applicazione.Applicazione;
	import com.engine.base.IForma;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	import spark.components.BorderContainer;
	import spark.components.Group;
	
	/**
	 * singleton per gestire un aggeggio grafico che permette di spostare/ridimensionare una forma
	 * @author pier
	 */
	internal class Ridimensionatore extends EventDispatcher
	{
		private var _h1:BorderContainer;
		private var _h2:BorderContainer;
		private var _gruppo:Group;
		private static var _ridimensionatore:Ridimensionatore;
		
		private var _x:Number;
		private var _y:Number;
		private var _oldX:Number;
		private var _oldY:Number;
		
		private var _larghezza:Number;
		private var _altezza:Number;
		private var _target:IForma;
		private var _applicazione:Applicazione;
		
		public function Ridimensionatore()
		{
			if (_ridimensionatore != null)
			{
				throw new Error("Singleton");
			}
		}
		
		public static function getInstance():Ridimensionatore
		{
			if (Ridimensionatore._ridimensionatore == null)
			{
				_ridimensionatore = new Ridimensionatore();
				_ridimensionatore.crea();
			}
			return _ridimensionatore;
		
		}
		
		private function crea():void
		{
			var gestH1:Function;
			var gestH2:Function;
			var $this:Ridimensionatore = this;
			_h1 = new BorderContainer();
			
			_h2 = new BorderContainer();
			_gruppo = new Group();
			_h1.width = 10;
			_h1.height = 10;
			_h1.x = -5;
			_h1.y = -5;
			_h1.backgroundFill = new SolidColor(0xff0000);
			_h2.width = 10;
			_h2.height = 10;
			_h2.backgroundFill = new SolidColor(0x0000ff);
			_gruppo.addElement(_h1);
			_gruppo.addElement(_h2);
			//gestione della maniglia rossa
			gestH1 = function(e:MouseEvent):void
			{
				if (e.type == MouseEvent.MOUSE_DOWN)
				{
					_ridimensionatore._h1.startDrag();
					
				}
				else if (e.type == MouseEvent.MOUSE_UP)
				{
					with (_ridimensionatore)
					{
						_h1.stopDrag();
						if (_target)
						{
							_target.x += _h1.x + 5;
							_target.y += _h1.y + 5;
						}
						x += _h1.x + 5;
						y += _h1.y + 5
						_h1.x = -5;
						_h1.y = -5;
					}
					e.stopPropagation();
				}
			}
			//gestione della maniglia blu
			gestH2 = function(e:MouseEvent):void
			{
				if (e.type == MouseEvent.MOUSE_DOWN)
				{
					_ridimensionatore._h2.startDrag();
				}
				else if (e.type == MouseEvent.MOUSE_UP)
				{
					with (_ridimensionatore)
					{
						_h2.stopDrag();
						larghezza = _h2.x - _h1.x;
						altezza = _h2.y - _h1.y;
						if (_target)
						{
							_target.width = larghezza;
							_target.height = altezza;
						}
					}
					
				}
				e.stopPropagation();
			}
			
			_h1.addEventListener(MouseEvent.MOUSE_DOWN, gestH1);
			_h2.addEventListener(MouseEvent.MOUSE_DOWN, gestH2);
			_h1.addEventListener(MouseEvent.MOUSE_UP, gestH1);
			_h2.addEventListener(MouseEvent.MOUSE_UP, gestH2);
		}
		
		public function refresh():void 
		{
			if (_target == null)
			{
				x = 0;
				y = 0;
				altezza = 0;
				larghezza = 0;
			}
			else
			{
				x = _target.x;
				y = _target.y;
				altezza = _target.height;
				larghezza = _target.width;
			}
		
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
			_gruppo.x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
			_gruppo.y = value;
		}
		
		public function get larghezza():Number
		{
			return _larghezza;
		}
		
		public function set larghezza(value:Number):void
		{
			_larghezza = value;
			_h2.x = value - 5;
		}
		
		public function get altezza():Number
		{
			return _altezza;
		}
		
		public function set altezza(value:Number):void
		{
			_altezza = value;
			_h2.y = value - 5;
		}
		
		public function set applicazione(app:Applicazione):void
		{
			//se sto facendo un attachment sensato..
			if (app != null)
			{
				//lo associo alla nuova forma
				_applicazione = app;
				_applicazione.addElement(_ridimensionatore._gruppo);
				
			}
		}
		
		public function set forma(forma:IForma):void
		{
			_target = forma;
			refresh();
		}
	}

}