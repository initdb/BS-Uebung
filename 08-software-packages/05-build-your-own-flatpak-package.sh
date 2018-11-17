#!/bin/bash

#####################################################
# 8.5 build your own flatpak package                #
#####################################################
# install the freedesktop runtime and SDK
flatpak install flathub org.freedesktop.Platform//18.08 org.freedesktop.Sdk//18.08

cd flatpak-hello || exit 1

# build the application
flatpak-builder build-dir org.flatpak.Hello.json

# test the build
flatpak-builder --run build-dir org.flatpak.Hello.json hello.sh

# put the app in a repository
flatpak-builder --repo=repo --force-clean build-dir org.flatpak.Hello.json

# install the app
flatpak --user remote-add --no-gpg-verify tutorial-repo repo
flatpak --user install tutorial-repo org.flatpak.Hello

# run the app
flatpak run org.flatpak.Hello

# remove the app
flatpak uninstall org.flatpak.Hello