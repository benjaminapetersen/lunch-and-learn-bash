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

## Editing the command line 

Bash has some command line editing features that can save time.  

- Ctrl + a  # jump to the beginning of the line 
- Ctrl + e  # jump to the end of the line 
- Ctrl + u  # clear the cursor to the beginning of the line 
- Ctrl + k  # clear the cursor to the end of the line 
- Ctrl + left arrow # jump to the beginning of the previous word 
- Ctrl + right arrow # jump to the end of the next word
- Ctrl + r  # search the history list of commands for a pattern (continue Ctrl + r till desired match found)

NOTE: on OSX, you have some (bizarre?) alternatives:

- Esc + f  # jump to beginning of next word 
- Esc + b  # jump to the beginning of the current word
- More [at this link](https://stackoverflow.com/questions/81272/is-there-any-way-in-the-os-x-terminal-to-move-the-cursor-word-by-word)


## Addtional tips/tricks 

- Esc .     # retrieve the last arg of last command 
- Alt .     # retrieve the last arg of last command 
- !$        # retrieve the last arg of the last command 
- !:1       # retrieve the first arg of the last command 
- !:1-2     # retrieve the first and second arg of the last command 
- !^        # retrieve the first arg of the last command 
- !!:2      # execute prev command (!!) but only with the second arg to the prev command 
- !pattern  # most recent command matching pattern 
- 

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

### curl


### date

Can either print out the current date or change the system's date and time.

```bash
date                                      # Mon Nov 27 16:41:39 EST 2017
date +%Y                                  # 2017
date +"%Y"                                # 2017
date +"the year is %Y and the day is %d"  # the year is 2017 and the day is 27
date +"%Y %B %d, %a"                      # 2017 January 01, Sun
date +%D                                  # 11/27/17
date +%r                                  # 10:14:06 AM
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

### exit 

Exits the current shell session.

```bash 
exit 
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

### file 

The file command determines the type of a file. Some details 
[here](https://www.computerhope.com/unix/ufile.htm).

```bash 
file file.txt # file.txt: ASCII text
file --brief file.txt # ASCII text
file -b file.txt # ASCII text
# work on multiple files
file -b *.txt 
# view the MIME type of a file
file --mime file.txt 
file -i file.txt 
file -i -b file.txt 
# view compressed files without decompressing them 
file -z file.txt.gz 

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

### head

Print the first N number of lines from an input (usually a file), by default 10 lines.

```bash
head /usr/bin/passwd
head -n 45 /usr/bin/passwd
# print all BUT the last 5 lines
head -n -5 /usr/bin/passwd
# pass output of a command to head
ls -la | head -n 5
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
# copy the last argument of hte previous command 
# useful for reusing args with a new command
Esc+.
```

### less


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

### man 

A command used to format and display the manual pages (man pages). More [on man here](http://www.linfo.org/man.html)
 
```bash 
man <cmd>
man man # meta. 
man ls 
```

### more

### netstat

Netstat (network statistics) lists network connections for TCP (transmission control protocol),
[and other network related protocols](https://en.wikipedia.org/wiki/Netstat).

This program is considered mostly obsolete.  It is superseded by `ss` and other tools.

```bash
# list all
netstat --listen # gnu only
netstat -l # bsd
# search for specific port
netstat -l | grep '<port-number>'
```


### passwd

Change the password of a user acct. Sys admins can use passwd to change other user's passwords. The
command can also be used to define how an account's password can be changed, and can be used to expire
a user's acct.

Commands altering an acct may require root/sudo.

```bash
passwd                  # chance current user acct password
passwd -S some_acct     # see the status of this user acct
passwd -d some_acct     # delete the acct
passwd -e some_acct     # expire the acct
passwd -l some_acct     # lock an acct
passwd -u some_acct     # unlock an acct
passwd -n 90 some_acct  # require update in 90 days
passwd -i 10 some_acct  # makes an acct inactive if it exceeds password update requirement by x days
passwd -w 12 some_acct  # set warning days before password will expire for acct
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

### sort

```bash
# sort a file in ascending order (by line)
sort file.txt
# sort in descending order (reverse)
sort -r file.txt
# sort on a certain column (space between "columns", ie next word, etc)
sort -k 2 file_with_columns.txt
# sort multi column!
sort -k,2 -k 1 file_with_columns.txt # first by column 2, then by column 1
# sort with a field separator that isn't white space
sort --field-separator'|' -k2 file_with_columns.txt # second column, broken with |
sort -t'|' -k2 file_with_columns.txt
# sort tab separated file
sort -k 2 -t $'\t' file_with_tab_columns.txt # special character \t
# pseudo random sort
sort --random-sort file.txt #shuf util provides true random sort, this is simple hashing & incomplete
sort -R file.txt
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

### tail

Print the last N number of lines from an input (usually a file), by default 10 lines.

```bash
tail /usr/bin/passwd
tail -n 45 /usr/bin/passwd 
# pass output of a command to tail
ls -la | tail -n 5
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

### usermod 

Used to change the attributes of an existing user account. 
When using `usermod`, the following files may be affected:

- /etc/passwd – User account info.
- /etc/shadow – Secure account info.
- /etc/group – Group account info.
- /etc/gshadow – Secure group account info.
- /etc/login.defs – Shadow password suite info

Information for `usermod` initially based on 
[this article](https://www.tecmint.com/usermod-command-examples/).

```bash 
# add a comment to the user account 
usermod -c "This guy is a n00b" bob 
# change the home directory for a user 
usermod -d /home/n00b bob  # previously was /home/bob
# change the expiry date (check it initially with `chage`, "change user password expiry information")
chage -l bob # shows expiry info 
usermod -e 2018-01-01 bob 
# change user's primary group (check it initially with `id`)
id bob 
usermod -g n00bs bob
# add a new group to the user (and REPLACE existing!)
usermod -G hobbits bob
# add (append) an additional group to the user (will not REPLACE)
usermod -a -G hobbits bob
# change the user's login name 
usermod -l bob_n00b bob
# after the above, bob will not exist:
id bob # nope 
id bob_n00b # yup
# lock a user account 
usermod -L bob 
# check to see if the acct is locked by viewing /etc/shadow 
grep -E --color 'bob' cat /etc/shadow # color output is handy 
# unlock the acct 
usermod -U bob
# move the user's home dir to a new location: 
usermod -d /home/bob_n00b -m bob
# verify the change in location 
grep -E --color 'bob_n00b' /etc/passwd
ls -l /home/bob 
ls -l /home/bob_n00b
# create an unencrypted password 
usermod -p n00bery bob
# verify the change 
grep -E --color 'n00bery' /etc/shadow # bad! the password is not encrypted
# change the user's shell 
usermod -s /bin/bash bob
# verify the change 
grep -E --color 'bob' /etc/passwd
# change the user id 
usermod -u 888 bob 
# verify the change 
id bob
# change both the uid and the gid of the user 
usermod -u 888 -g 777 bob 
# verify
id bob
```

### vim

For more, see [docs/vim](docs/vim.md).

```bash
# go to particular line of file
vim +<line_num> file.txt
vim +135 file.txt
# go to first match of search term
vim +/<search_term> file.txt
vim +/foo-bar-baz file.txt
# open in redonly mode
vim -R file.txt
```


### wget


### whatis

Perhaps the most important first command.  It tells you "what is" another
command. It is a simpler start than `man`.

```bash
whatis find # find(1)                  - walk a file hierarchy
whatis sed  # sed(1)                   - stream editor
whatis grep # grep(1)                  - file pattern searcher
# etc
```

### wc 

Counts lines, words and characters in a file. 

```bash 
wc /etc/passwd 
# just lines 
wc -l /etc/passwd 
# just words 
wc -w /etc/passwd 
# just characters 
wc -c /etc/passwd  
```

### xargs

A utility used to take input from commands and build and execute new commands.
`xargs` can break lists of arguments into sublists and execute other utilities
multiple times per sublist. The word `sublist` is key, as `xargs` won't just
call the following utility once per arg, but will "chunk" the arguments up in
a much more efficient manner.
[Wikipedia for some examples](https://en.wikipedia.org/wiki/Xargs).

Note that the default argument list marker is `{}`.  It is essentially a placeholder
for passing along arguments (somewhat like an array).

```bash
# pass the output of echo to echo again with xargs (noop)
echo 1 2 3 4 | xargs echo
# now, set a max number of args before xargs will call echo a second time
echo 1 2 3 4 | xargs -n 2 # will call echo twice, once with 1 2, then 3 4
#
# a command can fail if it receives too many arguments.
rm /path/*                # if many items in the path, will crash
rm `find /path -type f`   # may also fail
# to fix this, use xargs to chunk the arguments & call rm multiple times
find /path -type f -print | xargs rm # functionally equivalent to rm `find /path -type f`
#
# INEFFICIENT alternatives:
find /path -type f -exec rm '{}' \; # calls rm once per file. inefficient
find /path -type f -exec rm '{}' + # modern variants of find can be more efficient, however
#
# inputs are typically terminated by whitespace, however, you can signal
# to xargs that the termination is a null character
find . -name "*.txt" -print0 | xargs -0
find . -name "*.txt" -print0 | xargs --null
# the argument list marker {} can be renamed to be more readable
# -I to replace occurrences of replace-str in the initial-arguments with names read from standard input.
find . -name "*.bak" -print0 | xargs -0 -I {} mv {} ~/old_files                 # the usual marker
find . -name "*.txt" -print0 | xargs --null -I the_file mv the_file ~/old_files # will move the_file
# copy and move files
ls *.files.to.move.txt | xargs -n1 -i cp {} /new/dir/for/files
# move & archive files
find / -name *.files.to.archive.txt -type f -print | xargs tar -cvzf some.backup.tar.gz
# download all urls from an input file
cat some-url-list.txt | xargs wget -c
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

```bash
# Kill a running task named <task-name>
kill -9 $(ps -aux | grep -v "grep" | grep <task-name> | awk '{print $2}')
# for example, a grunt task:
kill -9 $(ps -aux | grep -v "grep" | grep grunt | awk '{print $2}')
# explanation:
# $() runs a series of commands and "returns" the output. it is modern version of `command`
# kill is the command to end processes
# -9 ensures the process is killed if it is stuck in a loop
# ps -aux lists currently running processes
# grep -v 'grep' exclude lines with `grep` so we dont accidentally kill current grep (redundant?)
# grep grunt will return the line with the grunt process id
# awk '{print $2}' returns the number in the second column, which is the pid
```

## Notes

To use home made scripts, it is recommended to put them in `~/bin`, as this is fairly standard
across Linux distros.  Then, just double check that it is in your `$PATH` via `echo $PATH`, and
`export PATH=$PATH:~/bin` or add it via your `.bash_profile`.
