package com.engine.applicazione
{
	import air.update.ApplicationUpdater;
	import com.engine.applicazione.Applicazione;
	import com.engine.base.IForma;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.core.IVisualElement;
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
				var grpDO:DisplayObject;
				var tgtDO:DisplayObject;
				var gllH1:Point;
				
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
							//tutti i calcoli vanno fatti sul contenitore, non sull'oggetto stesso..
							grpDO = _gruppo as DisplayObject;
							tgtDO = _target.parent as DisplayObject;
							gllH1 = grpDO.localToGlobal(new Point(_h1.x, _h1.y));
							
							//anche qui la trasformazione deve essere basata sul contenitore della forma che si sta modificando
							_target.x = (tgtDO.globalToLocal(gllH1)).x + 5;
							_target.y = (tgtDO.globalToLocal(gllH1)).y + 5;
							
							impostaDaTarget();
							_h1.x = -5;
							_h1.y = -5;
						}
						
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
			this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				e.stopImmediatePropagation();
			});
		}
		
		private function impostaDaTarget():void
		{
			var appDO:DisplayObject = _applicazione as DisplayObject;
			var parentTgtDO:DisplayObject = _target.parent as DisplayObject;
			var globalTgt:Point = parentTgtDO.localToGlobal(new Point(_target.x, _target.y));
			var appTgt:Point = appDO.globalToLocal(globalTgt);
			
			x = appTgt.x;
			y = appTgt.y;
			altezza = _target.height;
			larghezza = _target.width;
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
				impostaDaTarget();
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
				
				
			}
		}
		
		public function set forma(forma:IForma):void
		{
			_target = forma;
			if (_target is Applicazione){
				_applicazione.removeElement(_ridimensionatore._gruppo);
			}	else{
				_applicazione.addElement(_ridimensionatore._gruppo);
			}
			refresh();
		}
	}

}