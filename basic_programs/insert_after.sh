# https://stackoverflow.com/questions/13316437/insert-lines-in-a-file-starting-from-a-specific-line
# usage:
# $ cat foo.txt
# Now is the time for all good men to come to the aid of their party.
# The quick brown fox jumps over a lazy dog.
# $ insertAfter foo.txt \
#    "Now is the time for all good men to come to the aid of their party." \
#    "The previous line is missing 'bjkquvxz.'"
# $ cat foo.txt
# Now is the time for all good men to come to the aid of their party.
# The previous line is missing 'bjkquvxz.'
# The quick brown fox jumps over a lazy dog.
# $
function insertAfter # file line newText
{
   local file="$1" line="$2" newText="$3"
   sed -i -e "/^$line$/a"$'\\\n'"$newText"$'\n' "$file"
}