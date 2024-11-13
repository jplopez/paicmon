animated=object:extend({
	x=64, y=64,
  oldx=64,oldy=64,
	dx=0.3, dy=0.3,
	state=idle,
  flx=false, --false=left
  playable=true, --false=ignores inputs
  anim={},
	
	input=function(_ENV)
		if(btn(➡️))x+=dx
		if(btn(⬅️))x-=dx
		if(btn(⬇️))y+=dy
		if(btn(⬆️))y-=dy
		x=mid(stage_x0,x,stage_x1-8)
		y=mid(stage_y0,y,stage_y1-8)			
	end,
	
	update=function(_ENV)
    if(state!=ghost) then 
      oldx,oldy=x,y
      if(playable) input(_ENV)
      if(stage.collide(_ENV)) on_wall(_ENV)
      state = (oldx~=x or oldy~=y) and moving or idle
    end
    if(anim[state])anim[state]:update(_ENV)
	end,

	draw=function(_ENV) if(anim[state])anim[state]:draw(_ENV)end,
})