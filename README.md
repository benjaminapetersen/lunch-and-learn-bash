# A Bash Tutorial

Resources used to prep these tasks:

- [Bash Beginners Guide](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#intro_01)
- [linuxcommand.org](http://linuxcommand.org)


## Some basic bash commands

The following is a list of fundamental commands.  It is important to have a working knowledge of each of these.

<!--
Documenting what I've found to be the most useful/important
bash commands, using the following links as reference points:
- http://www.thegeekstuff.com/2010/11/50-linux-commands
-->


### find

Find recursively searches a directory tree and evaluates an expression in terms of each file in the tree.

<!--
Some helpful links on find:
- https://alvinalexander.com/unix/edu/examples/find.shtml
-->

```bash
# find files using a file name
find ./ -name "some-file.txt" # note that ./ will print extra slashes, best to use . only
find . -name "some-file.txt"
# case insensitive
find . -iname 'some.*'
# wildcard search
find . -name "some-.*"
# search in multiple dirs
find ~/foo ~/bar ~/baz -name '*.txt' -type f
# inverse the match with -not
find . -type f -not -name '*.html' # find all non-html files
# find empty files
find ~ -empty
# execute commands on found files using `-exec`, which will pipe following args to that command:
find ./ -name "some-file.txt" -exec md5sum {} \;
find ./ -name "some-file.txt" -exec chmod 644 {} \;
# find by file type
find . -type f # files
find . -type d # directories
# find file owned by user
find . -user <user-name>
# find file owned by group
find . -group <group-name>
# find files by access time
find . -atime 2 # accessed 2 days ago
find . -atime -2 # accessed less than two days ago
# find files by modification time
find . -mtime 1 # modified one day ago
find . -mtime +7 # modified more than 7 days ago
# delete found files
find . -name "garbage.*" -delete
# find files & copy them to another dir
find . -type f -name "*.mp3" -exec cp {} ~/tmp/my-music \;
# use find to copy 1 file into many directories using `-exec cp`
find ./dir1 dir2 ~/dir3 -type d -exec cp some-file.txt {} \;
```


### grep

Grep stands for `g/re/p`, globally search a regular expression and print.  It is important to note that it is line based,
so adjust your expectations (example: it won't match an expression multiple times in one line unless you explicitly ask).

Search file(s) for the occurrence of a string that matches some particular pattern. For more, [practical grep examples](http://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples/)

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
grep --after-context 3 "some string" file.txt
grep --before-context 2 "some string" file.txt
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
# multiple regex
grep --regexp="[Ss]ome" --regexp="[Tt]ext" file.txt
grep -e "[Ss]ome" -e "[Tt]ext" file.txt
# invert multiple regex (non matches)
grep --invert-match -e "[Ss]ome" -e "[Tt]ext" file.txt # -v is short for --invert-match
# search for exact word match.
grep --word-regexp 'is' file.txt  # this, his, etc will not match, only 'is'
grep --w 'is' file.txt
# custom highlight output before doing next search
export GREP_OPTIONS='--color=auto' GREP_COLOR='100;8'
# invert the match (search for non matches)
grep --invert-match "some string" file.txt
grep -v "some string" file.txt
# count lines that match
grep --count "some string" file.txt  # <num>
grep -c "some string" file.txt
# count lines that do not match
grep -v -c "some string" file.txt
# print only matching filenames
grep --files-with-matches "some string" ./
grep -l "some string" ./
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

### history

```bash
# see <num> entries form history
history 10

```
While not explicitly using `history`, the following work off of the history file:

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

### scp

A command for securely copying files between hosts on a network using ssh for data transfer.

```bash
# TODO:
```

### sed

Sed stands for `S`tream `Ed`itor. A great overview of sed [here](http://www.grymoire.com/Unix/Sed.html)

```bash
# TODO: more
# Using sed with find, search a directory for a string and replace it with another string
find . -type f -name '*.txt' -exec sed --in-place 'backup-suffix.or.no.backup' 's/foo-bar/baz-shizzle/g' {} \;
find . -type f -name '*.txt' -exec sed -i '' 's/foo-bar/baz-shizzle/g' {} \;
```

### ssh

A command for executing commands on a remote machine via a secure shell connection.

```bash
# TODO:
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
