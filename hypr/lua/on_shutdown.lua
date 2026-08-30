 -- os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
 -- uses a blocking exec function and sleeps a bit to give things time to close
 -- you might also want to kill troublesome/crashing non-systemd background services here:
 -- os.execute("pkill wallpaperthing; systemctl --user stop hyprland-session.target && sleep 0.1")

