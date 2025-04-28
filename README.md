<h1><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Keyboard.png" alt="Keyboard" width="25" height="25" /> HomeRowMods</h1>

What are Home Row Mods? Well, if you're here you probably already know. If you don't go check [Dreams of Code's video about it](https://youtu.be/sLWQ4Gx88h4?si=E-2gArN-tUJUex-u).

This repo contains a simple script to setup [Kanata](https://github.com/jtroo/kanata) following a design pretty much identical to the one in the video.

> [!WARNING]
> This script has only been tested on Arch Linux, it won't work on Windows and it is not assured it'll work on other distros.

<h2><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Package.png" alt="Package" width="25" height="25" /> Installation</h2>

Curl the script and run it:

```bash
curl -fsSLO https://raw.githubusercontent.com/Xitonight/HomeRowMods/main/install.sh | bash -s -- <custom_install_directory>
```

Once it did its thing just reboot and you should already see Kanata working! Bravo!

> [!NOTE]
> You can omit `-s -- <custom_install_directory>`, it will default to `~/.homerowmods`

<h2><img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Symbols/Cross%20Mark.png" alt="Cross Mark" width="25" height="25" /> Uninstalling</h2>

Run these commands:

```bash
rm -rf ~/.config/kanata/kanata.kbd ~/.config/systemd/user/kanata.service ~/.config/systemd/user/default.target.wants/kanata.service
```
