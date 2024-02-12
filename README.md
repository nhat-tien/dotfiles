<h1 align="center">My dotfiles 📁</h1>

## Setup

- Window manager: [i3](https://github.com/i3/i3)
- Status bar: [polybar](https://github.com/polybar/polybar)
- Application launcher: [rofi](https://github.com/polybar/polybar)
- Compositor: [picom](https://github.com/yshui/picom)
- auto-lockscreen: `i3lock`, `xautolock`
- Font: [CaskaydiaCove NF](https://www.nerdfonts.com/font-downloads)
- Theme: `TokyoNight`
- Brightness controller: [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- Audio: `pulseaudio`, `pavucontrol` 
- System monitor: `htop`
- Text editor: [Helix](https://github.com/helix-editor/helix)
- Terminal emulator: [Wezterm](https://github.com/wez/wezterm)
- Terminal workspace: [Zellij](https://github.com/zellij-org/zellij)
- TUI file manager: [nnn](https://github.com/jarun/nnn) 

## Installing

```shell
  cd ~
  git clone https://github.com/nhat-tien/dotfiles.git
  cd dotfiles
  chmod +x install.sh
  ./install.sh
```

## Screenshoot

![screenshoot](/rice.png)

## Fix

### Không sử dụng được ibus-bamboo trên kitty terminal

[https://github.com/BambooEngine/ibus-bamboo/issues/196](https://github.com/BambooEngine/ibus-bamboo/issues/196)

```shell
  sudo sh -c "echo  '
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
# Dành cho những phần mềm dựa trên qt4
export QT4_IM_MODULE=ibus
# Dành cho những phần mềm dùng thư viện đồ họa clutter/OpenGL
export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus
' >> /etc/profile"
```
Chọn chế độ gõ là `6.XTestFakeKeyEvent`

### Ibus-daemon không tự động khởi động

```txt
  exec_always --no-startup-id $HOME/dotfiles/ibus/launch.sh
```

### Từ chối không có quyền sudo khi sử dụng brightnessctl
1. Run: 
```shell
  sudo usermod -aG video ${USER}
```

2. Check:
```shell
  cat /etc/group | grep video
```
expect: `video:x:44:<username>`, example `video:x:44:nhattien`

3. Reboot 
