
# Alias
Set-Alias -Name v -Value nvim
Set-Alias -Name c -Value cls

# Function
function dot {
    nvim D:\dotfiles\
}

function .. {
  cd ..
}

function ...{
  cd ..
  cd ..
}

function nvconfig {
    nvim D:\dotfiles\nvim\
}

function dev {
    D:\dotfiles\scripts\cdf.ps1 D:\02_DEV\
}
