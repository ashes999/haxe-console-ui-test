package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Scaler;
import kha.Color;
import kha.Font;
import kha.Assets;

class Unknown
{	
	private static var bgColor = Color.fromValue(0x26004d);
	private var backbuffer: Image;
	private var font:Font;
	private var initialized:Bool = false;
	
	private var frames:Int = 0;
	private var start:Date;
	private var lastUpdate:Date;

	public function new(screenWidth:Int, screenHeight:Int)
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		
		Assets.loadEverything(function()
		{
			trace("DONE");
			initialized = true;
			font = Assets.fonts.SpaceMono;
			start = Date.now();
			lastUpdate = Date.now();
		});
	}

	function update(): Void
	{		
	}

	public function render(framebuffer:Framebuffer): Void
	{
		if (!initialized)
		{
			return;
		}

		frames += 1;
		var g = backbuffer.g2;

		// clear our backbuffer using graphics2
		g.begin(bgColor);
		g.font = font;
		g.fontSize = 24;

		g.drawString("################################################################################", 4, 0);
		for (i in 1 ... 48)
		{
			g.drawString("#..............................................................................#", 4, 12 * i);
		}
		g.drawString("################################################################################", 4, 12 * 48);

		g.end();

		// draw our backbuffer onto the active framebuffer
		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);		
		framebuffer.g2.end();

		var now = Date.now();
		var elapsedSeconds:Float = (now.getTime() - start.getTime()) / 1000;
		
		var sinceUpdate:Float = (now.getTime() - lastUpdate.getTime()) / 1000;
		if (sinceUpdate >= 1)
		{
			var fps = this.frames / sinceUpdate;
			trace(fps + " FPS");
			this.frames = 0;
			lastUpdate = now;
		}
	}
}
