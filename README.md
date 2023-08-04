# nixnetboot

Boot and automatically install nix on EFI systems using the open source
network boot firmware iPXE.
Requires a DHCP server that sets the hostname, next-server and x64 UEFI
filename. 

Setup
=====

Place the contents of the tftproot (autoexec.ipxe) in your tftp root folder
alongside a working ipxe (download from <https://boot.ipxe.org/ipxe.efi>).
Place the contents of the htdocs folder in the web server root folder. Rename
the hostname file according to the hostname configured in the DHCP server. In
this file also modify the base variable to point to your webserver.
Furthermore, rename the configuration-hostname.nix file to your desired
hostname and adjust the configuration to what you want.

Boot
====

The DHCP server should point to the TFTP server (next-server IP) and the x64 
UEFI filename should be ipxe.efi. Boot the machine over PXE and then ipxe 
will get and run the autoexec.ipxe script which then gets the kernel and 
initrd from the HTTP server and boot the nix installer. The initrd has been 
"patched" to retrieve and run install.sh from the HTTP server.
