script functions:


unipkg-indexes
usage: `unipkg-indexes`
function: lists available package managers and their indexes

unipkg-check
usage: `unipkg-check <index>`
function: checks if a specific package manager is available on the system

unipkg-versions
usage: `unipkg-versions`
function: outputs the version for all package managers configured in ~/.config/unipkg/unipkg.conf

unipkg-generate
usage: `unipkg-generate`
function: checks for every package manager in the managers.csv file and generates unipkg.conf with *all* available package managers. 

unipkg-info
usage: `unipkg-info <index> <packagename>`
function: fetches information about a package from a specific package manager

unipkg-list
usage: `unipkg-list <index>`
function: lists available software from the remote repositories for the provided package manager 

unipkg-list-installed
usage: `unipkg-list-installed <index>`
function: lists packages installed with the provided package manager, supports "all/any" keywords

unipkg-list-upgradable
usage: `unipkg-list-upgradable <index>`
function: lists installed packages for a specific package manager that have newer versions available in that package manager, supports "all/any" keywords

unipkg-install
usage: `unipkg-install <index> <package1> [package2]`
function: installs the provided packages with the specified package manager, supports "all/any" keywords.

unipkg-uninstall
usage: `unipkg-uninstall <index> <package>`
function: uninstalls the provided package, supports "all/any" keywords

unipkg-update
usage: `unipkg-update <index>`
function: updates the local package cache for the package manager as well as the unipkg cache, supports "any/all" keywords

unipkg-upgrade
usage: `unipkg-upgrade <index>`
function: runs a full system upgrade for the selected package manager, supports "any/all" keywords


managers.csv - master list of commands the scripts use as well as manager indexes the script recognizes. 

unipkg.conf - list of package managers your system should actually try to use.

