package com.engine.applicazione
{
	import br.com.stimuli.loading.BulkLoader;
	import com.engine.applicazione.GestoreProprieta;
	import com.engine.base.ContenitoreHandlers;
	import com.engine.base.Cornice;
	import com.engine.base.DatiForma;
	import com.engine.base.FormaEvent;
	import com.engine.base.FormaHandlers;
	import com.engine.base.IContenitore;
	import com.engine.base.IForma;
	import com.engine.base.Immagine;
	import com.engine.base.Rettangolo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.core.IVisualElement;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import spark.components.BorderContainer;
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
		protected var _gestoreProprieta:GestoreProprieta;
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
			_gestoreProprieta = new GestoreProprieta();
			_datiForma = new DatiForma(<applicazione/>);
			_datiForma.leggiParametri(this, parametri);
			_ridimensionatore = new Ridimensionatore();
			_loader = new BulkLoader("app");
			_design = true;
			this._impostaGestoriDefault();
		}
		
		public function get defaultHandlers():FormaHandlers{
			return new ContenitoreHandlers();
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
			/*
			 * gestione del click della forma
			 * */
			
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				defaultHandlers.clickHandler($this, e);
			});
			//gestione del cambio delle proprietà da tracciare nell'XML
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				defaultHandlers.propChangeHandler($this, e);
			});
			//gestione del cambio delle proprietà da visualizzare nel pannello di controllo
			this.addEventListener(FormaEvent.REFRESH_CP, function():void{
				if (_gestoreProprieta != null){
					_gestoreProprieta.aggiornaProprieta();
					_gestoreProprieta.aggiornaAzioni();
				}
			});
			//gestore del click su di una forma contenuta
			/*
			 * TODO: da gestire il designmode
			 * */
			this.addEventListener(FormaEvent.CLICCATO, function(e:FormaEvent):void{
				_ridimensionatore = Ridimensionatore.getInstance();
				_ridimensionatore.applicazione = $this;
				if (!(e.target is Applicazione)){
					_ridimensionatore.forma = e.target as IForma;
				}else{
					//_ridimensionatore.forma = null;
				}
				_gestoreProprieta.forma = e.target as IForma;
				e.stopImmediatePropagation();
			});
			//gestione della rimozione/aggiunta di un elemento figlio
			this.addEventListener(FormaEvent.FORMA_AGGIUNTA, function (e:FormaEvent):void{
				(defaultHandlers as ContenitoreHandlers).handlerAggiunto($this, e);
			});
			this.addEventListener(FormaEvent.FORMA_RIMOSSA, function(e:FormaEvent):void{
				(defaultHandlers as ContenitoreHandlers).handlerRimosso($this, e);
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
			$this.addEventListener(FormaEvent.AGGIORNA_ASSETS, function(e:FormaEvent):void{
				var img:Immagine;
				if (e == null) return;
				if (e.target is Immagine){
					img = e.target as Immagine;
					if (img.sourcePath!=null && img.sourcePath!="" && !$this.loader.hasItem(img.sourcePath)){
						$this._loader.add(img.sourcePath);
					}
				}
			});
		}
		public function rimuoviDaDisplayList():void{
			return; //non fa niente..
		}
		public function aggiungiForma(forma:IForma):void{
			this.addElement(forma);
			this.dispatchEvent(new FormaEvent(FormaEvent.FORMA_AGGIUNTA, true, false, {f:forma}));
		}
		public function rimuoviFormadaDisplayList(forma:IForma):void{
			this.removeElement(forma);
			this.dispatchEvent(new FormaEvent(FormaEvent.FORMA_RIMOSSA, true, false, {f:forma}));
			this._ridimensionatore.forma = null;
			this._gestoreProprieta.forma = null;
		}
		public function get loader():BulkLoader{
			return _loader;
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
			if (!_designMode && value) {
				this.dispatchEvent(new FormaEvent(FormaEvent.DESIGN, true));
			}
			if (_designMode && !value) {
				this.dispatchEvent(new FormaEvent(FormaEvent.RUNTIME, true));
			}
			_designMode = value;

		}
		public function nuovoRettangolo():void{
			this.aggiungiForma(new Rettangolo(null,{id:"forma_"+(new Date().time)}));
		}
		public function nuovaImmagine():void 
		{
			this.aggiungiForma(new Immagine(null,{width:100,height:100,source:"filename",id:"forma_"+(new Date().time)}));
		}
		public function nuovaCornice():void 
		{
			this.aggiungiForma(new Cornice(null,{width:100,height:100,id:"forma_"+(new Date().time),borderColor:0}));
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
		public function get listaAzioni():Array{
			return [
				{f:"nuovoRettangolo", c:"Nuovo rettangolo"},
				{f:"nuovaImmagine", c:"Nuova immagine"},
				{f:"nuovaCornice", c:"Nuova cornice"},
				
				]
		}
		
		
	}

}