# unipkg

unipkg is a package manager agnostic wrapper that supports multiple package managers on one system. 

unipkg comes with both a CLI and TUI, and currently has official tested support for the following package managers:

- pacman
- yay
- apt
- snap
- flatpak
- xbps
- brew

due to the way unipkg is set up and configured, unipkg can easily be configured to support *any* commandline based package manager, including custom ones. 

As the project develops, I will test and validate more package managers, and they will be added to the list above as well as included in the base stable config.

## installation

to install unipkg, you will need to have the following dependencies:
- git
- sudo
- bash
- fzf
- core utils
- your package manager

you *can* run most scripts without fzf installed, but in that case you'll have to modify the install script to not check for fzf. 

step #1: git clone the repository and cd into the directory:

`git clone https://github.com/SDG-Den/unipkg`

`cd unipkg`

step #2: make the install script executable:

`chmod a+x ./install.sh`

step #3: run the install script:

`./install.sh`

the script will first verify the dependencies, then ask you whether you want to use the stable managers.csv file or the dev file. 

stable contains only tested and verified package managers that were provided by a human. 

dev contains a much broader set of package managers, but they are untested and have been created with the help of AI. 


it is highly recommended you stick to the stable csv unless you want to tool around with the config. 


once you've picked your managers file, it'll create your ~/.config/unipkg and ~/.local/share/unipkg directories, populate them, symlink the CLI and TUI into your /usr/bin folder and run the generate function to generate your initial unipkg.conf file. 


## configuration

unipkg is configured with two files:

~/.config/unipkg/managers.csv and ~/.config/unipkg/unipkg.conf


unipkg.conf contains a list of indexes, these indexes are the identifiers unipkg uses for various package managers. menus will only show these options and in any case where unipkg uses multiple package managers, it'll go down this list in order. 

when you install unipkg, it'll run unipkg generate automatically for you, generating a unipkg.conf list that lists all of your installed package managers.

you'll likely want to at least tweak the order of this file, ensuring your primary package manager is put at the top. 

the indexes are defined in managers.csv, with each index having its own line. 

fields are in the following order:
```
IndexName               | the index that unipkg finds the item by
DisplayName             | the display name unipkg uses in responses
VersionCommand          | the command to list the version for this package manager
InfoCommand             | the command to list info for a package for this package manager
InstallCommand          | the command to install packages for this package manager
ListCommand             | the command to list available packages for this package manager, trimmed to only list names
ListUpgradableCommand   | the command to list installed packages with new versions available for this package manager, trimmed to only list names
UpgradeCommand          | the command to run a upgrade all packages with this package manager
RemoveCommand           | the command to remove a package with this package manager
UpdateCacheCommand      | the command to update the cache for this package manager
ListInstalledCommand    | the command to list installed packages for this package manager
Attribution             | who provided the commands
Test Status             | whether or not this config line was tested. 
```

if you want to add your own, you can simply create a new entry by adding a new line and filling in all of the above fields separated by commas, then run unipkg-generate or manually add the index to unipkg.conf. 

some of the above functions are not supported on some package managers, in which case, you can simply add `echo 'feature not supported'`. 

since unipkg effectively just handles running the commands from managers.csv, you can also include your own custom scripting, since technically you can fill in any command. 

piping is supported, but double quotes and commas are not. your command absolutely must not include any commas or double quotes, outside of that any single-line syntax is supported and will be executed as a single line command, potentially appended by one or multiple package names. 



## management and basic access

start by running `unipkg` to get some basic info. 

the TUI is simpler in use than the CLI, you can open the TUI using `unipkg launch-tui`

there is also a full help TUI that you can call with `unipkg help-tui`


to show the available indexes, run `unipkg indexes`, most of the other commands use an index to pick which package manager to use.

many commands also support the extra indexes omni/any/all, which will generally run through all of your configured package managers in order.

to run the auto-configuration, run `unipkg generate`, this regenerates your unipkg.conf in ~/.config/unipkg


after running auto-generation, it is recommended to run `unipkg edit-config` and edit your config to put your primary package manager at the top. 


running `unipkg versions` allows you to check the version of unipkg as well as all configured package managers, you can use this to verify that only the package managers you have configured are in use and that they are listing in the correct order. 


running `unipkg check <index>` checks if the provided package manager is available, this does *not* support omni and will run a check regardless of your unipkg.conf. this is a good way to verify that a package manager is detected before re-generating your config. 

`unipkg check` uses `command -v` to check if the package manager exists, this means it will report as available if a symlink exists, for example, this will likely cause yum to show as available on fedora as fedora still symlinks dnf5 as yum to maintain compatibility.


## package management

the following functions are available to manage packages with unipkg:
```
unipkg info <index> <package> - lists details about that package from the requested package manager
unipkg list available <index> - lists available packages from that package manager
unipkg list installed <index> - lists installed packages from that package manager, supports omni
unipkg list upgradeable <index> - lists packages with updates from that package manager, supports omni
unipkg install <index> <package1> [package2]... - installs packages with the provided package manager, supports omni (will try each package manager in order until it succeeds)
unipkg uninstall <index> <package> - uninstalls the package with that package manager, supports omni (will try each package manager in order until it succeeds)
unipkg update <index> - updates the cache for that package manager, supports omni
unipkg upgrade <index> - upgrades all packages with that package manager, supports omni
```

anything marked as supporting omni supports all three versions (omni/any/all), they are the same function.

with unipkg, a full system upgrade would look like this on *any* system:
`unipkg update all && unipkg upgrade all`


## additional notes

you should never run unipkg as root, unipkg escalates internally using sudo. 

if you want to use something other than sudo, you can simply symlink the binary for that to sudo or alias sudo to your privilege escalation utility of choice in your bashrc.


## TUI 

unipkg comes with an FZF based TUI that can be launched with `unipkg launch-tui`

the main menu has 5 categories: maintenance, lists, install, uninstall and update. 

under maintenance, you'll find utilities to list the indexes, browse help, re-generate your unipkg.conf, list versions, check availability and edit your unipkg.conf

under lists, you'll see a menu with packages on the left and your configured managers on the right. 

you can toggle the left side list between installed, upgradable and available using alt+i, alt+u and alt+l

at any point you can press ctrl+c to go back, to exit, double-press ctrl+c

both install and uninstall will first present you with a selection between your package managers, then shows you a searchable list of packages and info for the selected package. 

the install menu will also allow you to select multiple packages using tab, just note that not all package managers may support this. 

on the install menu, all available packages are listed, on the uninstall menu it will list your installed packages.

the update menu allows you to see packages with updates for each of your package managers. you can press alt+u to run the cache update for that package manager (for example, on ubuntu this would run `apt update`), and press enter to run the system upgrade for that package manager. 


## AI use

As AI is a big topic in FOSS lately, I wanted to make sure my use of AI in this project is very clearly addressed.

I've used AI only to create a development version of the managers.csv file, and i've had it directly cite documentation for each entry. 

nevertheless, this is only as a placeholder until i can get around to actually testing them or someone else provides me with verified commands. 

AI was not used in the development of the rest of the project. 


For your convenience, the unipkg indexes command will list who provided the commands. the stable managers.conf does not contain any AI-generated commands.



