# Combos

Just useful combos of things, CLI one-liners.


## Find combinations

```bash
# find files by a regex name, then find by something within the file
find . -name "*something.in.file.name*" -exec grep -H 'something.within.the.file.with.grep' {} +
# find files by name with regex and print in list
find . -type f -name '_dev-output-ytt*'
# print as non-list
find . -type f -name '_dev-output-ytt*' -print0
```
