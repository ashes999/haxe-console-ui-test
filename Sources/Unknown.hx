package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Scaler;
import kha.Color;

class Unknown
{	
	private static var bgColor = Color.fromValue(0x26004d);
	private var backbuffer: Image;

	public function new(screenWidth:Int, screenHeight:Int)
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
	}

	function update(): Void
	{		
	}

	public function render(framebuffer: Framebuffer): Void
	{
		var g = backbuffer.g2;

		// clear our backbuffer using graphics2
		g.begin(bgColor);
		g.end();

		// draw our backbuffer onto the active framebuffer
		framebuffer.g2.begin();
		//Scaler.scale(backbuffer, framebuffer, System.screenRotation);		
		framebuffer.g2.end();
	}
}
