# Defined in - @ line 1
function cclip --wraps='xclip -selection clipboard' --description 'alias cclip=xclip -selection clipboard'
  xclip -selection clipboard $argv;
end
