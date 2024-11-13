-- Utils Functions
function is_empty(str)return(str==nil or str=="")end

function serialize(tbl,level)
  if(tbl==nil)then return "" end
  level=level or 0
  local result={}

  for k,v in pairs(tbl)do
    local field=""
    if type(v)=="string"then field=tostr(k)..' : "'..v..'"'
    elseif type(v)=="function"then field=tostr(k)..' : "function"'
    elseif type(v)=="table"then field=tostr(k)..' :\n'..serialize(v,level+1)
    else field=tostr(k)..' : '..tostr(v) end 
    add(result,spaces(2*(level+1))..field)
  end
  return spaces(2*level) .. '{\n'..table_concat(result,"\n")..'\n'..spaces(2*level)..'}'
end

function table_concat(array,separator)
  if(array==nil or #array==0)return ""
  separator=separator or ","
  local result=""
  for i=1,#array do
    result=result..array[i]
    if(i<#array)result=result..separator
  end
  return result
end

function get(table,value)
  if((table==nil)or(value==nil))return nil
  for i in all(table)do if(i==value)return i end
  return nil
end

function one_of(value, ...)
  if(select("#",...)==0)return false
  for arg in all({...})do if(value==arg)return true end
  return false
end

function muted()return(stat(48)-stat(49)==0)end

function srep(str,n)return(n==1)and str or str..srep(str,n-1)end

-- delays execution of callback by 2^n-1 frames.
-- can be a number between 1 and 9
function delay(n,callback,...)print("\^"..mid(1,n,9))callback(...)end