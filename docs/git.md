# Git recipes

### Redo a botched commit

```bash
git commit -m "Oops this is messed up"
git reset HEAD~
# now fix
git add ./stuff-and-things.txt
git commit -c ORIG_HEAD # and preserve original commit message
```
