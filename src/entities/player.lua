player=object:extend({

  paimon,score,lives,

  init=function(_ENV)object.init(_ENV)reset(_ENV)end,
  
  reset=function(_ENV) 
    paimon=melon()
    score=0
    lives=3
  end,

  add_score=function(_ENV, power) score+=(power and 10 or 5) end,

  respawn=function(_ENV,life_lost) 
    lives=lives+(life_lost and -1 or 0)
    if(lives==0) log("gameover")
    paimon:respawn()
  end,

  update=function(_ENV)
    if(paimon.state!=ghost) then
      detect_slime_collision(_ENV)
      detect_food_pickup(_ENV)
    end
  end,

  detect_slime_collision=function(_ENV) 
    foreach(slimes, function(obj) 
        paimon.tolerance=-3
        paimon:detect(obj,paimon.on_slime)
        paimon.tolerance=0
    end)
    if(paimon.state==ghost) respawn(_ENV,true)
  end,

  detect_food_pickup=function(_ENV) 
    foreach(items, function(obj) 
        paimon.tolerance=3
        paimon:detect(obj,paimon.on_food)
        paimon.tolerance=0
    end)
  end,

})