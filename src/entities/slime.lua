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

  on_wall=function(_ENV)
    x,y=oldx,oldy
    if(one_of(direction, left, right))then direction=rnd({up,down})
    elseif(one_of(direction,up,down))then direction=rnd({left,right})end
  end,
})

--map for the initial sprite of each slime
slimes_anim_start={anemo=11, geo=32, electro=46, dendro=39, hydro=25, pyro=4, cryo=18,}

-- @method new_slime(element [_x],[_y]) 
-- creates a slime object of the 'element'
-- @param element the type of slime: anemo, geo, electro, dendro, hydro, pyro or crio
-- @param _x (optional) initial X pos
-- @param _y (optional) initial y pos
function new_slime(element,_x,_y)
  local spr_start=slimes_anim_start[element]
  return slime({
    x=(_x and _x or 60),y=(_y and _y or 56),
    anim = {
      [idle] = animator({ start=spr_start, frames=4, speed=4 }),
      [moving] = animator({ start=spr_start, frames=7, speed=6 }),
      [ghost] = animator({ start=53, frames=9, speed=6 })
    },
  })
end