# Functions in bash

Functions look fairly similar to functions in other programming languages.  
A major difference, however, is that they cannot return values.  Functions
in bash only return their status code.  This makes it trickier to pass
values around between functions.  


```bash
function foo() {
  # all variables in bash are global by default.
  # so this just sets a global var.  boo.
  result='some value'
}

# call the function
foo
# now echo the global var`
echo $result
```

A better way is to use command substitution and local variables.  Store
values in local vars within the fuction. Then, echo the var at the end
of the function.  This `echo` will send the value to `stdout`.  We can
use command substitution to capture the `echo` value and store it.

```bash
function foo() {
  local result='some value'
  echo "$result"
}
result=$(foo)
echo $result
```

The third option is to accept a variable name as an argument to your function,
and then set that var with the desired output of the function.

This seems like a BAD IDEA so we aren't even going to explore it more.

Use the second method. 
