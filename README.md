# A Bash Tutorial

Resources used to prep these tasks:

- [Bash Beginners Guide](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html#intro_01)
- [linuxcommand.org](http://linuxcommand.org)
- [linuxjourney.com](https://linuxjourney.com/)


## BSD vs GNU & Using these on MacOS

MacOS (what I work on) features the BSD version of many of these tools.
This is, in my opinion, unfortunate, as BSD is not as user friendly (unconcerned
with issues of usability).  GNU versions of these tools tend to have more
long flags, which are easier to remember & script with.  

To get the GNU version of a tool on MacOS, you can install it via homebrew:

```bash
brew install gnu-sed # installs gsed
brew install gnu-sed --with-default-names # allows gset as `sed`, more ideal
```

To get the NGU versions of many tools on MacOS, you can do install the following
package:

```bash
# these tools all have a `g` prefix
brew install coreutils
# to get around the `g` prefix & use them as normal, add the following
# to your PATH via ~/.bashrc or ~/.bash_profile:
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# to update the manual pages as well, you will need to add this:
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
```

To get even MORE:

```bash
# without aliases:
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt
# with aliases (you prob want this):
$ brew install --with-default-names coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt
# normal names w/o `g` add to PATH via ~/.bashrc or ~/.bash_profile:
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

```

## Some basic bash commands

The following is a list of fundamental commands.  It is important to have a working knowledge of each of these.

<!--
Documenting what I've found to be the most useful/important
bash commands, using the following links as reference points:
- http://www.thegeekstuff.com/2010/11/50-linux-commands
-->

### awk

`awk` searches files for text containing patterns.  While `grep` is used only
for search, `awk` (as well as `sed`) can modify the text in these files. `awk` is
probably the least friendly.

`awk` can be called a pattern scanning and processing language.

`awk` command format is `awk 'pattern {action}' input-file > output-file`.

The [grymoire](http://www.grymoire.com/Unix/Awk.html) is a good resource for awk as well.

Since many unix programs generate text in rows and columns, `awk` is an important tool
to know to process these files.  It is, to a degree, a programming language (though, imho,
like most of bash, its not... elegant).

```bash
# TODO: awk is complex enough you end up writing awk scripts
# will come back to this in the future.
```


### cat

`cat` concatenates files and prints them on `stdout`.

```bash


```

### diff

`diff` compares files line by line and will print to `stdout` the lines that
are  unique to each file. This is useful for a simple diff, when you know two
files are very close to the same.  For more complex diffing, probably a more
powerful tool is in order.

```bash
# ignore whitespace
diff -w file1.txt file2.txt
```

### export

View or create environment variables:

```bash
# view current environment variables
export # dumps all the declare rules
# view a specific environment variable
export | grep USER
export | grep GO  # shows GOPATH, GOROOT, etc
# set an env var temporarily. To make permanent, add to .bash_profile, or other
export SOME_VAR=/foo/bar/baz/shizzle
```


### du

`du` is a utility for disk usage statistics

```bash
# display in human readable output. suffix Byte, Megabyte, etc
du -h file.txt
# grand total of some directory (if multiple files)
du -c /some/dir
#  follow symbolic links
du -h /some/dir/with/symlink/file.txt
# display an entry for each file in dir (same as -d 0)
du -s /some/dir
# display an entry for all files up to certain depth
du -d 4 /some/dir
```

### find

`find` is primarily concerned with finding files by name. It recursively searches a directory
tree and evaluates an expression in terms of each file in the tree.

<!--
Some helpful links on find:
- https://alvinalexander.com/unix/edu/examples/find.shtml
-->

```bash
# find files using a file name
find ./ -name "some-file.txt" # note that ./ will print extra slashes, best to use . only
find . -name "some-file.txt"
find . "some-file.txt" # can skip the -name flag as well
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
find . -atime +2 # accessed greater than two days ago
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
# find files with terrible permissions with -perm
find -type f -perm 0777
# use find with chmod to fix files with bad perms
# TODO: move to cookbook section
find -type f -perm 0777 -exec chmod 755 {} \;
# TODO: move to cookbook section
# Using sed with find, search a directory for a string and replace it with another string
find . -type f -name '*.txt' -exec sed --in-place 'backup-suffix.or.no.backup' 's/foo-bar/baz-shizzle/g' {} \;
find . -type f -name '*.txt' -exec sed -i '' 's/foo-bar/baz-shizzle/g' {} \;
```


### grep

`grep` stands for `g/re/p`, globally search a regular expression and print.  
It is important to note that it is line based,
so adjust your expectations (example: it won't match an expression
multiple times in one line unless you explicitly ask).

`grep`'s basic job is to print lines matching some pattern.

Search file(s) for the occurrence of a string that matches some particular pattern.
For more, [practical grep examples](http://www.thegeekstuff.com/2009/03/15-practical-unix-grep-command-examples/)

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

### ln

TODO: fill out ln

```bash
# symbolic link
ln -s ~/dotfiles/foo ./.foo
```

### lsof

`lsof` stands for "List Open Files".  Think of it as `ls` (list) + `of` (open files).  In
UNIX, everything is a file (pipes, sockets, directories, devices, etc) [quoted here](http://www.thegeekstuff.com/2012/08/lsof-command-examples).  

```bash
# open files belonging to active processes
lsof
# list processes that are listening to a port
lsof -i tcp:<port>
lsof -i tcp:9000
# list process which opened a specific file
lsof /path/to/file.log
# list all processes which opened a file under a specific dir
lsof +D /path/to/dir
# list files opened by process names starting with a string
lsof -c ssh -c init
# list process using a mount point
lsof /home
lsof +D /home
# list files opened by a user
lsof -u <username>
lsof -u bob
# list files opened by a specific process
lsof -p <pid>
lsof -p 12345
# kill processes belonging to a user
kill -9 `lsof -t -u <username>`
kill -9 `lsof -t -u bob`
# list network connections
lsof -i
# list network files used by a process
lsof -i -a -p <pid>
lsof -i -a -p 1234

```

### scp

A command for securely copying files between hosts on a network using ssh for data transfer.

```bash
# TODO:
```

### sed

`sed` stands for `S`tream `Ed`itor. A great overview of sed [here](http://www.grymoire.com/Unix/Sed.html).

`sed`'s job is to filter and transform text from a text stream.

The primary command for sed is substitute.  It has four parts:
  s                        substitue command
  /../../                  delimiter (can change)
  regex search             pattern or string
  replacement string       pattern or string (?)

> NOTE: MacOS uses BSD sed instead of GNU sed, which means it
> has alternate flags (and is lacking the nice, readable long flags).
> This can be remedied with the following:

`$ brew install gnu-sed --with-default-names`

> Yay for usability.

```bash
# the substitute command s
# change occurance of a regex into a new value
sed s/day/night/ < day.txt > night.txt
sed s/day/night/ day.txt > night.txt
# alternative delimiter, use any character you want:
sed s_day_night_ day.txt > night.txt
# from echo (note: only changes the first occurance)
echo "today is a day" | sed s/day/night/
# update a string using & to represent the matched string
sed 's/day/&NOODLES' < day.txt > noodles.txt
# double the matched string
sed 's/day/& &/' < day.txt > double_day.txt
# match any line starting with a numerical value & double the replacement
sed 's/[0-9]*/& &/' < file.txt > nums_doubled.txt
# match any number even if it doesn't start the line & double repalcement
sed 's/[0-9][0-9]*/& &/' nums.txt > nums_doubled_again.txt
#
# using extended regular expressions
# BSD -E works on mac
# GNU -r works on linux
sed -E 's/[0-9]+/& &/' nums.txt > nums_doubled.txt # BSD
sed -r 's/[0-9]+/& &/' nums.txt > nums_doubled.txt # GNU

```

### ssh

A command for executing commands on a remote machine via a secure shell connection.

```bash
# login to a remote machine
ssh foo.bar.com
# login to a remote machine, but specify a different username
ssh -l user foo.bar.com
ssh user@foo.bar.com
# execute a command on a remote machine without actually logging into the shell prompt
ssh user@foo.bar.com ls /some/dir
# use an identity (private key) file  
ssh -i /path/to/id_rsa user@food.bar.com
# debug the ssh client
ssh -v user@foo.bar.com
```

### ssh-keygen

### ssh-copy-id


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

### vim

Vim will be handled separately (vast).d

### whatis

Perhaps the most important first command.  It tells you "what is" another
command. It is a simpler start than `man`.

```bash
whatis find # find(1)                  - walk a file hierarchy
whatis sed  # sed(1)                   - stream editor
whatis grep # grep(1)                  - file pattern searcher
# etc
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
