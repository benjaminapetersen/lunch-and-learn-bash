# A Bash Tutorial

Resources used to prep these tasks:

- [Bash Beginners Guide](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#intro_01)
- [linuxcommand.org](http://linuxcommand.org)


## Some basic bash commands

<!--
Documenting what I've found to be the most useful/important
bash commands, using the following links as reference points:
- http://www.thegeekstuff.com/2010/11/50-linux-commands
-->

### bash

Some quick commands to use in the bash input

```bash
# run the last command
!!
# get portion of last command at <num> index for reuse
!!:<num>
!!:2
# get portion of last command at <num> including all following components for reuse:
!!:<num>*
!!:3*
# run first matching command by search word (DANGEROUS!)
!<term>
!fooba  # would run foobar --baz=shizzle
# run the first command that matches <search-term>
!?foobar --baz=shizzle?
# run previous command by number of indexes back in search
!-2
# run command at history index
!452
# reverse search
Ctrl+r # type search term, then repeat Ctrl+r until match
# replace words in previous command and execute again
# example previous command:
#  foobar --baz=shipple
^shipple^shizzle^ # runs: foobar --baz=shizzle

```

### history

```bash
# see <num> entries form history
history 10


```

### tar

Create, view, modify, update files in the `tar` archive format.

```bash
# create a tar file from files
tar --create --verbose --file=my-archive.tar file1.txt file2.html
tar -cvf my-archive.tar file1.txt file2.txt
# create a tar file from a directory
tar --create --verbose --file=my-archive.tar some-dir/
tar cvf my-archive.tar some-dir/
# extract from an existing tar
tar --extract --file=my-archive.tar
tar --extract --verbose --file=my-archive.tar
tar xvf my-archive.tar
# view files in existing tar archive
tar --list --verbose --file=my-archive.tar
tar tvf my-archive.tar
# append to existing tar
tar --apend --file=my-archive.tar some-file-to-add.txt
# create a gzip-compressed archive
tar --create --gzip --file=my-archive.tar.gz some-dir/
tar -czf my-archive.tar.gz some-dir/
```
### grep

Search file(s) for the occurance of a string that matches
some particular pattern

```bash
# search for a string in a single file
grep "some string" file.txt
# search for a string in all files in the current directory  
grep "some string" *
# recursive
grep --recursive "some string" .
grep -r "some string" ./
# search for a string & show lines before & after the context
# of your search. The possible flags are: --before-context,
# --after-context & --context
grep --after-context 3 --before-context 2 "some string" file.txt
grep -A 3 -B 2 "some string" file.txt
# if you want the same # of lines before and after, just use `-C`:
grep --context 3 "some string" file.txt
grep -C 3 "some string" file.txt
# if you really want to be terse, you can just -<num>
grep -3 "some string" file.txt
# search for a string within a certain set of files in the directory
grep "some string" ./foo_*
# case insensitive search
grep --ignore-case "SoMe StRInG" *
grep -i "SoMe StRInG" *
# search for a regex in a file, a handful of examples:
grep "REGEX" file.txt
grep "^line starts with" file.txt
grep "line ends with$" file.txt
grep "^line contains only these words$"file.txt
grep "starts with this.*and ends with that" file.txt  # .* and has an arbitrary gap in the middle
grep '[Tt]ext' file.txt # Text or text
grep 'T[eE][xX]t' file.txt # Text or TExt or TEXt or... (however, just consider -i unless reason to be picky)
grep '^$' file.txt # blank lines
grep '[0-9][0-9]' file.txt # pairs of digits
```

### git

Git deserves its own lunch and learn, but there are a couple handy commands worth
noting here

```bash
# sign your commit
git commit -s
# simple git log
git log --oneline --decorate  
# fixup a commit by id
git commit --fixup <id-from-some-commit-in-history:
git commit --fixup 4b3fg9
# auto squash if using the above --fixup flag
git rebase -i --autosquash <branch-to-rebase-on>
git rebase --autosquash master
# remove untracked files
git clean -d --force  # -d = directory
git clean -df
```

## Recipes

Some useful mixes of above commands to accomplish common tasks

```bash
# find and replace recursively in a directory with `find` and `sed`
# find ./ and find . are equivalent, find ./ is clearer to me, but
# find . will actually return a cleaner response: .//foo.txt vs ./foo.txt
# -exec executes the utility program given as an arg, plus feeds this
# program the remaining arguments
# sed is a `stream editor`
# the essential command is `s` for substitution, which is included in the string you give it
# s/apple/orange/g
find ./ -type f -exec sed --in-place --expression 's/apple/orange/g' {} \;
find ./ -type f -exec sed -i -e 's/apple/orange/g' {} \;

```

## Notes

To use home made scripts, it is recommended to put them in `~/bin`, as this is fairly standard
across Linux distros.  Then, just double check that it is in your `$PATH` via `echo $PATH`, and
`export PATH=$PATH:~/bin` or add it via your `.bash_profile`.
