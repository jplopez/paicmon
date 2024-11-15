elemental=object:extend({
  tolerance=-5,
  power=false,
  update=function(_ENV)
    detect(_ENV,player.paimon,
        function(obj) 
          obj:destroy()
          player:add_score(power)
        end)
   end,
  draw=function(_ENV) spr((power and 68 or 84),x,y,1,1) end

})