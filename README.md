# unipkg
universal package managment scripts, cross-distro. 

requirements:

- fzf (TUI only, CLI will work without)
- bash
- sudo
- any package manager

note that unipkg does not come with any built-in package management, it's a wrapper. You will need to install and set up your package manager first.

menus:

v (per-manager) install menu (list: available packages, display: info, action: install)

v (universal) info menu (list: various commands,  action: run that action)
indexes, versions, check (submenu), generate

v (universal) listing menu (list: unipkg.conf package managers, display: output of commands, action: return, keybind: cycle previews)
list, list-installed, list-upgradable, 

v (universal) upgrade menu (list: package managers, display: list-upgradable, action: upgrade, keybind: update && refresh preview)

v (per-manager) uninstall menu (list: installed packages, display: info, action: uninstall)



v top level: select menu (maintenance/info, lists, install, uninstall, update)


command structure:

unipkg <action> <package manager> <args>


actions:
- check (unipkg check <index>)
- generate (unipkg generate)
- indexes (unipkg indexes)
- versions (unipkg versions)
- info (unipkg info <index> <package>)
- install (unipkg install <index> <packages>)
- uninstall (unipkg uninstall <index> <packages>)
- update (unipkg update <index>)
- upgrade (unipkg upgrade <index>)
- list-available (unipkg list-available <index>)
- list-installed (unipkg list-installed <index>)
- list-upgradable (unipkg list-upgradable <index>)
- help (unipkg help)
- launch-tui (unipkg launch-tui)
