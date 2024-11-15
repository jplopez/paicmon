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
    printo(gui.score,stage_x0+1,stage_y1+2,dark_teal,white)
    printo(gui.lives,64-gui.lives_len,stage_y1+2,red,white)
    print("🐱🐱🐱🐱",stage_x1-30,stage_y1+2,white)    
  end,
}