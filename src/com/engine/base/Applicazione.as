package com.engine.base
{
	import br.com.stimuli.loading.BulkLoader;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import mx.containers.Form;
	import mx.core.IVisualElementContainer;
	import mx.events.FlexEvent;
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
		protected var _loader:BulkLoader;
		protected var _design:Boolean;
		
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
			_gestoreProprieta = new com.engine.base.GestoreProprieta();
			_datiForma = new DatiForma(<applicazione/>);
			_datiForma.leggiParametri(this, parametri);
			_ridimensionatore = new Ridimensionatore();
			_loader = new BulkLoader("app");
			_design = true;
			this._impostaGestoriDefault();
		}
		
		protected function _impostaGestoriDefault():void
		{
			var $this:Applicazione = this;
			/*
			 * alla fine del caricamento dell'app aggiungo il pannello di controllo
			 * */
			this.addEventListener(FlexEvent.CREATION_COMPLETE,function (e:FlexEvent):void 
			{
				$this.addElement(_gestoreProprieta);

			});
			//gestione del cambio delle proprietà da tracciare nell'XML
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				$this._datiForma.proprieta.@[e.property] = e.newValue;
			});
			//gestione del cambio delle proprietà da visualizzare nel pannello di controllo
			this.addEventListener(FormaEvent.REFRESH_CP, function():void{
				if (_gestoreProprieta != null){
					_gestoreProprieta.aggiornaProprieta();
				}
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
				_gestoreProprieta.forma = e.target as IForma;
			});
			//gestione della rimozione/aggiunta di un elemento figlio
			this.addEventListener(ElementExistenceEvent.ELEMENT_ADD, function (e:ElementExistenceEvent):void{
				if (e.element != null && e.element is IForma){
					var f:IForma = e.element as IForma;
					f.datiForma.padre = $this;
				}
			});
			//inizio e fine del drag and drop
			$this._gestoreProprieta.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void{
				$this._gestoreProprieta.startDrag();
			});
			$this._gestoreProprieta.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void{
				$this._gestoreProprieta.stopDrag();
			});
			//in caso di cambio proprietà riguardanti il ridimesionatore notifico l'oggetto..
			$this.addEventListener(FormaEvent.REFRESH_RESIZER, function():void{
				_ridimensionatore.refresh();
			});
			//gestione dell'aggiunta di nuove immagini sul bulkloader
			$this.addEventListener(FormaEvent.UPDATE_ASSETS, function(e:FormaEvent){
				var img:Immagine;
				if (e == null) return;
				if (e is Immagine){
					img = e as Immagine;
					$this._loader.add(img.source);
				}
			});
			
		}
		public function get loader():BulkLoader{
			return _loader;
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
			if (_designMode) {
				this.dispatchEvent(new FormaEvent(FormaEvent.DESIGN, true));
			}
			else{
				this.dispatchEvent(new FormaEvent(FormaEvent.RUNTIME, true));
			}
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
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height"];
		}
	}

}