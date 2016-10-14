pkg_origin=jjasghar
pkg_name=jenkins-war
pkg_version=2.9
pkg_maintainer="JJ Asghar <jj@chef.io>"
pkg_license=("Apache 2")
pkg_source=http://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${pkg_version}/${pkg_name}-${pkg_version}.war
pkg_filename=${pkg_name}-${pkg_version}.war
pkg_shasum=ee2fbf2a5fb2bae3bb60ba2cc6ce8667a783cae8d6d5eb2117364c069c1321b6
pkg_deps=(core/coreutils core/jre8 core/gcc-libs core/glibc)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8080)

do_download() {
    # check to see if the file is already there
    if [ ! -f $pkg_filename ]; then
      # grab it if you aren't
      wget $pkg_source
    fi
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
  mkdir $pkg_prefix/deployment
  cp $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix/deployment
  mv -f $pkg_prefix/deployment/$pkg_filename $pkg_prefix/jenkins.war
  # if [ ! -f $pkg_svc_path/deployment ]; then
  #   mkdir $pkg_svc_path/deployment
  # fi
  mv -f $pkg_prefix/jenkins.war $pkg_svc_path/deployment
  chown -R hab:hab $pkg_svc_path/deployment
}
