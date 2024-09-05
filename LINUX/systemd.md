# systemd

- `systemd` provides a Linux init system
    - Convention of `d`-suffix to imply `daemon` in Linux systems

- https://en.wikipedia.org/wiki/Systemd
- https://next.liquidweb.com/blog/what-is-systemctl-an-in-depth-overview/

- `systemd` is a software suite providing components for managing Linux
operating systems.
- `systemd` is widely adopted across Linux systems since 2015.

## Components

- `systemd` is a system and service manager for Linux OSes
- `systemctl` is a command to introspect & control the state of
  the systemd system and service manager. It is not `sysctl`
- `systemd-analyze` is a tool to assess system boot-up performance
  statistics and retrieve other state

## Components Expanded

- ![Systemd Components](./assets/systemctl2.073020.avif "Systemd Components")

- `systemd` Utilities
  - `systemctl`
  - `journalctl`
  - `notify`
  - `analyze`
  - `cgls`
  - `cgtop`
  - `loginctl`
  - `nspawn`
- `systemd` Daemons
  - `systemd`
  - `journald`
  - `networkd`
  - `logind`
  - `user session`
- `systemd` Targets
  - `bootmode`
  - `shutdown`
  - `basic`
  - `reboot`
  - `multi-user`
    - `dbus`
    - `dlog`
    - `telephony`
    - `logind`
  - `graphical`
    - `user-session`
  - `user-session`
    - `display service`
- `systemd` Core
  - `manager`
  - `systemd`
  - `unit` - Units relate to our unit files, such as `.system`, `.socket`, etc
    - `service`
    - `snapshot`
    - `timer`
    - `path`
    - `mount`
    - `socket`
    - `target`
    - `swap`
  - `login`
    - `multiseat`
    - `session`
    - `inhibit`
    - `pam`
  - `namespace`
  - `cgroup`
  - `log`
  - `dbus`
- `systemd` Libraries
  - `dbus-1`
  - `libpam`
  - `libcryptsetup`
  - `tcpwrapper`
  - `libaudit`
  - `libnotify`
- Linux Kernel
  - `cgroups`
  - `autofs`
  - `kdbus`

## Some Daemons Explained

Besides proviing a Linux init system, `systemd` is a suite that
provides other functionality as well:

- `journald` is a daemon responsible for event logging.
  - It uses append-only binary files as log files
  - There are three choices for logging system events:
    - `systemd-journald`
    - `syslog-ng`
    - `rsyslog`
  - Apparently there is potential for corruption of the binary format
    leading to much debate in the universe
- `libudev` standard lib for `udev`
    - prefix `lib` indicates it is a library
    - Third-party apps can quiery udev resources
    - `udev` is the device manager for the Linux kernel
      - https://en.wikipedia.org/wiki/Udev
      - manages device nodes
      - manages the `/dev` directory (device, not developer)
- `localed`
- `logind`
- `hostnamed`
- `homed`
- `networkd`
- `resolved`
- `systemd-boot`
- `systemd-bsod`
- `systemd-nspawn`
- `timedated`: `systemd-timedated`
- `timesyncd`
- `tmpfiles`: `systemd-tempfiles`
- `udevd`

## Properties

- `systemd` tracks processes via `cgroups`
  - Not with `PIDs`
    - Thus daemons cannot "escape", not even with double-forking.
- `systemd` also uses `systemd-nspawn` and `machinectl`
  - Utilities to facilitate the creation of Linux containers


## Configuration

`systemd` is configured with plain-text files.
These files contain initialization instructions for the various daemons.s
The files are often referred to as `unit file`.
These files contain declarative configuration rather than traditional shell scripts.

Some types:
- `.service`
- `.socket`
- `.device`
- `.mount`
- `.automount`
- `.swap`
- `.target`
- `.path`
- `.timer`
- `.snapshot`
- `.slice`
- `.scope`
- etc

## Service Unit Files

`man systemd.{service,socket,target}`
- `service` https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
- `socket` https://www.freedesktop.org/software/systemd/man/latest/systemd.socket.html
- `target` https://www.freedesktop.org/software/systemd/man/latest/systemd.target.html

`Service` unit files are configuration files which end in `.service`.
- service units actually execute and keep track of `programs` and `daemons`.
  - dependencies used to make sure services start in the correct order
  - services are the most commonly used type of units

`Socket` unit configuration files end in `.socket`.
- Do not execute
  - No programs or daemons started
  - Just sit and listen
    - on an IP address and port, or a UNIX domain socket
    - when something connects to it
      - the underlying daemon is started
      - the connection is then handed to the daemon
- Encodes informaiton about an IPC or network socket or file system FIFO
- controlled and supervised by `systemd`

`Target` unit configuration files end in `.target`
- Used for grouping units and well-known synchronization points during startup
- Targets are more free formed
  - example:
    - `multi-user.target` groups most daemons
      - requires `basic.target` to be activated
        - meaning all services under `basic.target` must be started first

## Managing Services

Services must be managed on order to control what prorams are running and
to ensure they are running correclty.

- A `service` is also called a `unit` in the `systemd` utility.
- A service is any resource that the oeprating system can recognize and manage.
  - A software application
  - A device
  - Any entity that the systemcan act on
- A `unit` is the fundamental object that the system tools use to manage and
  interact with these resources.
- `Unit files` are configuration files that define the attributes and behaviors
  of each unit.  Functions such as `start`, `stop`, `restart`, etc.
- `systemd` tools use the configuration files to ensure that units run correctly
  and that dependencies are met.
- `services/units` are cititcal components of a functional Linux system.


## systemctl status

```bash
# synonymous!
# systemctl will add the .service suffix to look for the .service
# file automatically, if you opt not to type it
systemctl status service_name
systemctl status service_name.service
```

Output looks like:

```bash
# lots of things are reported in status, including the PID, cgroups, etc
[root@host ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2020-05-08 14:15:54 EDT; 1 weeks 2 days ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 3767 ExecReload=/usr/sbin/httpd $OPTIONS -k graceful (code=exited, status=0/SUCCESS)
 Main PID: 1321 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic: 0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─1321 /usr/sbin/httpd -DFOREGROUND
           ├─3769 /usr/sbin/httpd -DFOREGROUND
```

## systemctl start, stop

```bash
# start only works on stopped services
systemctl start service_name.service
# stop only works on started services
systemctl stop service_name.service
```

## systemctl reload

```bash
# restart will stop and then start the service
# this is done gracefully, and will ensure changes
# to configuration files are applied
systemctl restart service_name.service
# reload will tell a service to re-read its configuration files.
# this is useful if it is possible for the service to
# implement changes without needing a restart
systemctl reload service_name.service
# uncertain? it will figure it out for you, maybe
systemctl reload-or-restart service_name.service
```

## systemctl enable,disable

```bash
# update service settings
# ensure systemd starts the service automatically on system boot
# this modifies service configuration
systemctl enable service_name.service
# prevent automatic start on boot,
# the service will be inactive until started manually
systemctl disable service_name.service
```
## systemctl additional commands

```bash
# list all units currently running
# similar to
#   systemctl status
# but not as detailed
systemctl list-units
# display a list of units that are dependent on a specific unit
# this is a hierarchical view, listing units that must be started
# or stopped in a particular order
systemctl list-dependencies service_name.service

# jobs?
# jobs are used to track the progress of any systemd operation,
# such as starting or stopping a service
# this command lists the running jobs
systemctl list-jobs

# reload systemd manager config files. use this:
# - after modifying any service config files
# - after adding new units to the system
systemd daemon-reload

# check if a service is running
systemctl is-active service_name.service
# check if service will auto-start on boot
systemctl is-enabled service_name.service

# an alternative to list-units, this displays all available units on the
# server, not just the ones loaded into memory (ie, some still just in filesystem)
# there will be a STATE column
# STATE can be:
#  - enabled
#  - disabled
#  - static
#  - masked
systemctl list-unit-files
```

Example output of `systemctl list-units`

```bash
# example of list-units
root@host [~]# systemctl list-units
# UNIT is the name of the systemctl unit
# LOAD indicates if the unit's configuration is being loaded by systemd
#  loaded config is stored in the server's memory
# ACTIVE status of the unit
# SUB more detailed information about the unit.
# DESCRIPTION short description for each listed unit
UNIT 		            LOAD   ACTIVE SUB     DESCRIPTION
crond.service 	    loaded active running Command Scheduler
dovecot.service     loaded active running Dovecot IMAP/POP3 email server
firewalld.service   loaded active running firewalld - dynamic firewall daemon
httpd.service 	    loaded active running The Apache HTTP Server
mariadb.service     loaded active running MariaDB database server
named.service 	    loaded active running Berkeley Internet Name Domain (DNS)
```

More detailed version is:

```bash
# lists all units loaded or that the system tried to load
# also shows inactive, dead or failed state units
# also shows units not found on the disk of the server
systemctl list-units --all
# filtering
systemctl list-units --all --state=failed
systemctl list-units --all --type=mount
```
