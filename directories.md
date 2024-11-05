# Directories

- http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
  - A good list of all the filesystem directories

To undestand where to put new binaries, use:
- `/usr/local/bin`
- `/usr/local/sbin`

`/local` means "not managed by the system packages".  Refer to the
following to understand the basics:

- `/bin` : For binaries usable before the /usr partition is mounted. This is used for trivial binaries used in the very early boot stage or ones that you need to have available in booting single-user mode. Think of binaries like cat, ls, etc.
- `/sbin` : Same, but for binaries with superuser (root) privileges required.
- `/usr/bin` : Same as first, but for general system-wide binaries.
- `/usr/sbin` : Same as above, but for binaries with superuser (root) privileges required.