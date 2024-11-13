paimon=animated:extend({
	x=60, y=72, state=moving,
  anim={
    [idle]=animator({ start=74, frames=4, speed=3, }),
    [moving]=animator({ start=86, frames=7, speed=6, }),
    [ghost]=animator({ start=100, frames=9, speed=6, loop=false, }),
  },

  on_wall=function(_ENV) x,y=oldx,oldy end,

  on_slime=function(_ENV,_slime)
    log("on slime")log(_slime)

    state=ghost
    playable=false
  end,
})