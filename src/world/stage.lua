stage={
  get=function(x,y) return mget(flr((x-stage_x0)/8),stage_y0+flr((y-stage_y0)/8))end,
  is_wall=function(x,y)return fget(stage.get(x,y),0)end,
  collide=function(obj,tolerance) 
    tolerance=tolerance or tol
    local x0,y0,x1,y1=obj.x+tolerance,obj.y+tolerance,obj.x+7-tolerance,obj.y+7-tolerance
    return stage.is_wall(x0,y0) or stage.is_wall(x0,y1) 
        or stage.is_wall(x1,y0) or stage.is_wall(x1,y1)
  end,
  update=_noop,
  draw=function()
    rectfill(stage_x0,stage_y0,stage_x1,stage_y1,black)
    map(0,0,stage_x0,stage_y0,max_col,max_row,0x1)
  end,
}