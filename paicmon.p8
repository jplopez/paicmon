pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

--globals
_globals=_ENV
_noop=function(_ENV)end

--colors
pal({-4,2,3,4,5,6,7,8,9,10,11,12,-13,-5,15,0},1) --color zero, black, is specified at the end.
black,mid_blue,purple,dark_green=0,1,2,3
brown,dark_gray,light_gray,white=4,5,6,7
red,orange,yellow,light_green=8,9,10,11
light_blue,dark_teal,mid_green,peach=12,13,14,15

--states
idle=0
moving=1
respawn=2
ghost=3
--stage size
max_col=13
max_row=15
--sprite flags
fspr_wall=0  --0x1
fspr_slime=1 --0x2 
fspr_item=2  --0x4   
fspr_pwrup=3 --0x8
--tolerance
tol=1

player={ 
  paimon=nil,
  score=0,
  lives=3,
}

#include src/core/utils.lua
#include src/core/print_utils.lua
#include src/core/oop.lua
#include src/core/log.lua
#include src/core/animator.lua
#include src/core/particle.lua

#include src/world/stage.lua
#include src/world/ui.lua

#include src/entities/animated.lua
#include src/entities/paimon.lua
#include src/entities/slime.lua
#include src/entities/elemental.lua

function _init()
  --playable area aboundaries
  log_prefix="INI"
  log("starting",true)
  stage_x0=64-(max_col*8/2)
  stage_y0=0
  stage_x1=64+(max_col*8/2)
  stage_y1=8*max_row
  init_objects()
end

function _update60() 
  log_prefix="UPD"
  gui.update()
  stage.update()
  object:each("update")
  foreach(slimes, detect_collide_paimon)
end

function _draw()
  log_prefix="DRW"
  cls()
  gui.draw()
  stage.draw()
  object:each("draw")
end

---------------------
-- init functions
---------------------
function init_objects() 
  elems={}
  for c=1,max_col-1 do
    for r=1,max_row-1 do
      local _x,_y=stage_x0+c*8,stage_y0+r*8
      if(not stage.is_wall(_x,_y)) then
        add(elems,new_elemental(_x,_y))
      end
    end
  end

  slimes = {
    new_slime("anemo",36,40),
    -- new_slime("geo",44,40),
    -- new_slime("electro",52,40),
    -- new_slime("dendro",60,40),
    -- new_slime("hydro",68,40),
    -- new_slime("pyro",76,40),
    -- new_slime("cryo",82,40),
  }

  player.paimon=paimon()
end

-------------------
-- update function
-------------------
function detect_collide_paimon(obj) 
  player.paimon.tolerance=-3
  player.paimon:detect(obj,paimon.on_slime)
  player.paimon.tolerance=0
end

-------------------
-- draw functions
-------------------
function draw_ui()
  printo(lpad(player.score,6),stage_x0+1,stage_y1+2,1,7)
  local str=srep("♥",player['lives'])
  printo(str,64-(#str*4),stage_y1+2,8,7)
  print("🐱🐱🐱🐱",stage_x1-30,stage_y1+2,7)
end

__gfx__
0000000000000000000000000000000000008a00000000000000000000000000000000000000a00000000a000000c30000000000000000000000000000000000
000000000000000000000000000000000008900000008a0000000000000000000000a0000009800000089000000ce0000000c300000000000000000000003000
000770000007700000077000000aa000008888000008900000089a0000009a0000098000008888000088880000cccc00000ce000000ce3000000e300000ec000
007777000077a700007aa70000aaaa00087878800088880000888800008880000088880008787800087878000c7c7cc000cccc0000cccc0000ccc00000cccc00
0077a700007aa700007a970000aa9a0088787888087878800878788008787880087878000878788088787880cc7c7ccc0c7c7cc00c7c7cc00c7c7cc00c7c7c00
000770000007700000077000000aa00088888898887878888878788808787880087878800888889088888898cccccceccc7c7ccccc7c7ccc0c7c7cc00c7c7cc0
0000000000000000000000000000000088888998888888988888888888888888088888908888898888888988ccccceeccccccceccccccccccccccccc0ccccce0
00000000000000000000000000000000088888800888898008888990888889988888898888888888088888800cccccc00ccccec00ccccee0ccccceeccccccecc
00003000000003000000760000000000000000000000000000000000000060000000060000001e00000000000000000000000000000000000000e00000000e00
000ec000000ce000000710000000760000000000000000000000600000017000000710000001c00000001e0000000000000000000000e000000c10000001c000
00cccc0000cccc0000777700000710000007160000001600000170000077770000777700001111000001c0000001ce000000ce00000c10000011110000111100
0c7c7c000c7c7c0007c7c7700077770000777700007770000077770007c7c70007c7c70001717110001111000011110000111000001111000171710001717100
0c7c7cc0cc7c7cc077c7c77707c7c77007c7c77007c7c77007c7c70007c7c77077c7c77011717111017171100171711001717110017171000171711011717110
0ccccce0ccccccec7777771777c7c77777c7c77707c7c77007c7c7700777771077777717111111c111717111117171110171711001717110011111c0111111c1
cccccecccccccecc7777711777777717777777777777777707777710777771777777717711111cc1111111c11111111111111111011111c011111c1111111c11
cccccccc0cccccc0077777700777717007777110777771177777717777777777077777700111111001111c1001111cc011111cc111111c111111111101111110
00009a00000000000000000000000000000000000000a00000000a000000eb00000000000000000000000000000000000000b00000000b0000002f0000000000
0009400000009a0000000000000000000000a0000004900000094000000e30000000eb0000000000000000000000b0000003e000000e30000002900000002f00
009999000009400000094a0000004a0000049000009999000099990000eeee00000e3000000e3b0000003b000003e00000eeee0000eeee000022220000029000
097979900099990000999900009990000099990009797900097979000e7e7ee000eeee0000eeee0000eee00000eeee000e7e7e000e7e7e0002a2a22000222200
99797999097979900979799009797990097979000979799099797990ee7e7eee0e7e7ee00e7e7ee00e7e7ee00e7e7e000e7e7ee0ee7e7ee022a2a22202a2a220
99999949997979999979799909797990097979900999994099999949eeeeee3eee7e7eeeee7e7eee0e7e7ee00e7e7ee00eeeee30eeeeee3e2222229222a2a222
99999449999999499999999999999999099999409999949999999499eeeee33eeeeeee3eeeeeeeeeeeeeeeee0eeeee30eeeee3eeeeeee3ee2222299222222292
099999900999949009999440999994499999949999999999099999900eeeeee00eeee3e00eeee330eeeee33eeeeee3eeeeeeeeee0eeeeee00222222002222920
0000000000000000000000000000f00000000f000000770000000000000000000000000000000000000070000000070000000000000000000000000000000000
00000000000000000000f00000092000000290000007700000007700000000000000000000007000000770000007700000000000000000000000000000000000
00029f0000009f000009200000222200002222000070070000077000000777000000770000077000007007000070070000000000000000000000000000000000
00222200002220000022220002a2a20002a2a20007a0a0700070070000700700007770000070070007a0a70007a0a70000000000000000000000000000000000
02a2a22002a2a22002a2a20002a2a22022a2a22070a0a00707a0a07007a0a07007a0a77007a0a70007a0a07070a0a07000000000000000000000000000000000
22a2a22202a2a22002a2a22002222290222222927000000770a0a00770a0a00707a0a07007a0a070070000707000000700000000000000000000000000000000
22222222222222220222229022222922222229227000000770000007700000077000000707000070700000077000000700000000000000000000000000000000
02222990222229922222292222222222022222200777777007777770077777707777777777777777777777770777777000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000900000009000000090000000900000009000000000000
0d6666660d666666666666660d6666d0000000000000000000000000000000000000000000000000049994000499946004999460049994600499940000000000
06555555065555555555555506555560000770000007700000077000000770000007a000000aa000074947606749477667494776674947760749476000000000
06555555065555555555555506555560007777000077a700007aa700007aa700007aaa0000aaaa006777777677cfc77777cfc77777cfc7776777777600000000
065555550655555555555555065555600077a700007aa700007aa700007aaa0000aaaa0000aaaa0077cfc7777fcfcf777fcfcf777fcfcf7777cfc77700000000
065555550655555555555555065555600007700000077000000770000007a000000aa000000aa0007fcfcf770fffff700fffff700fffff707fcfcf7700000000
0d666666065555d6666666660d6666d00000000000000000000000000000000000000000000000000fffff700079710000797110007971110fffff7000000000
00000000065555600000000000000000000000000000000000000000000000000000000000000000007971110000001100000001000000000079711100000000
00000000065555600655556000000000000000000000000000900000009000000090000000900000009000000090000000900000000000000000000000000000
666666d0065555d60655556000000000000000000000000049994000499946004999460049994600499940004999400049994000000000000000000000000000
55555560065555550655556000000000000000000000000074947600749477607494776674947767749476007494760074947600000000000000000000000000
5555556006555555065555600000000000077000000aa000777777667cfc77767cfc77777cfc7770777777667777776677777760000000000000000000000000
5555556006555555065555600000000000077000000aa0007cfc77777cfcf7777cfcf7707cfcf7007cfc77707cfc77777cfc7776000000000000000000000000
5555556006555555065555600000000000000000000000007cfcf7700ffff7000ffff7000ffff7017cfcf7007cfcf7707cfcf777000000000000000000000000
666666d00d666666065555600000000000000000000000000ffff7000971110009711111097111100ffff7010ffff7010ffff700000000000000000000000000
00000000000000000655556000000000000000000000000009711111000000110000000000000000097111100971111009711111000000000000000000000000
06555560065555600655556000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
065555606d5555606d5555d666666666004999400000900000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560555555605555555555555555067494700049994000009000000090000000d0000000d0000000d0000000000000000000000000000000000000000000
0655556055555560555555555555555567777776067494700049994000499940005ddd50005ddd50005ddd500000d00000000000000000000000000000000000
06555560555555605555555555555555777cfc776777777606749470067494700675d5700665d5600665d560005ddd500000d000000000000000000000000000
0655556055555560555555555555555577fffff7777cfc7767777776677777766777777666666666666666660665d560005ddd50000000000000000000000000
0d6666d0666666d0666666666d5555d607fffff077fffff7777cfc77777fff77777fff77666fff6666600066666666660665d560000000000000000000000000
000000000000000000000000065555601117970007fffff077fffff777fcfcf777f1f1f766f1f1f6660101066660006666666666000000000000000000000000
00000000000000000655556006555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d6666d0666666d06d555560065555d6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560555555605555556006555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560555555605555556006555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560555555605555556006555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560555555605555556006555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
065555606d5555606d555560065555d6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06555560065555600655556006555560000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
04040404020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200000000010101010c0c0c0c0c0c000000000000010101010404000000000000000000000101010100000000000000000000000001010101000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4142424242426342424242427100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254545454545254545454545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5244414250546054404271445200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254605454545454545460545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254545440424242505454545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5142505400000000005440426100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5354545441500040715454540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4142505452000000525440427100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254545451424242615454545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254705454546454545470545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254515054406350544061545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5244545454545254545454445200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254404250546054404250545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5254545454545454545454545200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5142424242424242424242426100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
