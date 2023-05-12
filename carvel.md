# A Carvel Toolset Reference Sheet

For more info, see the `lunch-and-learn-carvel` repo.

### imgpkg 

[imgpkg](https://carvel.dev/imgpkg/docs/latest/) is a tool that allows users to store a set of arbitrary files as an OCI image. One of the driving use cases is to store Kubernetes configuration (plain YAML, ytt templates, Helm templates, etc.) in OCI registry as an image. [Getting Started](https://carvel.dev/imgpkg/docs/latest/basic-workflow/)

See [Deploying Kubernetes Applications with ytt, kbld, and kapp](https://carvel.dev/blog/deploying-apps-with-ytt-kbld-kapp/)

```bash

```

### kapp

```bash 
# kapp can deploy a simple set of kubernetes files
# an interactive prompt will open and ask the user to verify 
# the expected result (creation of various resources)
# a unique label will be applied, kapp.k14s.io/app: <some-large-value>
# to each related resource in the "app"
kapp deploy -a simple-app -f ./my-app-is-here/  
# list kapp applications
kapp ls
# inspect an app with a tree
kapp inspect -a simple-app --tree
# deploy an app after changes, but start with a diff of the change to 
# the yaml configuration files:
kapp deploy -a simple-app -f config-step-1-minimal/ --diff-changes
# kapp doesn't care where app config comes from.
# pipe in help chart config, for example:
helm template my-chart --values values.yml | kapp deploy -a my-app -f- --yes
```

### kbld 

[kbld](https://carvel.dev/kbld/docs/latest/) (pronounced: kei·bild) seamlessly incorporates image building and image pushing into your development and deployment workflows.

`kbld` seems to provide primary value via `annotations` of `digests` for images in an app.  Images can be referenced by name (`nginx`) or by tag-name pair (`nginx:1.14`) or by `digest` (`nginx@sha256:c398dc3f2...`).  `digest` is not human friendly, but it is immutable. The other references are mutable.

See [Deploying Kubernetes Applications with ytt, kbld, and kapp](https://carvel.dev/blog/deploying-apps-with-ytt-kbld-kapp/)


```bash 
# point kbld to a Deployment, Pod, etc.
# the input file can reference an image: <name>
# and the output will replicate the file with
#  annotations:
#    kbld.k14s.io/images: |  
#      - Values... including <name>@sha256:12345...
kbld -f some-yaml.yml 
# generate a lockfile output that is specifically for the 
# `imgpkg` tool.  see https://carvel.dev/kbld/docs/latest/resolving/#generating-resolution-imgpkg-lock-output
kbld -f input.yml --lock-output /tmp/kbld.lock.yml
```

### kwt

`K`ubernetes `w`orkstation `t`ools.  

```bash
# start kwt's networking tool,
# as an alternative to:
#    kubectl port-forward svc/simple-app 8080:80
# as port forwarding must be redone every time a
# pod is recreated.
sudo -E kwt net start
```

### ytt 


[interactive playground](https://carvel.dev/ytt/#playground)

```bash
# run ytt to process a directory of templates
ytt -f my-app-templates/
# pipe ytt output to kapp to deploy onto a kube cluster
ytt -f my-app-templates/ -v hello_msg="hello world" | \
   kapp deploy -a my-app -c -f- --yes
# using process substitution, pipe ytt output to kapp to 
# deploy.  this variant of the above presevers the ability
# to confirm via the interactive prompt
kapp deploy -a simple-app -c \ 
  -f <(ytt -f my-app-templates/ -v hello_msg="hello world")
# apply an overlay file.
# overlays are useful when a template does NOT provide a variable.
# an overlay can be used to map over an existing value anyway
ytt template \ 
  -f my-app/ \
  -f my-app-overlays/some-overlay.yml \
  -v hello_msg="hello world"
# process some templates with ytt,
#   then build the image with kbld
#   then deploy the images with kapp to your cluster
#   (which will still automatically annotate the @sha256...)
kapp deploy -a simple-app -c \
   -f <(ytt -f config-step-3-build-local/ -v hello_msg=friend | kbld -f-)
# the same flow, but instruct kbld to push the images to a registry
# this is necessary when not doing local dev for real applications
$ kapp deploy -a simple-app -c \
   -f <(ytt -f config-step-4-build-and-push/ \ 
      -v hello_msg=friend \
      -v push_images_repo=docker.io/your-username/your-repo | kbld -f-)
```
