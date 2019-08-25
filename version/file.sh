#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mainstart() {
echo ""
echo "💬  Pulling Update Files - Please Wait"
file="/pg/install/place.holder"
waitvar=0
while [ "$waitvar" == "0" ]; do
	sleep .5
	if [ -e "$file" ]; then waitvar=1; fi
done

rm -rf /pg/tmp/version.temp
touch /pg/tmp/version.temp

num=0
while read p; do
  echo -n $p >> /pg/tmp/version.temp
  echo -n " - " >> /pg/tmp/version.temp
  num=$[num+1]
  if [ "$num" == 7 ]; then
    num=0
    echo "  " >> /pg/var/program.temp
  fi
done </pg/install/versions.sh

versionlist=$(cat /pg/tmp/version.temp)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  PG Update Interface | Current PG Version: $pgnumber
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Need More Info? Visit > versions.pgblitz.com

EOF

echo "${versionlist}"

tee <<-EOF

Quitting? TYPE > exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

break=no
read -p '🌍  TYPE a PG Version | PRESS ENTER: ' typed
storage=$(grep $typed /pg/install/versions.sh)

parttwo
}

parttwo() {
if [[ "$typed" == "exit" || "$typed" == "EXIT" || "$typed" == "Exit" ]]; then
  echo ""; touch /pg/var/exited.upgrade; exit; fi

if [ "$storage" != "" ]; then
  break=yes
  echo $storage > /pg/var/pg.number
  ansible-playbook /pg/pgblitz/menu/version/choice.yml

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  SYSTEM MESSAGE: Installing Verison - $typed - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2
touch /pg/var/new.install

file="/pg/var/community.app"
if [ -e "$file" ]; then rm -rf /pg/var/community.app; fi

touch /pg/var/first.update
exit
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  SYSTEM MESSAGE: Version $typed does not exist! - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 2
  mainstart
fi
}

rm -rf /pg/pgstage
mkdir -p /pg/pgstage
ansible-playbook /pg/pgblitz/menu/pgstage/pgstage.yml #&>/de v/null &
mainstart
