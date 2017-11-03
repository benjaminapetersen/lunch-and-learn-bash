#!/bin/bash
#
# FWIW, do not actually do this.  Is bad :)
#
#set -o xtrace


function hello::world() {
  echo "Hello World"
}

# xml::encode takes one
function xml::encode() {
  # TODO: attempt to make this a function that can be called.
}

function xml::decode() {
  # TODO: attempt to make this a function that can be called.
}


HTML="<div> <p>I said, \"Hi!\"</p><p>Then I said, 'Whats up?'</p>"


# example from
# https://stackoverflow.com/questions/12873682/short-way-to-escape-html-in-bash
echo "$HTML" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'

# escaping / encoding:
# 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'
# '
# s/&/\&amp;/g;
# s/</\&lt;/g;
# s/>/\&gt;/g;
# s/"/\&quot;/g;
# s/'"'"'/\&#39;/g
# '
#
# unescaping / decoding:
# 's/\&amp;/&/g; s/\&lt;/</g; s/\&gt;/>/g; s/\&quot;/"/g; s/\&#39;/'"'"'/g'
# '
# s/\&amp;/&/g;
# s/\&lt;/</g;
# s/\&gt;/>/g;
# s/\&quot;/"/g;
# s/\&#39;/'"'"'/g
# '
#


ESCAPED="$(echo "$HTML" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')"

echo "escaped:"
echo "$ESCAPED"

UNESCAPED="$(echo "$ESCAPED" | sed 's/\&amp;/&/g; s/\&lt;/</g; s/\&gt;/>/g; s/\&quot;/"/g; s/\&#39;/'"'"'/g')"

echo "unescaped/decoded:"
echo "$UNESCAPED"

# OUTPUT='$(sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')'
