# Maintainer: Zachary Elliott <contact@zell.io>

pkgname=halyard
pkgver=1.28.0
pkgrel=2
pkgdesc="A tool for configuring, installing, and updating Spinnaker."
arch=('x86_64')
url='https://github.com/spinnaker/halyard'
license=('Apache')
groups=('spinnaker')
depends=(jdk8-openjdk ca-certificates-utils)
makedepends=(tar)
provides=('halyard')
conflicts=('halyard')
backup=("usr/lib/halyard/$pkgver/config/halyard.yml"
        "usr/lib/halyard/$pkgver/config/halyard-user")
source=("$pkgname-$pkgver.tar.gz::https://storage.googleapis.com/spinnaker-artifacts/halyard/$pkgver/debian/halyard.tar.gz"
        'logrotate'
        'sysusers'
        'service')
sha256sums=('3afce7e62f0d5d248989c0c40af093d17d0f47b6fed96786ece637302b50513c'
            '1beeeec3b1d7a6f92a672b8c2233548cb3952042f7802dd0a199305844d9a475'
            '1253c1da37b553e4edc81ccfcb5b13ae0dca8406ed0f86da3ccee66dc82be2ee'
            '3dd03dd55085ae1789f760dbc4013bdf18a6b64bd44aaf458f13246e63f5d5d9')

# prepare() {
#     # cd "$pkgname-$pkgver"
#     tar xvf "$pkgname-$pkgver.tar.gz"
# }

build() {
	cd "$pkgname"
 	# ./gradlew installDist -x test -Prelease.useLastTag=true
}

# check() {
# 	cd "$pkgname"
# }

package() {
	install --directory --owner=root --group=root --mode=0755 $pkgdir/usr/lib/halyard/$pkgver
	install --directory --owner=root --group=root --mode=0755 $pkgdir/usr/bin
    install --directory --owner=root --group=root --mode=0755 $pkgdir/var/log/spinnaker/halyard
    install --directory --owner=root --group=root --mode=0755 $pkgdir/etc/bash_completion.d

	install --owner=root --group=root --mode=0755 -D halyard/bin/hal $pkgdir/usr/lib/halyard/$pkgver/bin/hal
	install --owner=root --group=root --mode=0755 -D halyard/bin/halyard $pkgdir/usr/lib/halyard/$pkgver/bin/halyard
	install --owner=root --group=root --mode=0644 -D halyard/config/halyard.yml $pkgdir/usr/lib/halyard/$pkgver/config/halyard.yml

    install --owner=root --group=root --mode=0644 -D --target-directory=$pkgdir/usr/lib/halyard/$pkgver/lib halyard/lib/*.jar

	ln -s ../lib/halyard/$pkgver/bin/hal $pkgdir/usr/bin/hal
	ln -s ../lib/halyard/$pkgver/bin/halyard $pkgdir/usr/bin/halyard

	install --owner=root --group=root --mode=0644 -D logrotate "$pkgdir"/etc/logrotate.d/halyard
    install --owner=root --group=root --mode=0644 -D sysusers "$pkgdir"/usr/lib/sysusers.d/halyard.conf
    install --owner=root --group=root --mode=0644 -D service "$pkgdir"/usr/lib/systemd/system/halyard.service

    halyard/bin/hal --print-bash-completion > $pkgdir/etc/bash_completion.d/hal

    echo 'halyard' > $pkgdir/usr/lib/halyard/$pkgver/config/halyard-user
}
