package;

import kha.System;

class Main
{
	static inline var screenWidth = 1024;
  	static inline var screenHeight = 768;

	public static function main()
	{
		System.init("Unknown", screenWidth, screenHeight, function()
		{
			var game = new Unknown(screenWidth, screenHeight);
		});		
	}
}
