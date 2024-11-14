-- A single particle
particle=object:extend({
  x=rnd(2)-1, y=rnd(2)-1,
  dx=rnd(2)-1, dy=rnd(2)-1,
  rad=rnd(2)+1, act=0, life=30, clr=white,
  update=function(_ENV)
    y+=dy
    x+=dx
    act+=1
    if(act>life)destroy(_ENV)
  end,
  draw=function(_ENV)circfill(x,y,rad,clr)end
})

-- A group of particles
party=object:extend({
  seed=2,
  grow=function(_ENV,generator,_seed)
    _seed=_seed or seed
    part_fn=part_fn or particle
    for i=1,(rnd(_seed)+1) do add(pool,generator())end 
  end,
  update=function(_ENV)foreach(pool,function(obj)obj:update()end)end,
  draw=function(_ENV)foreach(pool,function(obj)obj:draw()end)end,
})

fairy_dust=particle:extend({
  dx=0,dy=0,rad=0,life=90,fr=3,

  update=function(_ENV)
    local fairy=player.paimon
    if(act%fr==0) then
      x=(fairy.x+2+rnd(3))+(fairy.oldx-fairy.x)*20
      y=(fairy.y+4+rnd(3))+(fairy.oldy-fairy.y)*20
      clr=rnd({white,light_gray,})
    end
    particle.update(_ENV)
  end,

  draw=function(_ENV)particle.draw(_ENV) end,
})