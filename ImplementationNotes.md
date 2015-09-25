# Implementation Notes #

## The topo Executable ##

The topo executable is the core of Topo; the scripts and helper application are little more than wrappers that execute topo.

The executable is written in Tcl. Just about any scripting language with some sort of key-value dictionary would have done just as well. I chose Tcl because it ships with Mac OS X (as does Python and Ruby) and because I am fairly fluent in Tcl, having recently completed a large project at work using Tcl.

The executable parses ~/.ssh/config and creates a dictionary of hosts and tunnels.

The executable makes use of the Mac OS X [launchd](https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man8/launchd.8.html) process manager through the  [launchctl](http://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man1/launchctl.1.html) interface. This dependence is one of the main impediments to porting Topo to other operating systems. Specifically:

  * It determines if a tunnel is open by looking for a job labelled "org.alan-watson.topo._tunnel_".

  * To open a tunnel, it submits a ssh command labelled "org.alan-watson.topo._tunnel_". Since launched restarts jobs that exit, this ensures that the tunnel will attempt to reconnect if for some reason the ssh command exits.

  * To close a tunnel, it removes the job labelled "org.alan-watson.topo._tunnel_".

After most subcommands, the topo executable updates the script menus.

## The Scripts Menu ##

The scripts directory is /Library/Scripts/Topo.

The activate subcommand creates the scripts directory.

When topo updates the scripts directory (implicitly or explicitly), if the directory does not exist, topo does nothing. Otherwise it removes all scripts and then creates the following scripts:

  * Scripts for each closed tunnel under the "Open..." submenu. These are shell scripts that execute "topo open _tunnel_".

  * Scripts for each open tunnel under the "Close..." submenu. These are shell scripts that execute "topo close _tunnel_".

  * Scripts in to open or close all tunnels under the "Open..." and "Close..." submenu. These are shell scripts that execute "topo openall" and "topo closeall".

  * The Restart script. This is a shell script that executes "topo startup".

  * The About script. This is an AppleScript script that displays a dialog with information on Topo.

If FastScripts is installed, topo arranges that the scripts are ordered and separated. The means to do this is described in the [FastScripts documentation](http://www.red-sweater.com/RedSweater/FSFeatures.html).

## The TopoHelper Application ##

The activate subcommand configures the TopoHelper application to run at login. (To see this, check the "Login Items" for an account in the System Preferences.)

All the TopoHelper application does if check if the script directory exists and then, if it does, run "topo startup".

The deactivate subcommand does not remove the TopoHelper application from the items that run at login; this would require significant editing of the loginitems plist. However, it does remove the script directory, which cause the TopoHelper application to do nothing.

## Packaging ##

The Makefile creates a package and disk image (DMG) containing the package, a README file, and a copy of the license.

The package description (Topo.pmdoc) is most easily edited using the [PackageMaker](http://developer.apple.com/library/ios/#documentation/DeveloperTools/Conceptual/PackageMakerUserGuide/Introduction/Introduction.html) application, which is part of the Xcode suite.