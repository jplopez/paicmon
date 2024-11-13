slime=animated:extend({ 
  x=60, y=56, dx=0.35, dy=0.35, state=moving, 
  left=10, right=20, up=30, down=40,
  direction=10,

  input=function(_ENV)
    if(direction==left)x=mid(stage_x0,x-dx,stage_x1-8)
    if(direction==right)x=mid(stage_x0,x+dx,stage_x1-8)
    if(direction==up)y=mid(stage_y0,y-dy,stage_y1-8)
    if(direction==down)y=mid(stage_y0,y+dy,stage_y1-8)
  end,

  on_collision=function(_ENV,other,oldx,oldy) 
    x,y=oldx,oldy
    if(direction==left or direction==right)then direction=rnd({up,down})
    elseif(direction==up or direction==down)then direction=rnd({left,right})end
  end,
})

slimes_anim_start={anemo=11, geo=32, electro=46, dendro=39, hydro=25, pyro=4, cryo=18,}

function new_slime(element,_x,_y)
  _x=_x or 60
  _y=_y or 56
  local spr_start=slimes_anim_start[element]
  return slime({
    x=_x,y=_y,
    anim = {
      [idle] = animator({ start=spr_start, frames=4, speed=4 }),
      [moving] = animator({ start=spr_start, frames=7, speed=6 }),
      [ghost] = animator({ start=53, frames=9, speed=6 })
    },
  })
end