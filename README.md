# pkgbuild

Collection of personal PKGBUILD scripts for Arch Linux. Packages are stored
under their own branches in the form `package/package-name`.

There is a docker file for building packages:

```
docker build -t pkgbuild-builder -f Dockerfile .
docker run --volume "$(pwd)":/mnt/return_target --rm --env package=$PACKAGE_NAME pkgbuild-builder
```

## Public repo

There is a public repository for this repository.

You can install directly from the built repository by adding

```shell
[xzje]
SigLevel = Required TrustedOnly
Server = https://dist.xz.je/linux/arch/$repo/os/$arch
```

to your `pacman.conf` and importing the public key.
