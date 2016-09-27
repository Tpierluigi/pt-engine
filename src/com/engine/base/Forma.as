package com.engine.base
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.GroupBase;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Forma extends EventDispatcher
	{
		protected var _proprieta:XML;
		
		protected var _padre:Forma;
		internal var _elementi:SkinnableContainer;
		/**
		 * per avere più flessibilità nel creare oggetti, esiste questo factory che permette
		 * di dividere la creazione dell'oggetto in più fasi
		 * impostazione interna dell'oggetto
		 * impostazione dei parametri
		 * impostazione degli eventi
		 * @param	id
		 * @param	padre
		 * @param	parametri
		 */
		public static function nuovaIstanza(id:String, padre:Forma, parametri:Object = null):Forma{
			var istanza:Forma = new Forma(id, padre, parametri);
			istanza._leggiParametri(parametri);
			istanza._impostaGestoriDefault();
			return istanza;
		}
		
		public  function Forma(id:String, padre:Forma, parametri:Object=null)
		{
			//_propertySet = new XML();
			_proprieta = <forma/>;
			_proprieta.@id = id;
			_elementi = new SkinnableContainer();
			if (padre != null)
			{
				padre._elementi.addElement(_elementi);
				padre._proprieta.appendChild(_proprieta);
				_padre = padre;
			}
		}
		/**
		 * gestione degli eventi: l'oggetto definisce degli eventi di tipo formaEvent, attivati da interazioni
		 * del mouse sui suoi componenti grafici o altro. derivando la funzione _defaultHandlers, si possono 
		 * inserire i gestori di default anche a questi eventi
		 */
		protected function _impostaGestoriDefault():void{
			var $this:Forma = this;
			this._elementi.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				var formaEvent:FormaEvent;
				formaEvent = new  FormaEvent("formaClick");
				dispatchEvent(formaEvent);
				e.stopImmediatePropagation();
			});
		}
		public function get x():Number
		{
			return _proprieta.@x;
		}
		
		public function get y():Number
		{
			return _proprieta.@y;
		}
		
		public function get larghezza():Number
		{
			return _proprieta.@larghezza;
		}
		
		public function get altezza():Number
		{
			return _proprieta.@altezza;
		}
		
		[Bindable]
		public function set x(value:Number):void
		{
			_proprieta.@x = value;
		}
		
		[Bindable]
		public function set y(value:Number):void
		{
			_proprieta.@y = value;
		}
		
		[Bindable]
		public function set larghezza(value:Number):void
		{
			_proprieta.@larghezza = value;
		}
		
		[Bindable]
		public function set altezza(value:Number):void
		{
			_proprieta.@altezza = value;
		}
		
		public function get id():String
		{
			return _proprieta.@id;
		}
		
		public function get propertySet():XML
		{
			return _proprieta;
		}
		
		public function get padre():Forma 
		{
			return _padre;
		}
		

		
		public function attachTo(f:Forma):void
		{
			this.x = 0;
			this.y = 0;
			if (_padre != null)
			{
				_padre._elementi.removeElement(this._elementi);
				_padre._proprieta.item.((@id == this.id) && (delete parent().children()[valueOf().childIndex()]));
			}
			f._elementi.addElement(_elementi);
			f._proprieta.appendChild(_proprieta);
			_padre = f;
		}
		
		protected function _leggiParametri(parametri:Object):void 
		{
			if (parametri != null)
			{
				for (var voce:String in parametri) 
				{
					if (this.hasOwnProperty(voce)){
						this[voce] = parametri[voce];
					}
				}				
			}
		}
		public function CreaForma(nodo:XML):IForma{
			var forma:IForma;
			var attributo:XML;
			switch((nodo.name as QName).toString().toLowerCase()){
				case "rettangolo" : forma = new Rettangolo(nodo.parent);
				case "immagine" : forma = new Immagine(nodo.parent);
				case "cornice" : forma = new Cornice(nodo.parent);
				default: return null;
			}
			for each (attributo in nodo.attributes()){
				forma[attributo.name] = attributo.attribute(attributo.name);
			}
			return forma;
		}
	}

}