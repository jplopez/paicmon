--printo
--
-- Print with outline
--
-- @param tt : text to print
-- @param px : starting x position
-- @param py : starting y position
-- @param cr : text color
-- @param oc : outline color
-- @param sharp : (optional) If true, produces sharper outline, meaning less square corners.  Default is false.
-- @param double: (optional) If true, outline width is 2px. If sharp is false, it only applies to bottom side. Default is false
--
function prto(tt,px,py,cr,oc,sharp,double) 
  tt=tostr(tt)
  -- string lenght
  tl=#tt
  for i=1,#tt do if(ord(tt,i)>128) tl+=1 end
 
  -- what is c? centered?
  if(type(px)=="string") then
    if(px=='c')px=64-tl*2
    if(px=='r')px=127-tl*4
  end

  color(oc)
  ?'\-f'..tt..'\^g\-h'..tt..'\^g\|f'..tt..'\^g\|h'..tt,px,py
  if(sharp) then 
    if(double) then 
      color(oc) 
      ?'\+ff'..tt..'\^g\+fh'..tt..'\^g\+hf'..tt..'\^g\+hh'..tt,px,py
      color(oc) 
      ?'\-e'..tt..'\^g\-i'..tt..'\^g\|e'..tt..'\^g\|i'..tt,px,py
    end
  else
    color(oc) ?'\+ff'..tt..'\^g\+fh'..tt..'\^g\+hf'..tt..'\^g\+hh'..tt,px,py
    if(double) color(oc) ?'\^g\+fi'..tt..'\^g\|i'..tt..'\^g\+hi'..tt,px,py  
  end
  ?tt,px,py,cr
end