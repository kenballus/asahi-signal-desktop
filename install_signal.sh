#!/bin/sh

set -euo pipefail

if [ ! "$#" -eq "1" ]; then
    echo "Usage: ./install_signal.sh <VERSION>"
    exit 1
fi

if [ -x /usr/bin/sudo ]; then
    SUDO='sudo'
else
    SUDO='doas'
fi

"$SUDO" dnf install g++ npm python make gcc git rpm-build libxcrypt-compat patch ruby-devel pnpm
gem install fpm
dnf clean all
export PATH="$PATH:/home/$(whoami)/bin" USE_SYSTEM_FPM=true SIGNAL_ENV=production

if [ ! -d Signal-Desktop ]; then
    git clone https://github.com/signalapp/Signal-Desktop
fi
cd Signal-Desktop
git pull origin main
git checkout "v$1"
sed -i 's/"deb"$/"rpm"/' package.json

pnpm install
pnpm run clean-transpile
pnpm run generate
pnpm run prepare-beta-build
pnpm run build-linux

cd ..
"$SUDO" dnf install "./Signal-Desktop/release/signal-desktop-$1.aarch64.rpm"
rm -rf Signal-Desktop
