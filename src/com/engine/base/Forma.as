package com.engine.base 
{
	import mx.core.IVisualElement;
	import spark.components.Group;
	/**
	 * ...
	 * @author pier
	 */
	public class Forma 
	{
		protected var _propertySet:XML;
		protected var _designMode:Boolean;
		internal var _elementi:Group;
		public function Forma(id:String,padre:Forma) 
		{
			//_propertySet = new XML();
			_propertySet =<forma/>;
			_propertySet.@id = id;
			_elementi = new Group();
			if (padre != null) {
				padre._elementi.addElement(_elementi);
				padre._propertySet.appendChild(_propertySet);
			}
			
		}
		
		public function get y():Number 
		{
			return _propertySet.@y;
		}
		
		public function set y(value:Number):void 
		{
			_propertySet.@y = value;
		}
		
		public function get x():Number 
		{
			return _propertySet.@x;
		}
		
		public function set x(value:Number):void 
		{
			_propertySet.@x = value;
		}
		
		public function get id():String 
		{
			return _propertySet.@id;
		}
		
		public function get propertySet():XML 
		{
			return _propertySet;
		}
		
		public function get designMode(): Boolean
		{
			return _designMode;
		}
		
		public function set designMode(value:Boolean):void 
		{
			_designMode = value;
		}
	}

}