#!/usr/bin/env bash

##
# Download and extract archive. If destination
# directory already exists, do nothing.
#
# @param url Source URL
# @param dest Destination directory
##
function download-sources() {
  local readonly url="${1}"
  local readonly dest="${2}"
  local readonly tmp_arc="__bnchmrk_tmp__"

  if [[ -d "${dest}" ]]; then
    printf "Directory ${dest} already exists. \
Skipping download..."
    return
  fi

  printf "Downloading "${url}" in "${dest}"..."

  cd "/tmp"
  wget -O "${tmp_arc}" "${url}" >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    printf "There has been an error downlading the archive."
    exit 127
  fi
  mkdir -p "${dest}"
  tar xf "${tmp_arc}" -C "${dest}" --strip 1 >/dev/null
  if [[ $? -ne 0 ]]; then
    printf "There has been an error extracting the archive."
    exit 127
  fi
}

##
# Builds PHP
#
# @param src Source files location
# @param dest Installation location
##
function build-php() {
  local readonly src="${1}"
  local readonly dest="${2}"

  if [[ -d "${dest}" ]]; then
    printf "PHP already installed in ${dest}. \
Skipping installation."
    return
  fi

  cd "${src}"
  if [[ ! -f "Makefile" ]]; then

    ./buildconf --force >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      printf "There was an error building the \
configuration file."
      exit 127
    fi

    ./configure \
      --prefix="${dest}" \
      --disable-cgi \
      --disable-ipv6 \
      --disable-all \
      >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      printf "There was an error configuring the build."
      exit 127
    fi
  fi

  make >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    printf "There was an error building sources."
    exit 127
  fi

  make install >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    printf "There was an error installing binaries."
    exit 127
  fi
}

function build-python() {
  local readonly src="${1}"
  local readonly dest="${2}"

  if [[ -d "${dest}" ]]; then
    printf "Python already installed in ${dest}. \
Skipping installation."
    return
  fi

  cd "${src}"
  if [[ ! -f "Makefile" ]]; then
    ./configure --prefix="${dest}" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
      printf "There was an error configuring the build."
      exit 127
    fi
  fi

  make >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    printf "There was an error building sources."
    exit 127
  fi

  make install >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    printf "There was an error installing binaries."
    exit 127
  fi
}

readonly shared_dir="/vagrant"
readonly cache_dir="${shared_dir}/.cache"

readonly php5_ver="5.6.16"
readonly php5_arc="php-${php5_ver}.tar.xz"
readonly php5_url="http://de1.php.net/distributions/\
${php5_arc}"
readonly php5_cache="${cache_dir}/php-${php5_ver}"

readonly php7_ver="7.0.1"
readonly php7_arc="php-${php7_ver}.tar.xz"
readonly php7_url="http://de1.php.net/distributions/\
${php7_arc}"
readonly php7_cache="${cache_dir}/php-${php7_ver}"

readonly python2_ver="2.7.10"
readonly python2_arc="Python-${python2_ver}.tar.xz"
readonly python2_url="https://www.python.org/ftp/python/\
${python2_ver}/${python2_arc}"
readonly python2_cache="${cache_dir}/python-${python2_ver}"

readonly python3_ver="3.5.1"
readonly python3_arc="Python-${python3_ver}.tar.xz"
readonly python3_url="https://www.python.org/ftp/python/\
${python3_ver}/${python3_arc}"
readonly python3_cache="${cache_dir}/python-${python3_ver}"

printf "Updating system..."
apt-get -y update \
  >/dev/null
apt-get -y install \
  build-essential \
  autoconf \
  >/dev/null

[[ ! -d "${cache_dir}" ]] && mkdir "${cache_dir}"

printf "Installing Python 2..."
download-sources "${python2_url}" "${python2_cache}"
build-python "${python2_cache}" "/usr/local/python2"

printf "Installing Python 3..."
download-sources "${python3_url}" "${python3_cache}"
build-python "${python3_cache}" "/usr/local/python3"

printf "Installing PHP 5..."
download-sources "${php5_url}" "${php5_cache}"
build-php "${php5_cache}" "/usr/local/php5"

printf "Installing PHP 7..."
download-sources "${php7_url}" "${php7_cache}"
build-php "${php7_cache}" "/usr/local/php7"
