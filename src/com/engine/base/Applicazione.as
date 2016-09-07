package com.engine.base
{
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mx.containers.Form;
	import mx.core.IVisualElementContainer;
	import mx.events.PropertyChangeEvent;
	import spark.components.BorderContainer;
	import spark.components.Group;
	import mx.controls.Alert;
	import com.engine.util.Utility;
	import spark.events.ElementExistenceEvent;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Applicazione extends BorderContainer implements IContenitore
	{
		protected var _datiForma:DatiForma;
		protected var _ridimensionatore:Ridimensionatore;
		protected var _designMode:Boolean;
		protected var _gestoreProprieta:com.engine.base.GestoreProprieta;
		
		//public  static function nuovaIstanza(id:String, lista:BorderContainer, parametri:Object = null):Applicazione{
		//var istanza:Applicazione;
		//istanza = Applicazione(new Forma(id, null,null));
		////devo rinominare l'XML con i dati della proprieta
		//istanza._proprieta.setName("applicazione");
		//istanza._proprieta.@id = id;
		//istanza._elementi = lista;
		//istanza._leggiParametri(parametri);
		//istanza._impostaGestoriDefault();
		//return istanza;
		//}
		
		function Applicazione(parametri:Object = null)
		{
			super();
			_datiForma = new DatiForma(<applicazione/>);
			_datiForma.leggiParametri(this, parametri);
			_ridimensionatore = new Ridimensionatore();
			_gestoreProprieta = new com.engine.base.GestoreProprieta();
			this.addElement(_gestoreProprieta);
			this._impostaGestoriDefault();
		}
		
		protected function _impostaGestoriDefault():void
		{
			//TODO da definire i listener  di default
			var $this:Applicazione = this;
			//gestione del cambio delle proprietà da tracciare nell'XML
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				$this._datiForma.proprieta.@[e.property] = e.newValue;
			});
			//gestore del click su di una forma contenuta
			/*
			 * TODO: da gestire il designmode
			 * */
			this.addEventListener(FormaEvent.CLICCATO, function(e:FormaEvent):void{
				//Alert.show(e.toString());
				_ridimensionatore = Ridimensionatore.getInstance();
				_ridimensionatore.applicazione = $this;
				_ridimensionatore.forma = e.target as IForma;
			});
			//gestione della rimozione/aggiunta di un elemento figlio
			this.addEventListener(ElementExistenceEvent.ELEMENT_ADD, function (e:ElementExistenceEvent):void{
				if (e.element != null && e.element is IForma){
					var f:IForma = e.element as IForma;
					f.datiForma.padre = $this;
				}
			});
			$this._gestoreProprieta.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void{
				$this._gestoreProprieta.startDrag();
			});
			$this._gestoreProprieta.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void{
				$this._gestoreProprieta.stopDrag();
			});
			
		}
		
		public function aggiungiElemento(forma:IForma):void
		{
			datiForma.proprieta.appendChild(forma.datiForma.proprieta);
		}
		
		public function get applicazione():Applicazione
		{
			return this;
		}
		
		public function get designMode():Boolean
		{
			return _designMode;
		}
		
		public function set designMode(value:Boolean):void
		{
			_designMode = value;
		}
		

		public function get datiForma():DatiForma
		{
			return _datiForma;
		}
		[Bindable]
		override public function get id():String{ return super.id; }
		override public function set id(val:String):void{ super.id = val;	}		
		[Bindable]
		override public function get x():Number{ return super.x; }
		override public function set x(val:Number):void{ super.x = val;	}
		[Bindable]
		override public function get y():Number{ return super.y; }
		override public function set y(val:Number):void{ super.y = val;	}
		[Bindable]
		override public function get width():Number{ return super.width; }
		override public function set width(val:Number):void{ super.width = val;	}
		[Bindable]
		override public function get height():Number{ return super.height; }
		override public function set height(val:Number):void{ super.height = val;	}
	}

}