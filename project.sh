#!/bin/bash
# Project file for Arcadia.

exit_usage () {
    echo "Usage: ./project.sh operation [path]"
    echo "Operations:"
    echo "  install: Install Arcadia in path. If root, path defaults to"
    echo "   /usr/local/share/arcadia. If user, path defaults to"
    echo "   \$XDG_DATA_HOME/arcadia. Does below installs too."
    echo "  install-icons: Install platform icons into hicolor theme."
    echo "  install-menu: Install Arcadia's desktop menu hierarchy."
    echo "  install-udev: (ROOT ONLY) Install udev rule for joysticks."
    echo "   This ensures joysticks can always be read by users."
    echo "  uninstall: Remove Arcadia from path. Does below uninstalls too."
    echo "  uninstall-icons: Remove platform icons."
    echo "  uninstall-menu: Remove Arcadia's desktop menu hierarchy."
    echo "  uninstall-udev: (ROOT ONLY) Remove udev joystick rule."
    exit 1
}

[[ $# -lt 1 ]] && exit_usage
[[ "$(whoami)" = "root" ]] && root=1
op="$1"; path="$2"

if [[ ! "$path" ]]; then
    if [[ "$root" ]]; then path="/usr/local/share/arcadia"
    else
        [[ -d "$XDG_DATA_HOME" ]] && path="$XDG_DATA_HOME/arcadia" \
         || path="$HOME/.local/share/arcadia"
    fi
fi
if [[ "$path" = "${HOME}"* ]]; then bin_dir="$HOME/bin"
else bin_dir="$(readlink -f "$path/../../bin")"; fi
if [[ "$root" ]]; then menu_dir="/etc/xdg/menus/applications-merged"
else
    [[ -d "$XDG_CONFIG_HOME" ]] && \
     menu_dir="$XDG_CONFIG_HOME/menus/applications-merged" || \
     menu_dir="$HOME/.config/menus/applications-merged"
fi

cd "$(dirname "$(readlink -f "$0")")"
case "$1" in
install)
    export SIMPLE_BACKUP_SUFFIX="off"
    install -d "$path" "$path/data" "$path/icons" \
     "$path/funcs" "$path/modules" "$path/runners" "$bin_dir"
    install -m0755 arcadia "$path/arcadia"
    install -m0755 modules/* "$path/modules"
    install -m0644 data/* "$path/data"
    install -m0644 icons/* "$path/icons"
    install -m0644 funcs/* "$path/funcs"
    install -m0644 runners/* "$path/runners"
    ln -s "$path/arcadia" "$bin_dir"
    "$0" install-icons
    "$0" install-menu
    [[ "$root" ]] && "$0" install-udev
    ;;
install-icons)
    for i in icons/*; do
        i=$(basename $i)
        xdg-icon-resource install --novendor --size 48 icons/$i arcadia-${i%.*}
    done
    ;;
install-menu)
    install -d "$menu_dir"
    install -m0644 data/arcadia-platforms.menu "$menu_dir"
    ;;
install-udev)
    [[ "$(whoami)" = "root" ]] || { echo "Only root can do that."; exit 1; }
    install -m0644 data/*.rules /etc/udev/rules.d
    ;;
uninstall)
    rm -r "$path/share/arcadia" "$bin_dir/arcadia"
    "$0" uninstall-icons
    "$0" uninstall-menu
    [[ "$root" ]] && "$0" uninstall-udev
    ;;
uninstall-icons)
    for i in icons/*; do
        i=$(basename $i)
        xdg-icon-resource uninstall --size 48 arcadia-${i%.*}
    done
    ;;
uninstall-menu)
    rm "$menu_dir/arcadia-platforms.menu"
    ;;
uninstall-udev)
    [[ "$(whoami)" = "root" ]] || { echo "Only root can do that."; exit 1; }
    rm /etc/udev/rules.d/99-arcadia-joystick.rules
    ;;
esac
