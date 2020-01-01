# Maintainer: Zachary Elliott <contact@zell.io>

pkgname=halyard-git
pkgver=1.28.0
pkgrel=1
pkgdesc="A tool for configuring, installing, and updating Spinnaker."
arch=('x86_64')
url='https://github.com/spinnaker/halyard'
license=('Apache')
groups=('spinnaker')
depends=(jdk8-openjdk ca-certificates-utils)
makedepends=(tar)
provides=('halyard')
conflicts=('halyard')
source=("$pkgname-$pkgver::git+https://github.com/spinnaker/halyard.git#tag=version-$pkgver")
md5sums=('SKIP')

prepare() {
	cd "$pkgname-$pkgver"
}

build() {
	cd "$pkgname-$pkgver"
	./gradlew installDist -x test -Prelease.useLastTag=true
}

check() {
	cd "$pkgname-$pkgver"
}

package() {
	cd "$pkgname-$pkgver"

	install -d $pkgdir/usr/lib/halyard/$pkgver
	install -d $pkgdir/usr/bin

	install -Dm 0755 halyard-web/build/install/halyard/bin/hal $pkgdir/usr/lib/halyard/$pkgver/bin/hal
	install -Dm 0755 halyard-web/build/install/halyard/bin/halyard $pkgdir/usr/lib/halyard/$pkgver/bin/halyard

	install -Dm 0644 -t $pkgdir/usr/lib/halyard/$pkgver/config halyard-web/build/install/halyard/config/*.yml
	install -Dm 0644 -t $pkgdir/usr/lib/halyard/$pkgver/lib halyard-web/build/install/halyard/lib/*.jar

	ln -s ../lib/halyard/$pkgver/bin/hal $pkgdir/usr/bin/hal
}
