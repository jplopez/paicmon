_log_fn = "log/log"
log_prefix=""
function log(txt,overwrite)
  if(type(txt)=="table") then txt=serialize(txt,#log_prefix+1)
  else txt=tostr(txt) end
  printh(log_prefix.." "..txt,_log_fn,overwrite)
end