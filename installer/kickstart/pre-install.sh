#!/bin/sh

set -oue pipefail

DEFAULT_URL="registry.hub.docker.com/panmourovaty/uflinux2:38"

for ARG in `cat /proc/cmdline`; do
    if [[ "${ARG}" =~ ^imageurl= ]]; then
         URL="${ARG#*=}"
    fi
done

URL="${URL:-${DEFAULT_URL}}"

readonly RELEASE="$(sed "2q;d" "/run/install/repo/.discinfo")"
readonly ARCH="$(sed "3q;d" "/run/install/repo/.discinfo")"

cat << EOL > /tmp/ks-urls.txt
ostreecontainer --url="${URL}" --no-signature-verification
url --url="https://download.fedoraproject.org/pub/fedora/linux/development/${RELEASE}/Everything/${ARCH}/os/"
EOL
