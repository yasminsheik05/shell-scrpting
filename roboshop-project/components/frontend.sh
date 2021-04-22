#!/bin/bash
INFO() {
  echo -e "[\e[1;33mINFO \e[0m] [\e[1;35mFrontend\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
SUCC() {
  echo -e "[\e[1;32mSUCC \e[0m] [\e[1;35mFrontend\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
FAIL() {
  echo -e "[\e[1;31mFAIL \e[0m] [\e[1;35mFrontend\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
INFO "[\e[1;33msetup frontend component\e[0m]"
INFO  "[\e[1;33mInstalling Nginx\e[0m]"
SUCC "[\e[1;32mInstalled Nginx\e[0m]"
FAIL "[\e[1;31mInstalled Nginx\e[0m]"