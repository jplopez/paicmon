elemental=animated:extend({
  state=idle, playable=false,
  dx=0,dy=0,
  power=false,
  on_wall=_noop,
  on_collision=function(_ENV) destroy(_ENV) end,
})
function new_elemental(_x,_y,power)
  local idle_anim = (power) and animator({start=68, frames=6, speed=5,}) or animator({start=84, frames=2, speed=rnd(11)/100})
  log(idle_anim)
  return elemental({x=_x, y=_y, power=power, anim={[idle]=idle_anim}, })
end