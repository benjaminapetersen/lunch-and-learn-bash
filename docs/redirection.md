# Redirection

- http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-3.html

Redirection has to do with file descriptors.  There are 3:

- stdin
- stdout
- stderr

In scripts, `1` represents `stdout` and `2` represents `stderr`.

## Using redirection

```bash
# this will write the output you would normally see on screen
# to a file instead
ls -la > ls-la.txt
```
