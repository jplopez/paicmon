-- source: https://github.com/kevinthompson/object-oriented-pico-8/blob/main/heartseeker.p8#L293
-- author: https://github.com/kevinthompson 
class=setmetatable({
  extend=function(self,tbl)
    tbl=tbl or {}
    tbl.__index=tbl
    return setmetatable(
      tbl,{__index=self,__call=function(self,...)
        return self:new(...)end})
  end,
  new=function(self,tbl)tbl=setmetatable(tbl or {},self)tbl:init()return tbl end,
  init=_noop
},{__index=_ENV})

-- adds life cycle, update/draw, collision
object=class:extend({
	x=0,y=0,
	pool={},
	update=_noop,
	draw=_noop,
	tolerance=0,


	extend=function(_ENV,tbl)tbl=class.extend(_ENV,tbl)tbl.pool={}return tbl	end,
	each=function(_ENV,method,...)for e in all(pool)do if(e[method])e[method](e,...)end end,
	init=function(_ENV)add(object.pool,_ENV) if(pool!=object.pool)add(pool,_ENV)end,
	destroy=function(_ENV)del(object.pool,_ENV)if(pool!=object.pool)del(pool,_ENV)end,
	--collisions
	detect=function(_ENV,other,callback,...)if(collide(_ENV,other))callback(_ENV,other,...)end,
	
	collide=function(_ENV,other)
		if(other==stage) return stage.collide(_ENV,tolerance)
		return x < other.x+8+tolerance
        and x+8 > other.x-tolerance
        and y<other.y+8+tolerance
        and y+8 > other.y-tolerance
	end,
})

state_object=object:extend({
	_st={}, -- state container
	_cur=nil,
	sett=function(_ENV,k,on,off)
		if(k!=nil) then
			--local f=function()end
			_st[k]=_st[k]or{key=k,on=_noop,off=_noop}
			if(on)_st[k].on=on 
			if(off)_st[k].off=off 
			local o=_cur
			if(_st[o] and _st[o].off)_st[o]:off(o,k)
			_cur=k
			if(_st[k].on)_st[k]:on(o,k)
		end
		return _cur
	end,
	set=function(_ENV,k)return sett(_ENV,k)end,
	is=function(_ENV,k)return _cur==k end,
})