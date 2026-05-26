# unipkg
universal package managment scripts, cross-distro. 

dependencies:

- fzf (TUI only, CLI will work without)
- bash
- sudo
- any package manager

note that unipkg does not come with any built-in package management, it's a wrapper. You will need to install and set up your package manager first, then install bash and sudo, then install unipkg. 

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
