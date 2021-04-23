
INFO() {
  echo -e "[\e[1;33mINFO \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
SUCC() {
  echo -e "[\e[1;32mSUCC \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}
FAIL() {
  echo -e "[\e[1;31mFAIL \e[0m] [\e[1;35m${COMPONENT}\e[0m] [\e[1;36m$(date '+%F %T')\e[0m] $1"
}

USER_ID=$(ID-U)
case $USER_ID in
     0)
       true
       ;;
     *)
       echo -e "\e[1;31m you should be a root user to perform this script\e[0m"
       exit 1
       ;;
 esac

LOG_FILE=/tmp/roboshop.log
rm -f $LOG_FILE
STAT() {
  case $1 in
  0)
    SUCC "$2"
    ;;
  *)
    FAIL "$2"
    ;;
  esac
}
DOWNLOAD_ARTIFACT() {
  curl -s -o/tmp/${COMPONENT}.zip $1 &>>LOG_FILE
  STAT $? "Artifact Download"
}