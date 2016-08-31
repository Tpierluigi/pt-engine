package com.engine.base
{
	import flash.events.EventDispatcher;
	import mx.graphics.IFill;
	import spark.components.BorderContainer;
	import spark.components.Group;
	
	/**
	 * ...
	 * @author pier
	 */
	internal class Ridimensionatore extends EventDispatcher
	{
		private var _h1:BorderContainer;
		private var _h2:BorderContainer;
		private var _gruppo:Group;
		private static var ridimensionatore:Ridimensionatore;
		
		private var _x:Number;
		private var _y:Number;
		private var _larghezza:Number;
		private var _altezza:Number;
		private var _target:Forma;
		
		public function Ridimensionatore()
		{
			if (ridimensionatore == null)
			{
				crea;
			}
			this = ridimensionatore;
		}
		
		private function crea()
		{
			var gestH1:Function;
			var gestH2:Function;
			with (ridimensionatore)
			{
				//definisco i due punti di spostamento/ridimensionamento..
				
				_h1 = new BorderContainer();
				_h2 = new BorderContainer();
				_gruppo = new Group();
				_h1.width = 10;
				_h1.height = 10;
				_h1.x = -5;
				_h1.y = -5;
				_h1.backgroundFill = new IFill(0xff0000);
				_h2.width = 10;
				_h2.height = 10;
				_h2.backgroundFill = new SolidColor(0x0000ff);
				_gruppo.addElement(_h1);
				_gruppo.addElement(_h2);
			}
			//gestione della maniglia rossa
			gestH1 = function(e:MouseEvent):void
			{
				if (e.type == MouseEvent.MOUSE_DOWN)
				{
					ridimensionatore._h1.startDrag();
					
				}
				else if (e.type == MouseEvent.MOUSE_UP)
				{
					with (ridimensionatore)
					{
						_h1.stopDrag();
						x = _h1.x + 5;
						y = _h1.y + 5;
						_h1.x = -5;
						_h1.y = -5;
						ridimensionaTarget();
					}
					e.stopPropagation();
				}
				//gestione della maniglia blu
				gestH2 = function(e:MouseEvent):void
				{
					if (e.type == MouseEvent.MOUSE_DOWN)
					{
						ridimensionatore.startDrag();
					}
					else if (e.type == MouseEvent.MOUSE_UP)
					{
						with (ridimensionatore)
						{
							_h2.stopDrag();
							larghezza = _h2.x - _h1.x;
							altezza = _h2.y - _h1.y;
						}
						ridimensionaTarget();
						
					}
					e.stopPropagation();
				
				}
				/*
				 * gestione del click sulla forma: in modalità design, vengono
				 * alternativamente mostrate/nascoste le maniglie di posizionamento
				 * */
				/*
				   gestClick = function(e:MouseEvent):void
				   {
				   if (_designMode)
				   {
				   if (!_hasFocus)
				   {
				   setFocus();
				   }
				   else
				   {
				   blur();
				   }
				   }
				   e.stopPropagation();
				   }
				 */
				_h1.addEventListener(MouseEvent.MOUSE_DOWN, gestH1);
				_h2.addEventListener(MouseEvent.MOUSE_DOWN, gestH2);
				_h1.addEventListener(MouseEvent.MOUSE_UP, gestH1);
				_h2.addEventListener(MouseEvent.MOUSE_UP, gestH2);
			
			}
		}
		
		private function ridimensionaTarget():void
		{
			with (ridimensionatore)
			{
				if (_target)
				{
					_target.x = x;
					_target.y = y;
					_target.altezza = altezza;
					_target.larghezza = larghezza;
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
			
			public function setTarget(target:Forma):void
			{
				with (ridimensionatore)
				{
					//se sto facendo un attachment sensato..
					if (target.padre)
					{
						//rimuovo il ridimensionatore dal vecchio elemento
						if (_target)
						{
							_target.padre._elementi.removeElement(_gruppo);
						}
						//lo associo alla nuova forma
						target.padre._elementi.addElement(_gruppo);
					}
				}
			}
		}
	
	}