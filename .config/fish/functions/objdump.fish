# Defined in - @ line 1
function objdump --wraps='bingrep --color' --description 'alias objdump=bingrep --color'
  bingrep --color $argv;
end
