paimon=animated:extend({
	x=60, y=72, state=moving,
  anim={
    [idle]  =animator({ start=74, frames=4, speed=3, }),
    [moving]=animator({ start=86, frames=7, speed=6, }),
    [ghost] =animator({ start=100, frames=9, speed=6, loop=false, }),
  },
  --particles
  dust={}, 
  max_dust=2,

  update=function(_ENV) 
    animated.update(_ENV)--super() call
    --fairy dust 
    foreach(dust,function(obj) if(obj.act>obj.life)del(dust,obj)obj:destroy() end)
    if(state==moving and #dust<max_dust)add(dust,fairy_dust({fr=5}))
  end,

  on_wall=function(_ENV) x,y=oldx,oldy end,
  on_slime=function(_ENV,_slime)
    state=ghost
    playable=false
  end,
})