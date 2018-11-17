#!/bin/bash

#####################################################
# 8.4 flatpak software management                   #
#####################################################
# list all installed flatpak packages
flatpack list

# search for packages containing pdf
flatpak search "pdf"

# install the eu.scarpetta.PDFMixTool package
flatpak install flathub eu.scarpetta.PDFMixTool

# run the programm
flatpak run eu.scarpetta.PDFMixTool

# print information about the package
flatpak info eu.scarpetta.PDFMixTool

# remove the package
flatpak uninstall eu.scarpetta.PDFMixTool