My personalized script to install and set up all neccesarry software after having installed Arch Linux.

# Notes 
## ibus and QT applications
Mandatory: set the environment variables accordingly to the [ibus article](https://wiki.archlinux.org/title/IBus) on Arch Wiki.

Another cricital thing is to **always** start `ibus-daemon` with `--xim`. While this is not a problem in standalone WMs and DEs like KDE, etc., but in DEs with integrated ibus (like GNOME), this is a problem since we don't really know what parameters does GNOME pass to `ibus-daemon`.  
Solution: create `$XDG_CONFIG_HOME/autostart/ibus.desktop` with the following content (also work for any other DE/WM):

```ini
[Desktop Entry]
Type=Application
Name=ibus-daemon
Exec=ibus-daemon -drx
NoDisplay=true
```

