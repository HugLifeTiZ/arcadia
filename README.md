# Arcadia
### ver. 1.0

## What is this spectacular bash monstrosity?
This is a set of tools and bash functions to help you organize and launch your games. "But wait!" you cry out, "Lutris already does that!" Yes, yes it does. In fact, some might think that it does so *too much*. Lutris is a mostly automated game management solution. Arcadia is for those who want to be more involved and more hands-on with the configuration and management of their games. To that end, it offers more features when you configure them, and will make a lot of convenient inferences to make configuration easier on you. In addition, Lutris doesn't show its games in any sort of categorical hierarchy at all; separating games by their "platform" is a key part of Arcadia's configuration paradigm.

## Why is this thing written in bash of all languages?
Several reasons, none of which are especially good on their own. First, I've always had a launcher like this, that I've just been evolving incrementally, and the latest evolution is good enough to let people see it. Second, Arcadia is all about running things, and that's what shells do best. Third, I don't know a way of starting another X server in any other language while retaining internal state.

## Another X server? What kind of stuff does this program do?
You want a feature list? You got a feature list.
* Start all games in an X server with exclusions, or vice versa.
* Designate games to be run on the dedicated GPU.
* Integrate with [Padfiler](https://github.com/TiZ-EX1/padfiler) (which itself integrates with Antimicro) to automatically start gamepad profiles with games.
* Given a list of displays in preference order, can clone the primary across all of them, or shut off all but the most preferred available display.
* Automatically change resolutions, or do aspect-relative screen scaling with xrandr.
* Define functions that run before and after starting all games, starting the second X server, and starting a specific game.
* Run devilspie2 or kpie with specified configurations.
* Automatically detect which emulators to use for various platforms.
* Got fceux installed but prefer mednafen? Override runner detection.
* Emulator runners are configured to put saves in a special directory for easy synchronization with other devices.
* Use standalone meta files for system-installed games or Steam games.
* Start Steam just to run a specified game, and then exit Steam after.
* Same thing as above but with Wine Steam.

## What kind of modules are included?
* **runner**: You give it the path to a "game" and it runs it with all the configuration you've specified.
* **xinit**: Run any command or exported bash function on another X server.
* **gen-desktop**: Generate .desktop files with a nice hierarchy within your Games menu for all of your games.

## I'm sold. How do I install it?
You don't actually *have* to install it. You can symlink the main script, `arcadia`, into your user bin directory, and it will detect its own location. If you wish to install it, run `./project.sh install`. If you do this as a regular user, it will install in `$XDG_CONFIG_HOME/arcadia` and symlink its main script into `$HOME/bin`. If you do this as root, it will install system-wide in whatever location you tell it to, or /usr/local/share/arcadia if you don't tell it anything.

Even if you choose not to install it, if you want to generate desktop files, you'll do well to do `./project.sh install-menu` and `./project.sh install-icons`. If you want your gamepads to work on the second X server, do `sudo ./project.sh install-udev`.

## What programs do I need to install for it to work right?
Firstly, it's a set of bash scripts. If you don't have **bash**, you're gonna have a bad time. It also makes regular use of **python**, **sed**, **wget**, **xdotool**, **xrandr**, and **xset**. If you want to run second X, make sure you have a nice lightweight WM on deck, like **fluxbox**, as well as **stalonetray** to keep tray-dependent apps from breaking. To make use of **devilpie2** or **kpie**, you'll need them installed. To use gamepad profiles, install [**padfiler**](https://github.com/TiZ-EX1/padfiler), which itself requires **antimicro**.

## Okay, so how do I actually use this thing?
It just so turns out that the github repository that you may or may not be reading this readme from at the moment has a wiki to help you! I would tell you to check it out, but it has no information on it just yet. Sorry! :(

## Where'd you get those slick included icons?
I don't remember. I definitely didn't make them. However, I do remember they are licensed such that they can be included in this repo. If I find the info on that, I'll update this.
