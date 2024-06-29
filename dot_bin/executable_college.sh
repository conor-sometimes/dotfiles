#!/usr/bin/env bash
# vim: set ft=sh:
#
# college.sh
#
# Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

# This script opens up my college related sites in my browser.

echo "1) UCD Professional Academy"
echo "2) eCollege"

read -r -p "Enter the number of the site you want to open: " site
case $site in
  1)
    open "https://learn.ucdpa.ie/login/index.php"
    ;;
  2)
    open "https://www.fetchcourses.ie/Hub"
    open "https://ecollege.etbonline.ie/my/"
    ;;
  *)
    echo "Invalid input"
    ;;
esac
