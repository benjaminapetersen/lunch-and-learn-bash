#!/bin/bash

VAR1="foo"
VAR2="baz"

if [ $VAR1 = 'foo' ]; then
	echo "Yup, its foo: $VAR1"
fi


if [ "$VAR1" = "$VAR2" ]; then
	echo "They are equivalent, $VAR1 is the same as $VAR2"
else
 echo "Nope, $VAR1 is not the same as $VAR2"
fi


if [ "$VAR1" -le 4 ]; then
  # do things
elif [ "$VAR2" -le 8 ]; then
	# do other things
else
  # finally, do this other thing
fi


if [ "$menu" == "fish" ]; then
  if [ "$animal" == "penguin" ]; then
    echo "Hmmmmmm fish... Tux happy!"
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweetpeettreetppeterdepweet!"
  else
    echo "*prrrrrrrt*"
  fi
else
  if [ "$animal" == "penguin" ]; then
    echo "Tux don't like that.  Tux wants fish!"
    exit 1
  elif [ "$animal" == "dolphin" ]; then
    echo "Pweepwishpeeterdepweet!"
    exit 2
  else
    echo "Will you read this sign?!"
    exit 3
  fi
fi
