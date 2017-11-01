# Comparison Operators

Comparison operators in bash (sadly) look like dangling flags added to
no command.  

## Integer Comparison

```bash
# -eq is equal to
if [ "$a" -eq "$b" ]

# -ne is not equal to
if [ "$a" -ne "$b" ]

# -gt us greater than
if [ "$a" -gt "$b" ]

# -gte is greater than or equal to
if [ "$a" -gte "$b" ]

# -lt is less than
if [ "$a" -lt "$b" ]

# etc.
# but you can also use more familiar syntax
# with double parens...

(( "$a" < "$b" ))
(( "$a" <= "$b" ))
```


## String Comparison

```bash
# = is equal to
# == is equal to (synonym)
if [ "$a" = "$b" ]
if [ "$a" == "$b" ]

# != is not equal to
if [ "$a" != "$b" ]

# < is less than, in ASCII alpha order
if [[ "$a" < "$b" ]]
# note you must escape it inside a single [] construct!
if [ "$a" \< "$b" ]

# -Z string is null, that is, zero length
if [ -Z "$a" ]

# -n string is not null
if [ -n $a ]


# NOTE: these are not equivalent, even though they appear the same
# just with more explicit syntax:
if [ -n $a ]
if [[ -n "$a" ]]
if [[ -n "${$a}" ]]
# given the following:
a="a sentence"
# this:
[ -n $a ]
# evaluates to [ -n a sentence ] which won't work
# -n grabs 'a' as it's co-arg, and 'sentence' is not valid
# but this:
[[ -n $a ]]
# works.
# point?
# [[ ]] over [ ] always, unless you are really confident in what you are doing.
# "$var" over $var always.
# ${var} over $var always.
# BUT not necessarily ${var} over "$var"
# braces are made to help with issues like $10.   is it the 11th arg, or is it ${1}0?

# NOTE 2:
# one more time on confusing syntax
# what does this mean?
( set -- a b c d e f g h i j k l; echo $1; echo $10; echo ${10} )
# this is hard to digest, but
# echo $10 and echo ${10} bash does the shortest
# so echo $10 is actually echo ${1}0. whatever that means.
# thus they do not match. but you would think they should...
```

Mixing string & arithmetic comparison

Bash is not a strongly typed language.  Therefore, if a variable can be treated
as either a string or an integer, the commands will work.  This is a tad more
confusing than other weakly typed languages, however, given that both strings
and integers have their own set of operators.



```bash
# a & b can be treated as either integers or strings
a=5
b=10

if [ "$a" -ne "$b" ]
then
  echo "$a is not equal to $b (arithemetic comparison)"
fi

if [ "$a" != "$b" ]
then
  echo "$a is not equal to $b (string comparison)"
fi
```
