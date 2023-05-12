# Containers

Initially the notes in this file will come from the O'Reilly book
titled [Container Security](https://www.oreilly.com/library/view/container-security/9781492056690/) but will likely be 
augmented from several additional resources as I research.  These
are personal notes.
 

## Control Groups (cgroups)

`cgroups` or Control Groups are a fundamental building block of 
container technology.  Cgroups limit resources such as 
memory, CPU, network io.

`cgroups` are critical for container security in that they ensure
one process can't consume excessive resources and starve other 
processes.

`cgroups` are named.  Certain `cgroups`, such as `pid` also provide 
security. For example, `pid` limits the number of processes 
allowed in the `group`. An attack vector called a [fork bomb]() is 
when a process spawns new processes (which may also spawn new processes)
with the intent to cripple a machine.

### Cgroup Heirarchies

```bash
# the linux kernel communicates info about cgroups 
# via a heirarchical filesystem, each managed by a controller: 
ls /sys/fs/cgroup
# blkio  cpu  cpuacct  cpu,cpuacct  cpuset  devices  freezer  hugetlb  memory  net_cls  net_cls,net_prio  net_prio  perf_event  pids  rdma  systemd  unified
# memory cgroup as an example:
ls /sys/fs/cgroup/memory/
# cgroup.clone_children  init.scope           memory.kmem.limit_in_bytes      memory.kmem.tcp.limit_in_bytes      memory.limit_in_bytes        memory.memsw.max_usage_in_bytes  memory.oom_control          memory.swappiness      release_agent
#         ...
```

Some cgroups can be written to, some should not. Documentation alone
is necessary to know which 