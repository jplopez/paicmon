animated=object:extend({
	x=64, y=64,
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
    local oldx,oldy=x,y
    if(playable) input(_ENV)
    detect(_ENV,stage,on_collision,oldx,oldy)
    upd_anim(_ENV,oldx,oldy)
	end,
	
	draw=function(_ENV) if(anim[state])anim[state]:draw(x,y)end,

  on_collision=function(_ENV,other,oldx,oldy)x,y=oldx,oldy end,

  upd_anim=function(_ENV,oldx,oldy)
    if(oldx~=x or oldy~=y)then
      state=moving
      if(oldx<x)flx=true 
      if(oldx>x)flx=false
    else state=idle end

    if(anim[state])then 
      anim[state].flipx=flx
      anim[state]:update()
    end
  end,
})