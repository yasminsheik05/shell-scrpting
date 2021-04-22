
INFO() {
  echo -e "[\e[1;33mINFO \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
SUCC() {
  echo -e "[\e[1;32mSUCC \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
FAIL() {
  echo -e "[\e[1;31mFAIL \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}