pkg_name=libwebsockets
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"
pkg_name=jenkins-war
pkg_version=2.92
pkg_license=("Apache 2")
pkg_source=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${pkg_version}/${pkg_name}-${pkg_version}.war
pkg_filename=${pkg_name}-${pkg_version}.war
pkg_shasum=695898a1e8ad118c6fdb86222e0db22c6ca5a589db80b8ef3a91fe081d14b020
pkg_deps=(core/jre8 core/gcc-libs core/glibc)
pkg_build_deps=()
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8080)

do_download() {
  wget -O $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_source
}

do_verify() {
    return 0
}

do_unpack() {
    return 0
}

do_build() {
    return 0
}

do_install() {
  build_line "Copying war file"
  cp $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix
  mv -f $pkg_prefix/$pkg_filename $pkg_prefix/jenkins.war
}
