gui={
  lives="♥",
  lives_len=1,
  score="0",

  update=function()
    gui.lives=srep("♥",player.lives)
    gui.lives_len=#gui.lives*4
    gui.score=lpad(player.score,6)
  end,

  draw=function()
    prto(gui.score,stage_x0+1,stage_y1+2,dark_teal,white,true)
    prto(gui.lives,'c',stage_y1+2,red,white,true)
    prto("🐱🐱🐱🐱",'r',stage_y1+2,yellow,orange,true)
  end,
}