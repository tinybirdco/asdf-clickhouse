#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for clickhouse.
GH_REPO="https://github.com/ClickHouse/ClickHouse"
TOOL_NAME="clickhouse"
TOOL_TEST="clickhouse server --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if clickhouse is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

trim_version_suffix() {
	local version="$1"

	trimmed_lts="${version%-lts}"
	trimmed_prestable="${trimmed_lts%-prestable}"
	trimmed_stable="${trimmed_prestable%-stable}"

	echo "${trimmed_stable}"
}

get_arch() {
	arch=$(uname -m)

	case "$arch" in
	"x86_64" | "amd64")
		echo "amd64"
		;;
	"aarch64" | "arm64")
		echo "arm64"
		;;
	*)
		fail "Unknown architecture: $arch. Aborting."
		;;
	esac
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' | grep --color=never -E 'lts|stable'
}

list_all_versions() {
	list_github_tags
}

download_release_linux() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/v$version/clickhouse-common-static-$(trim_version_suffix "$version")-$(get_arch).tgz"
	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

download_release_mac() {
	local version filename url
	version="$1"
	filename="$2"

	arch=$(get_arch)
	url="$GH_REPO/releases/download/v$version/clickhouse-macos"
	[ "$arch" == "arm64" ] && url+="-aarch64"
	echo "$filename"
	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version_linux() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/usr/bin/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		mv "$install_path/usr/bin/$tool_cmd" "$install_path"
		rm -rf "${install_path:?}/usr" "${install_path:?}/install"

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

install_version_mac() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH/clickhouse-$ASDF_INSTALL_VERSION" "$install_path"
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		chmod +x "$install_path/$tool_cmd-$version"
		test -x "$install_path/$tool_cmd-$version" || fail "Expected $install_path/$tool_cmd-$version to be executable."

		mv "$install_path/$tool_cmd-$version" "$install_path/clickhouse"

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
