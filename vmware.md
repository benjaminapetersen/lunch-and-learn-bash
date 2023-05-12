# Some other VMware specific tools or workflows

For more info, see the `lunch-and-learn-vmware` repo.

#### sheepctl 

Shepherd is a tool for quickly and easily obtaining testbeds.

Web UI
- List pools, instances and locks available for development
    - http://shepherd.run/dashboard/namespace/ben 

Some docs:
- README https://gitlab.eng.vmware.com/shepherd/shepherd/
- User Guide http://docs.shepherd.run/users/User%20Guide.html
- Glossary http://docs.shepherd.run/Glossary.html
- https://gitlab.eng.vmware.com/shepherd/shepherd/-/wikis/2-Testbed-User-Guide/How-to-Deploy-a-Custom-Testbed#step-1-create-your-own-namespace-on-shepherd-dashboard

#### Install and setup `sheepctl`:

```bash
# install sheepctl
brew tap vmware/internal git@gitlab.eng.vmware.com:homebrew/internal.git \ 
  && brew install sheepctl
# target sheperd API
sheepctl target set -n $USER -u shepherd.run
# create a namespace
sheepctl namespace create ben
```

Using `sheepctl` to interact with pools and locks. Locks are `temporary exclusive 
access to an environment`. A lock can also be called a demand.

#### Pools 

A [Pool](http://docs.shepherd.run/users/Pool.html) is a set of pre-created environments
behind the scenes. 

```bash 
# pools just need to exist
# you need to know the name, but other than that you don't need much else from it
sheepctl pool list 
# create a pool.
# a pool requires a file
sheepctl pool create --name <some-name> --file <path-to-lock-file> --maximum 1 --minimum 1
# get and view one of your pools
sheepctl pool get ben-tkgm-pool
# after that, you really need to know about your locks
# you lock an environment for use
sheepctl lock list
# CLAIM an environment from your pool
# but to get one, you do this
# if you have many instances in the pool, it will pick one and lock it
# this will also dump a lock file 
sheepctl pool lock ben-tkgm-pool  --lifetime 3d 
# there was a lifetime, you can update
# provid args to adjust the pool
sheepctl pool update <how-many, etc> --maximum <x> --minimum <y>
sheepctl pool update  ben-tkgm-pool --minimum 1 --maximum 2
sheepctl pool update  ben-tkgm-pool --minimum 1 --maximum 2 --name ben-tkgm-1.3.1-pool
```

Locks

```bash 
# create a lock via a recipe file
sheepctl lock create -f ./path/to/recipe.tkg.1.3.1.json
# create a lock with a recipe "file" as input
sheepctl lock create -f <(echo "{\"recipe\":{\"launcher\":\"vane\",\"fetcher\":\"git\",\"source\":\"git@gitlab.eng.vmware.com:shepherd/terraform-templates.git\",\"symbol\":\"master\",\"data\":{\"path\":\"tkg/vc-testbed\",\"vc-build\":\"ob-15952498\",\"esx-build\":\"ob-15843807\",\"tkg-enabled\":\"true\",\"tkg-version\":\"1.3.0\"},\"meta\":{}}}")
# extend the lifetime of your lock by using hte lockfile and a new lifetime flag
sheepctl lock create -f tkg_vc-testbed_examples_vc-7.0.0-installed-tkg-1.3.1.json --lifetime 8h|3d|5m|etc.
# list the locks
sheepctl lock list 
# get the lock via an ID (lock list will provide IDs)
sheepctl lock get <lock-id>
sheepctl lock get 64fabfa6-6d31-46fa-8c5c-690ae2c187b4
# get the lock file
sheepctl lock get <lock-id> > /tmp/lock.json
sheepctl lock get <lock-id> > ~/Desktop/tkg.1.3.1.lock.json
sheepctl lock get 64fabfa6-6d31-46fa-8c5c-690ae2c187b4 > ~/Desktop/tkg.1.3.1.lock.json
sheepctl lock extend <lock-id> --extension 2d
```

See the [Lunch And Learn VMware](#) Repo for what to do with a TKG environment once you have it setup.