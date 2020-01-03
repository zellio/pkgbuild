# Maintainer: Zachary Elliott <contact@zell.io>

pkgname=google-cloud-sdk
pkgver=274.0.1
pkgrel=2
pkgdesc="The Cloud SDK is a set of tools for Google Cloud Platform."
arch=('x86_64')
url='https://cloud.google.com/sdk/'
license=('Apache')
groups=()
depends=(python2 python)
makedepends=()
provides=(appctl bq docker-credential-gcloud gcloud gsutil kubectl)
conflicts=()
backup=()
source=("$pkgname-$pkgver.tar.gz::https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-274.0.1-linux-x86_64.tar.gz")
sha256sums=('a93434e0914194978006a107f69a4ef26c29e4778caf0bc94979dfd6386a6ebb')

build() {
	cd "${srcdir}/${pkgname}"

	msg2 "Building google-cloud-sdk"
	python2 bin/bootstrapping/install.py \
	        --usage-reporting false \
	        --command-completion false \
	        --path-update false \
	        --additional-components appctl bigtable alpha beta kubectl \
	        --quiet >/dev/null

	rm .install/.download .install

	msg2 "Generating man pages"
	bin/gcloud meta generate-help-docs --manpage-dir="help"
}

package() {
	msg2 "Installing core SDK components"
	install --directory --owner=root --group=root --mode=0755 "${pkgdir}/usr/lib"
	cp -R "$pkgname" "$pkgdir/usr/lib/${pkgname}"

	msg2 "Recompile python code"
	python2 -m compileall -q -f -x 'python3|yaml/lib3' -d "/usr/lib/${pkgname}"  "${pkgdir}/usr/lib/${pkgname}/"

	msg2 "Installing shell files"
	install --owner=root --group=root --mode=644 -D "${pkgdir}/usr/lib/${pkgname}/completion.bash.inc" "${pkgdir}/etc/bash_completion.d/google-cloud-sdk"
	install --owner=root --group=root --mode=644 -D "${pkgdir}/usr/lib/${pkgname}/completion.zsh.inc" "${pkgdir}/usr/share/zsh/site-functions/_google-cloud-sdk"

	msg2 "Symlinking applications"
	install --directory --owner=root --group=root --mode=0755 "${pkgdir}/usr/bin"
	for program in appctl bq docker-credential-gcloud gcloud gsutil kubectl; do
		ln -st "${pkgdir}/usr/bin" "/usr/lib/${pkgname}/bin/${program}"
	done
}
