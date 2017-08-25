# Regex

A list of examples of regex, documenting quirks, useful snippets, etc.

- [The Grymoire](http://www.grymoire.com/Unix/Regular.html) has been
  a useful resource.
- [The -r Extended Regex Arg](http://www.grymoire.com/Unix/Sed.html#uh-62k)
  There are two classes of regex, the original "basic", and "extended".
  - Note that BSD & GNU have different flags (unfortunately)


```bash
# match zero or more numbers
[0-9]*
# match one or more numbers
[0-9][0-9]*
[0-9]+   # + is a meta character

```
