# A Bash Reference Sheet

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


## Globbing / Expansion

Bash supports globbing (pattern matching).  Therefore any/many/most commands should
be able to integrate the following:

```bash
*             # any set of zero or more charcters
?             # any single character
~             # home dir
~ username    # home dir of a user
~+            # current working directory
~-            # previous working dir
[characters]  # match any characters in the set 'characters
[!characters] # match any characters no in the set 'characters'
[[:class:]]   # match any characters of the specified class
[abc...]      # Any one character in the enclosed set/class.
[!abc...]     # Any one character not in the enclosed set/class.
[^abc...]     # Any one character not in the enclosed set/class.
[[:alpha:]]   # Any alphabetic character
[[:lower:]]   # Any lower-case character
[[:upper:]]   # Any upper-case character
[[:alnum:]]   # Any alphabetic character or digit
[[:punct:]]   # Any printable character not a space or alphanumeric
[[:digit:]]   # Any digit, 0-9
[[:space:]]   # Any one whitespace character;
              # may include tabs, newline, or carriage returns,
              # and form feeds as well as space
```

Some examples:

```bash
# setup a space to do these tests:
mkdir globbing
cd globbing
touch foo bar baz alfa bravo charlie delta echo able baker candle dog elephant
# now try globbing
ls a*             # should match alfa, able
ls *a*            # match anything with an a start, middle or end of word
ls [ac]*          # match anything with an a or a c
ls [!a]*          # match files not starting with a
ls ????           # match anything with 4 characters
ls ?????          # match anything with 5 characters
ls ???*           # match files with at least 3 characters
ls *[[:digit:]]*  # match files that contain a number
ls [[:upper:]]*   # match files starting with an uppercase character
ls hi*.txt        # any file beginning with hi and ending with .txt
ls Data???        # any file beginning with Data and followed by exactly 3 chars
ls [abc]*         # any file beginning with a, ab, or ac
ls BACKUP[0-9][0-9][0-9] # any file starting with BACKUP follwed by exactly 3 numerals
ls [[:upper:]]*   # any file starting with an uppercase letter
ls [![:digit:]]*  # any file not beginning with a numeral
ls *[[:lower:]123]  # any file ending with a lowercase letter, or the numerals 123
# etc.
```

## Brace Expansion

```bash
echo {foo,bar,baz,shizzle}.log
# foo.log bar.log baz.log shizzle.log
echo file{1..3}.txt
# file1.txt file2.txt file4.txt
echo file{a..c}.txt
# filea.txt fileb.txt filec.txt
echo file{a,b}{1,2}.txt
# filea1.txt filea2.txt fileb1.txt fileb2.txt
echo file{a{1,2},b,c}.txt
# filea1.txt filea2.txt fileb.txt filec.txt
```

## Command substitution

```bash
echo Today is `date +%A`.
# Today is Monday.
echo The time is $(date +%M) minutes past $(date +%l%p)
# The time is 15 minutes past 12pm
```

# Parameter substitution

Some useful tools and tricks around parameter substitution.  For [more](http://www.tldp.org/LDP/abs/html/parameter-substitution.html)

```bash
# best practice, always quote strings and use this form:
echo "name is ${first_name} ${middle_name} ${last_name}"
echo "Old \$PATH = $PATH"
```

```bash
# use defaulting
PRIMARY=1
BACKUP=2
echo "The value is ${PRIMARY-$BACKUP}"
# defaulting, if a var is declared but null
SECONDARY=
BACKUPAGAIN=2
echo "The value is ${SECONDARY:-$BACKUPAGAIN}"
```

```bash
# use defaulting to provide "missing" args to command line scripts
DEFAULT_FILENAME=foobar.txt
filename=${1:-$DEFAULT_FILENAME}
echo "The filename is ${filename}"
```

```bash
# can use defaulting inline, but do note, this reads in a misleading way
echo ${var=abc} # abc
echo ${var=zyx} # still abc!  this is defaulting, despite the =
```

```bash
# opposite of default, set an alternative value if the value HAS been set
foo=
bar=${foo+xyz}
echo "bar = ${bar}" # xyz, was set, but null
baz=123
qux=${baz+xyz}
echo "qux = ${qux}" # xyz, was set to a value
shizzle=${pop+xyz}
echo "shizzle = ${shizzle}" # nothing, pop had no value, was not set
# oh but watch out for that :
jack=
jane=${jack:+xyz}
echo "jane = ${jane}" # nothing. jack was set null, like above, but the : will ignore null
```

```bash
# trim strings
url="http://example.com:8443"
# trim from the beginning of a string
without_http=${foo#"http://"}
# trim from the end of a string
without_port=${foo%":8443"}
```

## Control flow

### If statements

Basic if statement

```bash
# -gt greater than
if [ $1 -gt 100 ]
then
  echo "arg is greater than 100"
fi
```

Nested if statement

```bash

if [ $1 -gt 100 ]
then
  echo "arg is greater than 100"
  if (( $1 % 2 == 0 ))
  then
    echo "arg is an even number"
  fi
fi
```

If else statement

```bash
if [ $1 -gt 100 ]
then
  echo "arg is greater than 100"
else
  echo "arg is smaller than 100"
fi
```

If elseif else statement

```bash
# -gt greater than
# -lt less than
if [ $1 -gt 100 ]
then
  echo "arg is greater than 100"
elif [ $1 -lt 10 ]
then
  echo "arg is less than 10"
else
  echo "arg is mid range"
fi
```

### Boolean statements

```bash
# -r is readable
# -s is size
if [ -r $1 ] && [ -s $1 ]
then
  echo "file is readable and not empty"
fi
```

```bash
if [ $USER == 'john' ] || [ $USER == 'jane' ]
then
  echo "known user"
else
  echo "unknown user"
fi
```

### Case statement

```bash
# end of statement with ;;
# * represents any number of any char, as the last case
case $1 in
  start)
    echo starting
    ;;
  stop)
    echo stoping
    ;;
  restart)
    echo restarting
    ;;
  *)
    echo don\'t know
    ;;
esac
```

## Permissions

Unix-like systems are multi-tasking, and multi-user. See [Permissions](https://linuxcommand.org/lc3_lts0090.php)

Permissions are important, as well as understanding `chmod`, `su`, `sudo`, `chown`,`chgrp` commands.

Files are directories are assigned access rights for `owner`, `group`, and `world` (everyone else). Rights granted via permissions are `read`, `write`, and `execute`.

```bash
# example permissions settings:
# with spaces for readability:
#  - rwx r-x r-x
# first character - indicates file. if directory it would be "d"
# 3 sets of 3:
#   rwx = owner can read, write, execute
#   r-x = group can read, execute
#   r-x = world can read, execute
-rwxr-xr-x
```

```bash
# permissions viewed as a series of bits (like the machine would interpret)
rwx rwx rwx = 111 111 111
rw- rw- rw- = 110 110 110
rwx --- --- = 111 000 000
# bits, in binary, are as follows:
rwx = 111 in binary = 7
rw- = 110 in binary = 6
r-x = 101 in binary = 5
r-- = 100 in binary = 4
```

Common sets of file permissions:

- `777`	(`rwxrwxrwx`) No restrictions on permissions. Anybody may do anything. Generally not a desirable setting.
- `755`	(`rwxr-xr-x`) The file's owner may read, write, and execute the file. All others may read and execute the file. This setting is common for programs that are used by all users.
- `700`	(`rwx------`) The file's owner may read, write, and execute the file. Nobody else has any rights. This setting is useful for programs that only the owner may use and must be kept private from others.
- `666`	(`rw-rw-rw-`) All users may read and write the file.
- `644`	(`rw-r--r--`) The owner may read and write a file, while all others may only read the file. A common setting for data files that everybody may read, but only the owner may change.
- `600`	(`rw-------`) The owner may read and write a file. All others have no rights. A common setting for data files that the owner wants to keep private.

Common sets of directory permissions:

- `777`	(`rwxrwxrwx`) No restrictions on permissions. Anybody may list files, create new files in the directory and delete files in the directory. Generally not a good setting.
- `755`	(`rwxr-xr-x`) The directory owner has full access. All others may list the directory, but cannot create files nor delete them. This setting is common for directories that you wish to share with other users.
- `700`	(`rwx------`) The directory owner has full access. Nobody else has any rights. This setting is useful for directories that only the owner may use and must be kept private from others.

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

### ASDF

`asdf` is a version manager for any programming language, not just a single
language.

- https://asdf-vm.com/guide/getting-started.html
- https://www.ookangzheng.com/asdf-to-manage-multiple-golang-on-mac/

```bash
# they really want git instead of brew :(
# brew install asdf
# then update ~/.zshrc
plugins=(
    asdf # use the plugin for asdf
)
# then in iTerm
asdf plugin-add python
asdf plugin-add golang
# you can specify a url, but shouldn't need to
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# versions currently installed
asdf list ruby
asdf list nodejs
asdf list golang

# all possible verisons available
asdf list all ruby
asdf list all nodejs
asdf list all golang

asdf install golang 1.20
asdf install golang 1.19
asdf install golang 1.18
# etc
asdf list golang
# set global
asdf global golang latest
asdf local golang 1.18.10

# Warning!
# After using go get or go install to install a package you need to run asdf reshim golang to get any new shims.
go get <some.package> # such as golangci-lint, this was a "gotcha" for me.
# unfortunate hassle, if you forget the error is not obvious.
go reshim golang
```


### base64

By default `base64` will encode a string.  You pass `--decode` for it to decode a string.  To
use `stdin`/`stdout` you want to `echo` values and `|` pipe them to `base64`.

```bash
# base64 encode data
echo "Hello World!" | base64  # SGVsbG8gV29ybGQK
# base64 decode data
echo "SGVsbG8gV29ybGQK" | base64 --decode # Hello World!
```

### cal

`cal` just prints a nifty little cal, highlighting today's date.

```bash
cal
#      July 2021
# Su Mo Tu We Th Fr Sa
#              1  2  3
#  4  5  6  7  8  9 10
# 11 12 13 14 15 16 17
# 18 19 20 21 22 23 24
# 25 26 27 28 29 30 31
```

### cat

`cat` concatenates files and prints them on `stdout`.
[Some basic cat commands](https://www.tecmint.com/13-basic-cat-command-examples-in-linux/)

With a small input, `cat` will often function as a basic file reader.  This is handy,
but its intended use is actually as a string manipulation program.  `cat` is intended
to take multiple inputs and stick them end to end (concatonate).  That said, with
just a single argument, cat will print to stdout, which makes it a handy simple file
reader also. For a more robust solution, see `less`.

```bash
# display contents of a file
cat /etc/passwd
# see line numbers
cat -n ./file
# display contents of several files
cat ./file ./file2
# also display multiple files
cat ./file; cat ./file2; cat ./file3
# create a file from stdin. when done typing, press ctrl+D
cat >file3
# too much text? pass to more or less
cat ./song.txt | more
cat ./song.txt | less
# display $ at end of lines and file
cat -e ./song.txt
# display tab separated lines
cat -T ./song.txt
# copy contents of one file into another file
# this will overwrite the contents of destination!
cat ./source.txt ./destination.txt
# read several files and write to a third file
cat ./source1.txt ./source2.txt ./source3.txt > ./destination.txt
# sort several files into a single file!
cat ./source1.txt ./source2.txt ./source3.txt | sort > ./destination.txt
# append to destination file the contents of source
cat ./source.txt >> ./destination.txt
# redirect with standard input. < will take file contents as input for command
# for cat, this seems basically the same as normal usage?
cat < ./file
```

### cd

Change directory

```bash
cd /foo/bar
# return to the directory you were previously
cd -
# go up one directory
cd ..
# go up two directories
cd ../..
# return to your home directory
cd
# move to the binaries location
cd /bin
# move to the binaries location from root
cd bin
```

### chown

Change file ownership

```bash
# change file ownership from "me" to "you"
# changing file ownership may require super user priviledges (sudo)
sudo chown you some_file
```

### chgrp

Change group ownership

```bash
# previous group is replaced by new group ownership
chgrp new_group some_file
```

### cp

Copy file(s).  Be careful, if new file name is not unique,
the cp command will overwrite the existing file.

```bash
cp file.txt file2.txt
# copy file(s) into a directory
cp file.txt file2.txt some/dir
# copy a non-empty directory
cp -r ./dir ./dir2
# copy multiple files to current dir
cp ../file.txt ../file2.txt .
# copy multiple directories to current dir
cp -r ../dir ../dir2 ../dir3 ../dir4 .
```

### curl

A tool for transferring data to and from a server, as well as the manipulation of URLs.
Some further details [here](https://curl.haxx.se/docs/httpscripting.html).

```bash
# make a GET request for a URL
curl http://example.com
# make a GET request and be explicit about response details
# significant more information returned about the request
curl http://example.com --verbose
# far more intersting when done with https to watch the TLS handshake
curl https://example.com --verbose
# don't check the certs. helpful for self signed certs in dev environments
curl https://example.com --insecure
# how long it takes?
curl http://example.com --trace-time
# redirect the response body (only, even if --verbose flag used) to a file
curl http://example.com -o foobar.txt
# override DNS or /etc/hosts by providing a different IP address for a named host
curl --resolve www.example.com:80:127.0.0.1 http://www.example.com
# specify a proxy, such as for an alternative port
curl --proxy http://example.com:1234 http://example.com
# Basic auth. provide user / pass to HTTP authentication. no longer common, most websites use cookies
curl http://user:pass@example.com
curl -u user:pass http://example.com
# basic auth for a proxy user to make request through proxy
curl --proxy-user proxuser:proxpass http://example.com
# headers only
curl --head http://example.com
# several urls
curl http://example.com http://other-example.com
# series of several urls with different methods such as HEAD,GET and POST,GET
curl -head http://example.com --next http://example.com
curl --data age=37 http://example.com/how-old --next http://example.com/your-profile
# GET form post
curl "http://example/.com/profile?age=37&name=bob&submit=go"
# POST form post, note that curl will not properly encode the data for you!
curl --data "age=37&name=bob&submit=go" http://example.com/profile
# follow lcoation redirect header
curl --location http://example.com
# add a cookie
curl --cookie "name=bob" http://www.example.com
# dump headers (there better options)
curl --dump-header headers_and_cookies http://www.example.com
# a slightly more complex example to check an oauth token endpoint and write output to file
curl https://example.com/oauth/token --insecure --verbose -o foobar_baz.txt --dump-header headers_and_cookies
# use cookies from a file, useful to reconnect with cookies from previous connection
curl --cookie cookie-jar.txt http://www.example.com
# share cookies between scripts with cookie-jar flag
curl --cookie cookies.txt --cookie-jar newcookies.txt http://www.example.com
# with certificate
curl --cert cert.pem https://www.example.com
# or with a cert store
curl --cacert ca-bundle.pem https://www.example.com
# truncate a header by providing empty value to manipulate a request
curl --header "Host:" http://www.example.com
# add additional headers
curl --header "Destination:http://example2.com" http://www.example.com
# dump a trace as ascii to a file
curl http://www.example.com --trace-ascii trace.ascii.txt
# with a bearer token
curl --insecure -H "Authorization: Bearer <some-token>" https://example.com
```

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

### df

Display free disk space.

```bash
df
# all filesystems
df -a
# display in power of 1024 (much more readable)
df -h
# display in power of 1000.
df -H
# total (noop on MacOS, already prints totals)
df -t
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
# find by extensions
find . -name '*.go'
# find by extensions, then filter down with grep
find . -name '*.jpg' -o -name '*.png' -print | grep ninnyhammer
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

### free

Get a report of system memory usage

- total: all the memories!
- used: `used = total - free - buffers - cache`
- free: unused memory
- shared: ignore, no meaning. backwards compat column
- buff/cache: combined kernel buggers, page caches, slabs. can be reclaimed anytime.
- available: new memory available for new apps w/o using swap

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
# ignore a directory
grep -r "some string" --exclude-dir vendor .
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
# update the last commit message
git commit --amend
# simple git log
git log --oneline --decorate
# fixup a commit by id
# get the id from the command above
git commit --fixup <id-from-some-commit-in-history>
git commit --fixup 4b3fg9
# auto squash if using the above --fixup flag
git rebase -i --autosquash <branch-to-rebase-on>
git rebase --autosquash master
# remove untracked files
git clean -d --force  # -d = directory
git clean -df
```

### head

Print the first N number of lines from an input (usually a file but could be any input), by default 10 lines.

```bash
head /usr/bin/passwd
head -n 45 /usr/bin/passwd
# print all BUT the last 5 lines
head -n -5 /usr/bin/passwd
# pass output of a command to head
ls -la | head -n 5
# limit number of lines returned from another command
# note that if this command prints headers, the header line will count as the first returned line!
kubectl get pods | head -n 2
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
# run the first command that matches pattern <search-term>
!?foo?:p
!?foobar --baz=shizzle?
# print the first command that matches, don't run it
!?foo?:p
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

### hostname

```bash
hostname
```

### id

Find user names, group names, UIDs, group IDs for the current user (in this server context).

```bash
id
# uid=501(ben) gid=20(staff) groups=20(staff),501(awagent),502(awagent_enrolled),12(everyone),61(localaccounts),79(_appserverusr),80(admin),81(_appserveradm),98(_lpadmin),701(com.apple.sharepoint.group.1),33(_appstore),100(_lpoperator),204(_developer),250(_analyticsusers),395(com.apple.access_ftp),398(com.apple.access_screensharing),399(com.apple.access_ssh),400(com.apple.access_remote_ae)
# print only the effective user id
id -u # 501
# display the name of user/group ID, for the -G, -g and -u flags. falls bavk to numbers if no name string
id -n # modifier
# print only the effective group id
id -g # 20
id -gn
# print all group IDs
id -G
id -Gn
# display ID as a password file entry
id -P
# full name
id -F
# process audit
id -A
# auid=501
# mask.success=0xffffffff
# mask.failure=0xffffffff
# termid.port=0x03000002
# asid=100007
```

### jq

This is not built-in.  Install:

```bash
# Debian/Ubuntu
sudo apt-get install jq
# Fedora
sudo dnf install jq
# OSX
brew install jq
```

jq is a [JSON query](https://stedolan.github.io/jq/tutorial/) program.

```bash
# output unchanged
curl 'https://foo.com/api/stuff?limit=5' | jq '.'
# get first
curl 'https://foo.com/api/stuff?limit=5' | jq '.[0]'
# get first, but only certain fields
# | is used within the jq query string to pipe one query to the next
jq '.[0] | {message: .commit.message, name: .commit.committer.name}'
#  view a json string as pretty-printed json output
echo '{"foo":0}' | jq
echo '{"foo":0}' | jq .
# larger json string, pretty printed but still not queried
echo '{"people": [{"name": "jane"},{"name": "jill"},{"name":"jack"}] }' | jq '.'
# grab "people", a top level value
echo '{"people": [{"name": "jane"},{"name": "jill"},{"name":"jack"}] }' | jq '.people'
# grab the first item from people
echo '{"people": [{"name": "jane"},{"name": "jill"},{"name":"jack"}] }' | jq '.people[0]'
# grab the "name" property from the first item in people
echo '{"people": [{"name": "jane"},{"name": "jill"},{"name":"jack"}] }' | jq '.people[0].name'
# optional, there are no fish, jq won't error
echo '{"people":[], "animals": []}' | jq '.fish?'
# slice of an array
echo '{"people": [{"name": "jane"},{"name": "jill"},{"name":"jack"}] }' | jq '.people[1:2]'
# read from a file, print to the screen
jq -r </tmp/some-file.json
# read from a file, query for a value
jq -f </tmp/some-file.json '.path.to.value' # returns raw string, some-value-without-quotes
jq '.path.to.value' -f </tmp/some-file.json # returns json formatted string, "some-value-with-quotes"

```

### less

`less` is a class of programs called a `pager`.
It is an improvement on `more`. A play on words, "less is more".
View the contents of a file.  Some commands when within the file:
- b: back one page
- space: foreward a page
- up: up one line
- down: down one line
- G: end of the file
- g: beginning of the file
- h: show help
- q: quit
- /<search>: search for a string of characters
  - n: within a search, go to next occurance

```bash
less some-file.txt
```


### ln

TODO: fill out ln

```bash
# symbolic link
ln -s ~/dotfiles/foo ./.foo
```

### ls

List directory contents for either a specified directory, or the
current working directory

```bash
# list files
ls
# specify a directory
ls ~/bin
# specify a single file
ls ~/bin/mysleep
# list files in home dir
ls ~
ls -l ~
# include hidden files
ls -a
ls -A  # but don't display . and ..
# reverse order
ls -r
# change the CPU percent calculations (normally no effect, man for details)
ls -C
# sort alphabetically by file extension
ls -X
# sort based on modification time
ls -t
# list subdirectories recursively
# (this could get big)
ls -R
# list file name with inode numbers
ls -i
# list files with details (long list format)
# this shows actual file size (amount of data it contains),
ls -l
# list files with size of the file on the file system / allocated size (this can be different than above ls -l)
ls -s
ls -s --block-size=k foo/bar/baz/*.txt
# list only file name and size
ls -s -h
# list files with indicator for type of file
# (ls typically color coded, but if you want a character
# instead to indicate directory, executable, etc)
#   @ indicates a symbolic link
#   * indicates an executable
#   = indicates a socket file
#   | indicates a named pipe
#   > indicates a door
#   / indicates a directory
#   classify the files. will print trailing / for directories
ls -F
ls --classify
# list file with author
ls --author
# print C-style escape characters for non-printables
# (new lines in file name, etc)
ls -b
# print file sizes using kilobytes or other preferred size
ls -l --block-size=k
# change the output format
# options are 'verbose' or 'long', 'commas', 'horizontal'
# or 'across', 'vertical', and 'single-column'.
ls --format=commas
# hide certain types of files
ls --hide=*.txt
# list contents of multiple directories
ls -l Pictures Movies Videos
```

### lsns

List Linux `namespaces`.  Namespaces control what a process can see.  Along
with `cgroups`, `namespaces` are a critical component of what makes containers.

```bash
lsns
#         NS TYPE   NPROCS   PID USER    COMMAND
# 4026531834 time        3  4406 vagrant /lib/systemd/systemd --user
# 4026531835 cgroup      3  4406 vagrant /lib/systemd/systemd --user
# 4026531836 pid         3  4406 vagrant /lib/systemd/systemd --user
# 4026531837 user        3  4406 vagrant /lib/systemd/systemd --user
# 4026531838 uts         3  4406 vagrant /lib/systemd/systemd --user
# 4026531839 ipc         3  4406 vagrant /lib/systemd/systemd --user
# 4026531840 mnt         3  4406 vagrant /lib/systemd/systemd --user
# 4026531992 net         3  4406 vagrant /lib/systemd/systemd --user
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
man <topic>
man ls
```

Navigating man pages works like the following:

- Spacebar    # Scroll forward (down) one screen
- PageDown    # Scroll forward (down) one screen
- PageUp      # Scroll backward (up) one screen
- DownArrow   # Scroll forward (down) one line
- UpArrow     # Scroll backward (up) one line
- d           # Scroll forward (down) one half-screen
- u           # Scroll backward (up) one half-screen
- / string    # Search forward (down) for string in the man page
- n           # Repeat previous search forward (down) in the man page
- N           # Repeat previous search backward (up) in the man page
- g           # Go to start of the man page.
- G           # Go to end of the man page.
- q           # Exit man and return to the command shell prompt


### mkdir

Create directory(ies)

```bash
mkdir ./dir
# create parent directories if they do not exist
# beware of spelling mistakes! there will be no error
# output for accidentally created directories
mkdir -p foo/bar/baz/dir
```

### more

### mv

Rename file(s) in the same directory, or relocate to a new
directory.

```bash
mv file.txt file2.txt
# move a directory
mv ./dir ./dir2
# move multiple files to a directory
mv file.txt file2.txt file3.txt ./files
```

### netstat

Netstat (network statistics) lists network connections for TCP (transmission control protocol),
[and other network related protocols](https://en.wikipedia.org/wiki/Netstat).

This program is considered mostly obsolete.  It is superseded by `ss` and other tools.

[How to use netstat](https://www.howtogeek.com/513003/how-to-use-netstat-on-linux/)

```bash
# list all
netstat --listen # gnu only
netstat -l # bsd
# search for specific port
netstat -l | grep '<port-number>'
```

### nmap

NMAP is a networking tool that can do quite a few things.
TODO: put some more work into this.

```bash
# use this to check which TLS versions and which ciphers
# for each TLS versions are supported by a particular sever
nmap -sV --script ssl-enum-ciphers -p 443 www.example.com
```

An example output of `nmap` looks like this:

```bash
# this is roughly how our integration tests use nmap
# to get a list of ciphers for a domain.
# it is being used for supervisor or our servers, but it
# can be used for any public domain or IP as well.
nmap --script ssl-enum-ciphers -p 443 www.google.com
# Starting Nmap 7.94 ( https://nmap.org ) at 2024-01-17 17:02 EST
# Nmap scan report for www.google.com (142.251.46.228)
# Host is up (0.075s latency).
# Other addresses for www.google.com (not scanned): 2607:f8b0:4005:813::2004
# rDNS record for 142.251.46.228: sfo03s27-in-f4.1e100.net

# PORT    STATE SERVICE
# 443/tcp open  https
# | ssl-enum-ciphers:
# |   TLSv1.0:
# |     ciphers:
# |       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
# |     compressors:
# |       NULL
# |     cipher preference: server
# |     warnings:
# |       64-bit block cipher 3DES vulnerable to SWEET32 attack
# |   TLSv1.1:
# |     ciphers:
# |       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
# |     compressors:
# |       NULL
# |     cipher preference: server
# |     warnings:
# |       64-bit block cipher 3DES vulnerable to SWEET32 attack
# |   TLSv1.2:
# |     ciphers:
# |       TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
# |       TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
# |       TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
# |       TLS_RSA_WITH_3DES_EDE_CBC_SHA (rsa 2048) - C
# |       TLS_RSA_WITH_AES_128_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_AES_128_GCM_SHA256 (rsa 2048) - A
# |       TLS_RSA_WITH_AES_256_CBC_SHA (rsa 2048) - A
# |       TLS_RSA_WITH_AES_256_GCM_SHA384 (rsa 2048) - A
# |     compressors:
# |       NULL
# |     cipher preference: client
# |     warnings:
# |       64-bit block cipher 3DES vulnerable to SWEET32 attack
# |   TLSv1.3:
# |     ciphers:
# |       TLS_AKE_WITH_AES_128_GCM_SHA256 (ecdh_x25519) - A
# |       TLS_AKE_WITH_AES_256_GCM_SHA384 (ecdh_x25519) - A
# |       TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519) - A
# |     cipher preference: client
# |_  least strength: C

# Nmap done: 1 IP address (1 host up) scanned in 5.28 seconds
```


### openssl

The `openssl` tool is a full suite of tools for cryptography as well as TLS and SSL protocols.
[Home page](https://www.openssl.org/) and [list of commands](https://www.openssl.org/docs/manmaster/man1/).

It is not the most approachable tool, but it is really powerful.

Unlike browsers, which are very trusting by default, OpenSSL trusts nothing by default.

For some background info on file names, formats, etc, [read this stackoverflow](https://serverfault.com/questions/9708/what-is-a-pem-file-and-how-does-it-differ-from-other-openssl-generated-key-file).

For a longer introduction, see [A Six Part OpenSSL Tutorial](https://www.keycdn.com/blog/openssl-tutorial)

A helpful referecnce for generating a CSR [Geneate CSR](https://www.digicert.com/ssl-support/openssl-quick-reference-guide.htm).

The modern internet relies on the PKI (Publik Key Infrastructure) trust.  This is pretty important stuff.

A few items of interest:
- `X.509` [X.509](https://en.wikipedia.org/wiki/X.509) is a standard defining the format of public key certificates.  Included in TLS/SSL for HTTPS protocol, among others.
- `.csr` Certificate signing request to submit to certificate authorities. Format PKCS10 from RFC 2986. Contains the public key of the cert to be signed.  Returned certificate is the public certificate (contains public key, not private key).
- `.pem` Privacy Enhanced Mail format. RFC 1421-1424. May be just the public cert, or may be entire cert chain including public key, private key, and root certificates.  May also encode a CSR. The method to secure mail failed, but the format remains useful. PEM is base64 of x509 ASN.1 keys.  Typically (apache) lives in `etc/ssl/certs`.
- `.key` MEP formatted file of private-key of a specific certificate. Typically (apache) lives in `/etc/ssl/private`. The permissions on this file are very important and many programs will not load it if the permissions are incorrect.
- `.pkcs`, `.pfx` RFC 7292, this is a passworded container format.  Contains public and private cert pairs.  Fully encrypted, unlike PEM files.
- `sha` Secure Hashing Algorithm
- `ssl` Secure Socket Layer
- `tls` Transport Layer Security

#### openssl: Basic Commands

```bash
# openssl version
openssl version
openssl version -a
# list standard commands
openssl list-standard-commands
# list cyphers only
openssl list-cipher-commands
# other commands to list
openssl list-message-digest-commands
openssl list-cipher-algorithms
openssl list-public-key-algorithms
```

#### openssl: Client Tools

```bash
# connect to a server with hostname & port
openssl s_client -connect <domain>:<port>
openssl s_client -connect example.com:443
# view the certificate of a web server
# these commands will show the certificate block as well as
# other information, such as the serial number, issuer, validity,
# modulus (65537 typically), and other details
openssl s_client -showcerts -connect tld.com:443 </dev/null
# view the certificate of a web server using SNI
openssl s_client -showcerts -servername tld.com -connect full.path.to.resource.tld.com:443 </dev/null
# view full details of a web server certificate
echo | \
    openssl s_client -servername tld.com -connect full.path.to.resource.tld.com:443 2>/dev/null | \
    openssl x509 -text
# view only the certificate block
echo | openssl s_client -connect full.path.to.resource.tld.com:443 2>/dev/null | openssl x509
```


#### openssl: Ciphers

See the [ciphers manual page](https://www.openssl.org/docs/manmaster/man1/ciphers.html).

```bash
# see the list of supported ciphers
openssl ciphers
# split the list out in a more readable format, its long and : separated
openssl ciphers | tr ":" "\n "
# select a cipher list and use to connect to a domain. lists are : separated and the first match will be chosen
openssl s_client \
  -cipher ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES256-GCM-SHA384 \
  -connect example.com:443
# cipher list can also be a group, based on required features. these will be pattern matched
#   example: require ephemeral ECDH agreement, RSA for authentication, and only "high" encryption:
#   from https://security.stackexchange.com/questions/93143/how-to-pass-cipher-list-to-openssl-s-client
openssl s_client -cipher ECDH+aRSA+HIGH -connect example.com:443
```

#### openssl: Cryptography

```bash
# generate a public and private key
# the public key is
openssl genrsa -out key.pem 1024
# view the key
cat key.pem
# view all the details in human friendly format
# this includes exponents, modulus, primes, etc
openssl rsa -in key.pem -text
# view the details, but prevent key itself from being displayed in base64 format
# only hexadecimals will be displayed
# public exponent will still be displayed.  it is always 65537 for 1024 keys.
openssl rsa -in key.pem -text -noout
# encrypt the private key
openssl rsa -in key.pem -des3 -out enc-key.pem
# extract public key
openssl rsa -in key.pem -pubout -out pub-key.pem
# encrypt a file using keys
# note that since using RSA, file must be less than 116 bytes.
openssl pkeyutl -encrypt -in input.txt -inkey key.pem -out output.bin
# decrypt the same file by flipping the flag & inputs
openssl pkeyutl -decrypt -in output.bin -inkey key.pem -out output.decrypt.bin

echo "sign me" > sign-me.txt && \
  openssl dgst -sha256 < sign-me.txt > signme.hash
# then sign the hash
# creates a file something like:
#    <padding><metadata><hash of input>
openssl dgst -sha256 -sign key.pem -out signme.hash.signature signme.hash
# then verify the signature of the hash against the hash (with the associated public key)
openssl dgst -sha256 -verify pub-key.pem -signature signme.hash.signature signme.hash
# verify the integrity of the payload?
# TODO:
# create a hash of data
# compute a digest value for a large file to make the digital signature verification more efficient
# verifyme.digest will look something like: SHA256(verifyme.txt)= 838b0a...
openssl dgst -<hash_algorithm> -out <digest> <input_file>
echo "verify me" > verifyme.txt && openssl dgst -sha256 -out verifyme.digest verifyme.txt
# compute the signature of the digest file
openssl pkeyutl -sign -in verifyme.digest -out verifyme.digest.signature -inkey key.pem
# check the validity of the signature
openssl pkeyutl -verify -sigfile verifyme.digest.signature -in verifyme.digest -inkey key.pem
openssl pkeyutl -verify -sigfile verifyme.digest.signature -in verifyme.digest -inkey key.pem -pubin
# generate a certificate signing request
openssl req -new -key yourdomain.key -out yourdomain.csr
# generate, but provide details with -subj instead of the prompts
openssl req -new -key yourdomain.key -out yourdomain.csr \
  -subj "/C=US/ST=NC/L=Raleigh/O=Your Company, Inc./OU=IT/CN=yourdomain.com"
# generate a private key and a csr in one step
openssl req -new \
  -newkey rsa:2048 -nodes -keyout yourdomain.key \
  -out yourdomain.csr \
  -subj "/C=US/ST=NC/L=Raleigh/O=Your Company, Inc./OU=IT/CN=yourdomain.com"
# verify the csr to ensure information is correct and the file has not been tampered with
# -noout omits encoded keys
# -verify ensures file has not been modified
openssl req -text -in yourdomain.csr -noout -verify
```

#### openssl: Symmetric Encryption

Note that you should obviously not keep the plain text of the secret message on disk next to the encrypted.

```bash
# encrypt a message and write it to a file
echo "secret number 12345" > plain.txt && \
  openssl enc -aes-256-cbc -base64 -in plain.txt > secret.bin
# decrypt the message and write to a file
openssl enc -aes-256-cbc -d -base64 -in secret.bin > secret.decrypt.txt
```

#### openssl: Asymmetric Encryption with public.key and private.pem
Typically, asymmetric encryption and decryption would be done with 2 parties, exchanging their public.keys.  This allows
each party to use the public.key of the other party to encrypt, send the data, and let the other party decrypt the data
with the associated private.pem.

```bash
# generate a private key
openssl genrsa -out private.pem 2048
# view a private key
# includes both primes, coefficient, modulus, etc
# this is very insightful
openssl  rsa -in private.pem -text
# generate a public key using a private pem
openssl rsa  -in private.pem -pubout -out public.key
# encrypt file using openssl + public.key
echo "secret number 12345" > plain.txt && \
  openssl rsautl -encrypt -in plain.txt -out secret.bin -inkey secret.key -pubin
# decrypt file using openssl + private.pem
 openssl rsautl -decrypt -in secret.bin  -out secret.decrypt.txt -inkey private.pem
```
Sign and verify

```bash
# use the private key to sign a message
openssl rsautl -sign -in plain.txt -out secret.signed.bin -inkey private.pem
# verify the signed message
openssl rsautl -verify -in secret.signed.bin -out secret.signed.verified.txt -inkey public.key -pubin
```

Encrypt the private key

```bash
# don't store a private key on disk in plain text!
# note that the header & footer ---RSA PRIVATE KEY--- text will remain, but the key itself will be encrypted
openssl rsa -in private.pem -des3 -out private.encrypt.pem
```


### passwd

Change the password of a user acct. Sys admins can use passwd to change other user's passwords. The
command can also be used to define how an account's password can be changed, and can be used to expire
a user's acct.

More infomration [here](https://www.computerhope.com/unix/upasswor.htm), including how to reset root password.

Commands altering an acct may require root/sudo.

```bash
passwd                  # chance current user acct password, will be prompted for current, new, new retyped
sudo passwd <user>      # change another user's password, IF you have superuser privileges
passwd -S some_acct     # see the status of this user acct
passwd -d some_acct     # delete the acct
passwd -e some_acct     # expire the acct
passwd -l some_acct     # lock an acct
passwd -u some_acct     # unlock an acct
passwd -n 90 some_acct  # require update in 90 days
passwd -i 10 some_acct  # makes an acct inactive if it exceeds password update requirement by x days
passwd -w 12 some_acct  # set warning days before password will expire for acct
```

### ping

Provides a way to troubleshoot test or debug network connectivity issues.
Pair with `traceroute` for further insights

```bash
ping google.com
# PING google.com (216.58.194.174): 56 data bytes
# 64 bytes from 216.58.194.174: icmp_seq=0 ttl=113 time=79.028 ms
# 64 bytes from 216.58.194.174: icmp_seq=1 ttl=113 time=79.358 ms
```


### ps

Provide information about current running processes, including PIDs. A process, or task, is a currently running or executing instance of a program.  Every running program (process) is given a PID.

```bash
# display info about your processes, and those of other users.
# skips processes without a controlling terminal, unless -x
ps -a
# display info about other users processes
ps -A
# display environment (variables) as well
# does not reflect change in environment after process
ps -E
# display uid, pid, parent pid, time, cmd
ps -f
# display info associated with  user, pid, ppid, pgid, sess,
# jobc, state, tt, time, and command.
ps -j
# display info associated with many keywords, such as
# uid, pid, ppid, flag, cpu, and more....
ps -l
# display info about processes that match a process ID
ps -p <some-id>
ps -p 92185
# display processes belonging to a specific user ID
ps -u 501
#
```


### pwd

Print working directory, displays the full path of the current
working directory

```bash
pwd
# /home/student/projects/foo
```

### rm

Remove file(s).  May be recursive.
Beware, there is no `undelete`, and no trash bin to get
your files back out of!

```bash
rm file.txt
# force delete
# BEWARE!
rm -f file.txt file2.txt file3.txt
# remove directory
rm -r ./dir
# remove multiple directories
rm -r ./dir ./dir2 ./dir3
# INTERACTIVE remove, to ask you "are you sure" for each
rm -ri ./dir
```

### rmdir

Remove empty directory

```bash
rmdir ./dir
rmdir /foo/bar/baz
```

### scp

A command for securely copying files between hosts on a network using ssh for data transfer.

```bash
# download a file from a remote server to local machine
scp user@host:/path/to/file/target/filename ~/path/to/local/destination/filename
scp foo@10.168.169.154:/home/foo/my.tar ~/Desktop/my.tar
scp kubo@10.168.169.154:/home/kubo/config-tar.tar ~/Desktop/kubo-config-tar.tar
# upload a file to a remote server from local machine
scp ~/path/to/local/target kubo@10.168.169.154:/path/to/remote/destination
scp ~/Desktop/my.tar foo@10.168.169.154:/home/foo/my.tar
# transfer file from one remote server to another
scp user1@host1:/path/to/target user2@host2:/path/to/destination
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
# read files. sed processes (then prints) line-by-line
sed "" ./file.txt
cat ./file.txt | sed ""
# the substitute command s
# change occurance of a regex into a new value
sed s/day/night/ < day.txt > night.txt      # (see file output)
sed s/day/night/ day.txt > night.txt        # (see file output)
# alternative delimiter, use any character you want:
sed s_day_night_ day.txt > night.txt        # (see file output)
# from echo (note: only changes the first occurance)
echo "today is a day" | sed s/day/night/
# update a string using & to represent the matched string
sed 's/day/&NOODLES' < day.txt > noodles.txt   # (see file output)
# double the matched string
sed 's/day/& &/' < day.txt > double_day.txt    # (see file output)
# match any line starting with a numerical value & double the replacement
sed 's/[0-9]*/& &/' < file.txt > nums_doubled.txt    # (see file output)
# match any number even if it doesn't start the line & double repalcement
sed 's/[0-9][0-9]*/& &/' nums.txt > nums_doubled_again.txt   # (see file output)
# substitute the beginning of the line with additional spaces
# useful for "tabbing in" a subsequent line of output
echo "hello world" | sed "s|^|  |"
# substituted the end of the line with additional characters.
# not as useful, but perhaps intersting
echo "hello world" | sed "s|$| hi |"
#  hello world hi
#
# using extended regular expressions
# BSD -E works on mac
# GNU -r works on linux
sed -E 's/[0-9]+/& &/' nums.txt > nums_doubled.txt # BSD
sed -r 's/[0-9]+/& &/' nums.txt > nums_doubled.txt # GNU
# some more
# given a "hickory dickory dock..." file called rhyme.txt
# this will change all occurances of "mouse" to "cat"
# and print the lines to the screen, but will not update
# the file in place
sed 's/mouse/cat/' rhyme.txt
# this will do the same change, but will update the file in place
sed -i 's/mouse/cat/' rhyme.txt

```

`sed` has several modes.

`print` mode

```bash
# pass sed the "print" mode
# note that sed already prints, so this will print each line twice
sed 'p' ./file.txt
# suppress the automatic print, then instruct sed to print mode
sed -n 'p' ./file.txt
# only print 1st line
sed -n '1p' ./file.txt
# print 5 lines
sed -n '1,5p' ./file.txt
# print lines with offset
sed -n '1,+4p' ./file.txt
# print every other line
sed -n '1~2p' ./file.txt
```

`delete` mode

```bash
# delete every other line in output
sed '1~2d' ./file.txt
```

`--in-place` flag is important

```bash
# delete every other line, but in the file itself, not in output
sed --in-place '1~2d' ./file.txt
sed -i '1~2d' ./file.txt
# create a backup file while performing instructions
# the -i.bak causes a backup file creation
# this does not work with --in-place
sed -i.bak '1~2d' ./file.txt
```

`substitution` mode

substitutions
`s` is the substitution command, followed by separators:
  `s///`
the text to substitute is between the separators:
sed uses 3 / for substututions:
  `s/old_word/new_word/`
you can swap the separators for any character that makes sense:
here using _ instead of /
  `s_old-word_new-word_`

```bash
echo "sed substitutions...."
# https://www.example.com/index.html -> https://www.example.com/home.html
echo "https://www.example.com/index.html" | sed 's_com/index_org/home_'
```

substitutions works on patterns, not words.

The substitution string is as follows: `s/foo/BAR/` where:
- `s`	  Substitute command
- `/../../`	  Delimiter
- `foo`	  Regular Expression Pattern Search Pattern
- `BAR`	  Replacement string

```bash
# simple replacement, single occurance vs global (per line)
echo "sunday monday tuesday" | sed 's/[a-z]*/(&)/'  # (sunday) monday tuesday
echo "sunday monday tuesday" | sed 's/[a-z]*/(&)/g' # (sunday) (monday) (tuesday)
# catch and match replacements
echo "123 abc" | sed 's/[0-9]*/& &/'
# echo "Sunday Monday Tuesday" | sed 's/[a-z]*/(&)/'
# it ONLY operates on the first match (per line)...
sed 's/on/forward/' build_song.txt          # 3 occurances of "on", but only match 1 is changed
# use the 'g' flag to "globally" (per line) update all matches
sed 's/on/forward/g' build_song.txt         # update all occurances (per line)
# use a specific number to only match a specific occurance
# in this case, only the second occurance (per line)
sed 's/on/forward/2' build_song.txt         # update only the second occurance (per line)
# to only see output for lines actually changed,
# - pass the -n to suppress default printing
# - pass 'p' within the command string to indicate print output of the command (when activated)
sed -n 's/on/forward/2p' build_song.txt
# ignore case by passing the 'i' flag
sed 's/SINGING/saying/i' build_song.txt

# replacing with regex
# a semi-complex example:
# - start at the beginning of the line only
# - stop at the word 'at'
# - if 'at' is found, everything up to and including 'at' will be replaced
sed 's/^.*at/REPLACED/' song.txt
# now do the same, but instead of replacing with word REPLACED,
# we can use the '&' as a reference to matched text and just
# insert it back, but surrounded by parens:
sed 's/^.*at/(&)/' song.txt
#
# increasing complexity
# using this regex:
#    [a-zA-Z0-9][a-zA-Z0-9]*
# we can match a word. using it twice, we can match two words
# then we can "store" these words, and swap them
# by later using \2 and \1 as references
sed 's/\([a-zA-Z0-9][a-zA-Z0-9]*\) \([a-zA-Z0-9][a-zA-Z0-9]*\)/\2 \1/' song.txt # sadly not readable! wrap in a func!
# the same thing, with a better pattern matcher:
sed 's/\([^ ][^ ]*\) \([^ ][^ ]*\)/\2 \1/' song.txt                             # sadly not readable! wrap in a func!
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

### su

`su`bstitute user. Become a super user for a short while.
Prefer `sudo` to `su`.

```bash
# enter a new shell session as super user
su
# ... do things
# exit the super user session
exit
```

### sudo

`su`per `u`ser `do`.  Do a thing, as super user.

```bash
# as super user, perform some command.
sudo some-command
```

### systemctl

A component of `systemd`, `systemctl` is a command toold for managing and monitoring
of the systemd system and service manager.

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

### tee

Read the stdin, and write to both stdout and a file.  This command is named after
the T-splitter in plumbing.

```bash
# output both:
#    stuff and things
#    stuff.txt will include "stuff and things"
echo "stuff and things" | tee -a stuff.txt
# then
# output is 1 stuff.txt
# stuff.txt will include
#   "       1 stuff.txt"
wc -l stuff.txt | tee stuff.txt
       1 stuff.txt
```

### touch

Update a file's timestamp to the current date w/o modification
of the file.  If the file doesn't exist, create an empty file.

```bash
touch foo/bar/baz.txt
```

### tty

Print the name of the terminal in use.
`tty` stands for "teletypewriter". [tty history](https://www.howtogeek.com/428174/what-is-a-tty-on-linux-and-how-to-use-the-tty-command/)
In the 1830s `teleprinters` were developed which could send typed
messages `down the wire`, a phrase we still use in various forms
today, such as `on the wire`.

```bash
tty
# /dev/ttys005
# silent output, but still get an exit code
tty -s
tty -s && echo "In a tty"
```

### traceroute

Traces the path that an Internet Protocal (IP) packet takes to its destination.
Pair with `ping` for further insights.


```bash
ping google.com
# PING google.com (216.58.194.174): 56 data bytes
# 64 bytes from 216.58.194.174: icmp_seq=0 ttl=113 time=79.028 ms
# 64 bytes from 216.58.194.174: icmp_seq=1 ttl=113 time=79.358 ms
traceroute google.com
# traceroute to google.com (216.58.194.174), 64 hops max, 52 byte packets
#  1  192.168.1.254 (192.168.1.254)  3.827 ms  3.492 ms  3.401 ms
#  2  104-185-72-1.lightspeed.rlghnc.sbcglobal.net (104.185.72.1)  7.363 ms  5.005 ms  5.374 ms
#  3  99.173.77.10 (99.173.77.10)  6.360 ms  5.767 ms  5.849 ms
#  4  12.123.138.230 (12.123.138.230)  20.596 ms  24.045 ms  23.463 ms
#  5  wswdc21crs.ip.att.net (12.122.2.190)  17.822 ms  16.400 ms  22.467 ms
#  6  12.122.116.37 (12.122.116.37)  19.920 ms  16.105 ms  14.305 ms
#  7  12.255.11.0 (12.255.11.0)  15.347 ms  23.851 ms  16.958 ms
#  8  108.170.246.34 (108.170.246.34)  16.835 ms
#     108.170.246.49 (108.170.246.49)  26.326 ms
#     108.170.240.98 (108.170.240.98)  21.672 ms
#  9  142.251.49.192 (142.251.49.192)  18.384 ms
#     108.170.246.33 (108.170.246.33)  38.888 ms
#     108.170.240.97 (108.170.240.97)  18.009 ms
# 10  108.170.246.49 (108.170.246.49)  22.898 ms
#     108.170.246.2 (108.170.246.2)  29.321 ms
#     108.170.246.66 (108.170.246.66)  18.831 ms
# 11  142.251.49.192 (142.251.49.192)  16.737 ms  15.666 ms
#     142.251.49.73 (142.251.49.73)  19.766 ms
# 12  142.251.49.207 (142.251.49.207)  34.921 ms
#     142.251.224.217 (142.251.224.217)  89.442 ms
#     72.14.239.235 (72.14.239.235)  79.519 ms
# 13  66.249.94.28 (66.249.94.28)  82.269 ms
#     216.239.58.214 (216.239.58.214)  79.246 ms
#     66.249.94.28 (66.249.94.28)  85.107 ms
# 14  108.170.242.241 (108.170.242.241)  78.898 ms  80.873 ms
#     72.14.239.235 (72.14.239.235)  85.094 ms
# 15  66.249.94.28 (66.249.94.28)  82.557 ms
#     142.250.234.54 (142.250.234.54)  84.088 ms  78.819 ms
# 16  108.170.242.81 (108.170.242.81)  80.464 ms  81.826 ms
#     108.170.242.241 (108.170.242.241)  87.312 ms
# 17  108.170.237.23 (108.170.237.23)  86.384 ms
#     sfo07s13-in-f14.1e100.net (216.58.194.174)  77.604 ms  80.847 ms
```


### tree

Print a tree diagram of a directory

```bash
tree --version
# print all files, including hidden
tree -a
# follow symbolic links
tree -l
# print full file paths
tree -f
tree
# .
# ├── foodir
# │   ├── bardir
# │   │   ├── file.yaml
# │   │   ├── file2.yaml
# │   └── values.yaml
# ├── bazdir
# │   ├── file3.yaml
# └── file4.yaml
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

### w

Provide a quick summary of every user logged into the computer,
what each user is doing, and the load of activities.

```bash
w
# 12:10  up 2 days, 22:33, 7 users, load averages: 2.12 2.34 2.25
# USER           TTY      FROM              LOGIN@  IDLE WHAT
# samgamgee      console  -                Mon13   2days -
# samgamgee      s004     -                11:17      52 -zsh
# samgamgee      s000     -                Tue10   25:41 /usr/bin/ssh vagrant@127.0.0.1 -p 2200 -o
# samgamgee      s001     -                Wed16   14:03 -zsh
# samgamgee      s002     -                Wed22    3:19 -zsh
# samgamgee      s003     -                 8:50      17 -zsh
# samgamgee      s005     -                11:35       - w

```

### who

Get information about current logged in users on the system.


```bash
who
# samgamgee      console  Jul 26 13:37
# samgamgee      ttys000  Jul 27 10:22
# samgamgee      ttys001  Jul 28 16:32
# samgamgee      ttys002  Jul 28 22:06
# samgamgee      ttys003  Jul 29 08:50
# samgamgee      ttys004  Jul 29 11:17
# samgamgee      ttys005  Jul 29 11:35
# add headings
who -H
# show all details of current logged in user
who -a
who -a -H
# display host name and user associated with stdin (such as keyboard)
who -m -H
# USER           LINE     WHEN
# sangamgee      ttys005  Jul 29 11:35
# list users logged in
who -u
# list dead process details
who -d -H
```

### whoami

Display system's username

```bash
whoami
# samgamgee
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
# substitute precisely "n" items into a following command.  here -n is 1 item:
echo 1 2 3 4 | xargs -n1 -I {} echo "the number: {} before the next."
#  the number: 1 before the next.
#  the number: 2 before the next.
#  the number: 3 before the next.
#  the number: 4 before the next.
# prefix some text before and after each output:
ls -la | xargs -I {} echo "line is: {} > hello world"
#  line is: total 128 > hello world
#  line is: drwxr-xr-x@ 17 user grou 544 Feb 26 16:59 . > hello world
#  line is: -rw-r--r--@ 1 petersenbe staff 15870 Feb 26 16:59 README.md > hello world
# pass a script to xargs in quotes to do multiline things
# this will get a list of pods names only, pass them to xargs as an argument and
# one-by-one run a df command against the /some-dir to check the volume usage for each pod.
kubectl get pods \
  -n default \
  --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' \
  | xargs -n1 -I {} bash -c "echo \"{}: \" && kubectl exec {} -n default -c container-name -- df -ah /some-dir | sed \"s|^|  |\"" \
```

### yq

`yq` is a tool that takes `yaml` input and converts it to `json`
then pipes it to `jq` (and optionally converts it back to `yaml`).

- https://kislyuk.github.io/yq/
- https://mikefarah.gitbook.io/yq/

```bash
# just print the yaml, in color
yq e people.yaml
# evaluate a "find" string against a file
yq e '.people.groups[0].name' people.yaml
# employees
# generate a new yaml file to stdin
yq e -n '.people.groups[0].name = "employees"'
# people:
#   groups:
#     - name: cats
# update the contents of a yaml file directly
yq e '.people.groups[0].name = "ex-employees"' -i people.yaml
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

format a json file locally by invoking python:

```bash
# read file into variable, format data, write data back to the file
# there are many ways to accomplish this type of action
data=$(<$HOME/.secrets/some-secret-text.txt); echo $data | python -m json.tool > $HOME/.secrets/some-secret-text.txt
```


## Notes

To use home made scripts, it is recommended to put them in `~/bin`, as this is fairly standard
across Linux distros.  Then, just double check that it is in your `$PATH` via `echo $PATH`, and
`export PATH=$PATH:~/bin` or add it via your `.bash_profile`.

## Examples

TODO: need to split this out && clean up the current /snippets, etc folders.

There are great examples of best practices if you look carefully.  There are tons of terrible examples as well :)

A nice, short file example from [Docker docs](https://docs.docker.com/config/containers/multi-service_container/):

```bash
#!/bin/bash

# Start the first process
./my_first_process -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# Start the second process
./my_second_process -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep my_first_process |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep my_second_process |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done
```
