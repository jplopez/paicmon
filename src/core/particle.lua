particle=object:extend({
  x=rnd(2)-1, y=rnd(2)-1,
  dx=rnd(2)-1, dy=rnd(2)-1,
  rad=rnd(2)+1, act=0, life=30, clr=white,
  update=function(_ENV) 
    y+=dy
    x+=dx
    act-=1
    if(act<0)destroy(_ENV)
  end,
  draw=function(_ENV)circfill(x,y,rad,clr)end
})

family=object:extend({
  gen_size=rnd(2)+1,
  grow=function(_ENV,part_fn,...)
    part_fn=part_fn or particle
    for i=1,gen_size do add(pool,part_fn(...))end 
  end,
  update=function(_ENV)for p in all(pool)do p:update()end end,
  draw=function(_ENV)for p in all(pool)do p:draw()end end,
})