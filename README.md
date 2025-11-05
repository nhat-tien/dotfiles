<h1 align="center">My dotfiles 📁</h1> 

## Setup

- Window manager: [i3](https://github.com/i3/i3)
- Status bar: [polybar](https://github.com/polybar/polybar)
- Application launcher: [rofi](https://github.com/polybar/polybar)
- Compositor: [picom](https://github.com/yshui/picom)
- Auto-lockscreen: `i3lock`, `xautolock`
- Font: [CaskaydiaCove NF](https://www.nerdfonts.com/font-donloads)
- Theme: `TokyoNight`
- Brightness controller: [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- Audio: `pulseaudio`, `pavucontrol` 
- System monitor: `htop`
- Code editor: [NeoVim](https://github.com/neovim/neovim)
<!-- - Terminal emulator: [Kitty terminal](https://github.com/kovidgoyal/kitty) -->
- Terminal emulator: [Wezterm](https://github.com/wezterm/wezterm)
- Shell: `zsh` 
- TUI file manager: [yazi](https://github.com/sxyazi/yazi)
- Prompt: [starship](https://github.com/starship/starship) 
- Terminal multiplexer: [Zellij](https://github.com/zellij-org/zellij)

## Installing

***Be careful**: This script will remove your existing configurations, please ensure you have a backup stored in somewhere outside of ~/.config/...*

```bash
  cd ~
  git clone https://github.com/nhat-tien/dotfiles.git
  cd dotfiles
  chmod +x setup && setup -f -a
```

## Screenshot
<img width="1366" height="768" alt="rice" src="https://github.com/user-attachments/assets/39b76fa5-76f9-4380-8b6a-9d124c7639af" />
<img width="1366" height="768" alt="screenshot-from-2025-06-16-21-04-13" src="https://github.com/user-attachments/assets/05f37653-a7eb-4804-9662-b7f494b633ad" />
<img width="1366" height="768" alt="screenshot-from-2025-06-16-21-10-28" src="https://github.com/user-attachments/assets/f3f3c290-3a87-460d-a7a1-33c6205cf69c" />

## Neovim
**Start-up Time**: ~100ms
<img width="1351" height="729" alt="screenshot-from-2025-07-03-14-25-58" src="https://github.com/user-attachments/assets/7c4b02b1-099e-48ea-8dab-f7b2c3ed789c" />

## Troubleshooting 

### Neovim Clipboard 

```bash
sudo apt install xclip
```

### Can't use ibus-bamboo in kitty terminal

[https://github.com/BambooEngine/ibus-bamboo/issues/196](https://github.com/BambooEngine/ibus-bamboo/issues/196)

```bash
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
Choose mode `6.XTestFakeKeyEvent`

### Ibus-daemon does not auto-load

```txt
  exec_always --no-startup-id $HOME/dotfiles/ibus/launch.sh
```

### Permission denied: no sudo privileges when using brightnessctl

1. Run: 
```bash
  sudo usermod -aG video ${USER}
```

2. Check:
```bash
  cat /etc/group | grep video
```
expect: `video:x:44:<username>`, example `video:x:44:nhattien`

3. Reboot 
