animator=class:extend({
  start=0,
  cur=0,
  step=1,
  frames=1,
  fr=60, --frame rate DO NO EDIT
  speed=6,
  loop=true,
  playing=true,
  flipx=false,
  flipy=false,

  play_pause=function(_ENV)playing=not playing end,
  rewind=function(_ENV)cur=0 end,

  next_frame=function(_ENV) return start+cur end,

  update=function(_ENV) 
    if(playing) then
      step+=1
      if(step%flr(fr/speed)==0)cur+=1
      if(cur==frames) then 
        if(loop) then cur=0
        else playing=false end
      end
    end
  end,

  draw=function(_ENV,x,y) 
    if(playing) spr(next_frame(_ENV),x,y,1,1,flipx,flipy)
  end,
})

