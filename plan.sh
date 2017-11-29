pkg_name=libwebsockets
pkg_origin=mozillareality
pkg_maintainer="Mozilla Mixed Reality <mixreality@mozilla.com>"
pkg_name=jenkins-war
pkg_version=2.92
pkg_license=("Apache 2")
pkg_source=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${pkg_version}/${pkg_name}-${pkg_version}.war
pkg_filename=${pkg_name}-${pkg_version}.war
pkg_shasum=695898a1e8ad118c6fdb86222e0db22c6ca5a589db80b8ef3a91fe081d14b020
pkg_deps=(core/jre8 core/gcc-libs core/glibc core/python)
pkg_build_deps=(core/git core/cacerts)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8080)

git-get() {
    repo=$1
    version=$2

    rm -rf $repo
    git clone https://github.com/$repo $repo

    pushd $repo
    git fetch
    git checkout $version
    git reset --hard $version
    git clean -ffdx
    popd
}

do_prepare() {
  python -m venv "$pkg_prefix"
  source "$pkg_prefix/bin/activate"
}

do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"

  pushd $HAB_CACHE_SRC_PATH

  wget -O $pkg_filename $pkg_source

  # Jenkins backup, fork of artsy/jenkins-backup-s3
  git-get gfodor/jenkins-backup-s3

  popd
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
  cp $HAB_CACHE_SRC_PATH/gfodor/jenkins-backup-s3/backup.py ${pkg_prefix}/bin/backup-s3
  cp $HAB_CACHE_SRC_PATH/gfodor/jenkins-backup-s3/LICENSE ${pkg_prefix}/jenkins-backup-s3.license

  pip install -r $HAB_CACHE_SRC_PATH/gfodor/jenkins-backup-s3/requirements.txt

  cp $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix
  mv -f $pkg_prefix/$pkg_filename $pkg_prefix/jenkins.war
}
