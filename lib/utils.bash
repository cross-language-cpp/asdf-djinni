#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for djinni.
GH_REPO="https://github.com/cross-language-cpp/djinni-generator"

fail() {
  echo -e "asdf-djinni: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if djinni is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"

  url="$GH_REPO/releases/download/v${version}/djinni"

  echo "* Downloading djinni release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"
  local bin_install_path="$install_path/bin"

  if [ "$install_type" != "version" ]; then
    fail "asdf-djinni supports release installs only"
  fi


  local release_file="$bin_install_path/djinni"
  (
    mkdir -p "$bin_install_path"
    download_release "$version" "$release_file"

    test -f "$release_file" || fail "Expected $release_file to exist."
    chmod a+x $release_file
    test -x "$release_file" || fail "Expected $release_file to be executable."

    echo "djinni $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing djinni $version."
  )
}
