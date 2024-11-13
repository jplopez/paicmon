_log_fn = "log/log"
log_prefix=""
function log(txt,overwrite)
  if(type(txt)=="table")txt=serialize(txt,#log_prefix+1)
  printh(log_prefix.." "..txt,_log_fn,overwrite)
end