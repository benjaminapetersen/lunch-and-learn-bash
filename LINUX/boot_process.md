# Linux Boot Process

- [The Linux Boot Process](https://www.linkedin.com/posts/bytebytego_systemdesign-coding-interviewtips-activity-7207604812610240512-s8_k?)
- ![Linux Boot Process](./assets/linux_boot_process_1718426891623.gif "Linux Boot Process")

The steps:

1. Power on
   - BIOS (Basic Input/Output System) or UEFI (Unified Extensible Firmware Interface)
     firmware is loaded from non-volatile memory.
   - Executes POST (Power on Self Test)
2. BIOS/UEFI detects connected devices
   - CPU
   - RAM
   - Storage
   - etc.
3. Choose boot device for OS
    - Hard drive
    - Network system
    - CD ROM
    - etc
4. BIOS/UEFI runs boot loader (GRUB: Grand Unified Boot Loader)
   - Provides menu to choose:
     - OS
     - Kernel functions
5. Switch to user space
   - After the Kernel is ready
   - Kernel starts `systemd` as first user-space process
   - `systemd` manages
     - processes
     - services
     - probes
     - remaining hardware
     - mounts filesystems
     - runs the desktop environment
6. `systemd` activates the default.target unit
   - Analysis units activated
7. System runs startup scripts
   - Environment is configured
8. Login window presented to user
    - System is ready
