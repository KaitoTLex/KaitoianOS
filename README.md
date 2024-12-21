# KaitoianOS
> Fully customizable container-based operating system based on ```NixOS``` running SwayDE. 
## What even is this Config?
So I believe I have no life, so I migrated from a super unstable and limited OS (DOS) to FreeBSD, however FreeBSD had limited packages being maintained on **Fresh Ports** so I figured might as well become a Linux user. After distro hopping for 3 months I was introduced to NixOS by [Youwen](https://youwen.dev) claiming that it would solve my problems of having to configure everything on seperate directories, common on most distros such as Arch or Debian. 
## Why Sway and Wayland
Wayland provides a more stable graphical enviornment due to the simplicity of the code and it's security; moreover, it peforms significantly better on intergrated and discrete graphics cards for most of my systems. Why Sway and not Hyprland? Sway is a simple port of the popular x11 DE known as i3. Hyprland has too much eyecandy for a DE, too much bells and whistles such as dynamic colors and rounded edges. Also removing eyecandy on my config makes my input smoother and crispier. 
## What Basic Utilites do you have on here? 
- Firefox Developer Edition
- Spotify (Spicetify)
- Stylix
- Media Keys Support and extra bindings
- Sophisticated Connectivity (Blueman, NMTUI, Tetris)
## Hosts
### Shiroko - *Named after a Character from [*Blue Archive*](https://schaledb.com/student/shiroko)
MSI Summit E13 Flip Evo
> Intel i5 1155G7 @ 4.5GhZ

> 16 GB LPDDR5

> 256 GB Samsung Evo 970 SSD

### Kuroko - *Named after a Character from [*Blue Archive*](https://bluearchive.fandom.com/wiki/Shiroko_Terror)
ROG (ASUS) Flow X13 2022
> AMD R9 5900HS @ 5.1GhZ

> Nvidia RTX3050Ti Mobile + 4GB GDDR6

> 16 GB LPDDR4

> 1TB Crucial (Allocated 128 for NixOS)

## How to Install or Clone

1. First off, have NixOS installed as Minimal(No GUI) on the Graphical ISO Image that could be found [here](https://nixos.org/download/#nix-install-linux)
2. Clone this repository at your `home` directory using 

```sh
nix-shell -p git
```
then 
```sh
git clone git@github.com:KaitoTLex/KaitoianOS.git #or https://github.com/KaitoTLex/KaitoianOS.git if you're weird
```

3. `cd` into the cloned directory

4. Copy your `hardware-configuration.nix` from your Installed os(/etc/nixos) with the following command

```sh
cp /etc/nixos/hardware-configuration.nix ~/KaitoianOS/hosts/shiroko/hardware-configuration.nix #or kuroko if you have an Nvidia Graphics Card
```

5. Recompile your os by 
```sh
sudo nixos-rebuild switch --flake .\#shiroko #or kuroko
```
6. Enjoy!
