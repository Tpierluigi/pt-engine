package com.engine.base
{
	import flash.filesystem.File;
	import flash.net.FileReference;
	import mx.utils.DirectoryEnumeration;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Archivio
	{
		private var _path:String
		
		public function Archivio()
		{
		
		}
		
		private function readContents(dir:String)
		{
			var f:File = new File(dir);
			var entries:Array = f.getDirectoryListing();
			for (var i:int = 0; i < entries.length; i++)
			{
				f = File(entries[i]);
				if (f.isDirectory)
				{
					readContents(f.nativePath);
				}
				else
				{
					processa(f);
				}
			}
		}
		
		private function processa(f:File)
		{
		
		}
		
		public function get path():String
		{
			return _path;
		}
		
		public function set path(value:String):void
		{
			_path = value;
		}
	}

}

class DatiFile
{
	private var _contenuto:Object;
	private var _figli:Vector.<DatiFile>;
}
