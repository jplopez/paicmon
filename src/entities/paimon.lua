paimon=animated:extend({
	x=60, y=72, state=moving,
  anim={
    [idle]=animator({ start=74, frames=4, speed=3, }),
    [moving]=animator({ start=86, frames=7, speed=6, }),
    [ghost]=animator({ start=100, frames=9, speed=6, }),
  },

  update=function(_ENV) 
    animated.update(_ENV)
    for s in all(slimes) do 
      detect(_ENV,s,slime_collision,x,y)
    end
  end,

  slime_collision=function(_ENV,slime,oldx,oldy)
    state=ghost
    playable=false
    upd_anim(_ENV,oldx,oldy)
  end,
})