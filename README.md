# My dotfiles

## Setup

- Window manager: `i3`
- Status bar: `polybar`
- Launcher: `rofi`
- Compositor: `picom` 
- auto-lockscreen: `i3lock`, `xautolock`
- Font: `CaskaydiaCove NFM`, `Cascadia Code`
- Theme: `TokyoNight`
- Brightness controller: `brightnessctl`
- Audio: `pulseaudio`, `pavucontrol` 
- System monitor: `htop`

## Installing

```shell
  cd ~
  git clone https://github.com/nhat-tien/dotfiles.git
  cd dotfiles
  chmod +x install.sh
  ./install.sh
```

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

1. Đảm bảo có dòng sau trong `i3/config`
```txt
  exec --no-startup-id ibus-daemon
```

2. Thử tắt ibus rồi chạy ibus-daemon
```shell
  ibus exit
  ibus-daemon
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
