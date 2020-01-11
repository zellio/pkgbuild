# Maintainer: Zachary Elliott <contact@zell.io>

pkgname=pdf2laser
pkgver=0.5.1
pkgrel=1
pkgdesc="Tool for printing PDF to an Epilog laser cutter over the network"
arch=('x86_64')
url="https://github.com/zellio/pdf2laser"
license=('GPL3')
depends=('ghostscript')
source=("https://github.com/zellio/${pkgname}/archive/v${pkgver}.tar.gz")
sha256sums=('7433c89720775a2c787b368c89abfb566c46a88e055cece07df2943cf1c7df03')

prepare() {
	cd "$pkgname-$pkgver"
	make -f Makefile.dist autotools
}

build() {
	cd "$pkgname-$pkgver"
	./configure --prefix=/usr --sysconfdir=/etc
	make
}

check() {
	cd "$pkgname-$pkgver"
	make -k check
}

package() {
	cd "$pkgname-$pkgver"
	make DESTDIR="$pkgdir/" install
}
