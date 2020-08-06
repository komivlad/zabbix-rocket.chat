#!/bin/bash

# Rocket.Chat incoming web-hook URL and user name
url="https://rocket.biglion.app/hooks/$1"
username='zabbix'
icon_emoji=':grinning:'

LOGFILE="./zabbix-rocketchat.log"

subject="$2"
params="$3"

# set variables from trigger message
host="`echo \"${params}\" | grep 'HOST: ' | awk -F'HOST: ' '{print $2}' | tr -d '\r\n\'`"
trigger_name="`echo \"${params}\" | grep 'TRIGGER_NAME: ' | awk -F'TRIGGER_NAME: ' '{print $2}' | tr -d '\r\n\'`"
trigger_status="`echo \"${params}\" | grep 'TRIGGER_STATUS: ' | awk -F'TRIGGER_STATUS: ' '{print $2}' | tr -d '\r\n\'`"
severity="`echo \"${params}\" | grep 'TRIGGER_SEVERITY: ' | awk -F'TRIGGER_SEVERITY: ' '{print $2}' | tr -d '\r\n\'`"
trigger_url="`echo \"${params}\" | grep 'TRIGGER_URL: ' | awk -F'TRIGGER_URL: ' '{print $2}' | tr -d '\r\n\'`"
datetime="`echo \"${params}\" | grep 'DATETIME: ' | awk -F'DATETIME: ' '{print $2}' | tr -d '\r\n\'`"
item_value="`echo \"${params}\" | grep 'ITEM_VALUE: ' | awk -F'ITEM_VALUE: ' '{print $2}' | tr -d '\r\n\'`"
event_id="`echo \"${params}\" | grep 'EVENT_ID: ' | awk -F'EVENT_ID: ' '{print $2}' | tr -d '\r\n\'`"
item_id="`echo \"${params}\" | grep 'ITEM_ID: ' | awk -F'ITEM_ID: ' '{print $2}' | tr -d '\r\n\'`"
msg="`echo \"${params}\" | grep 'TRIGGER_DESCRIPTION: ' | awk -F'TRIGGER_DESCRIPTION: ' '{print $2}' | tr -d '\r\n\'`"

# set color from trigger severity
if [[ "$severity" == 'Information' ]]; then
	color='#7499FF'
elif [ "$severity" == 'Warning' ]; then
	color='#FFC859'
elif [ "$severity" == 'Average' ]; then
        color='#FFA059'
elif [ "$severity" == 'High' ]; then
        color='#E97659'
elif [ "$severity" == 'Disaster' ]; then
        color='#E45959'
else
	color='#97AAB3'
fi

# set imoji icon from trigger severity
if [[ "$subject" == *"OK"* ]]; then
        icon_emoji=':grinning:'
elif  [[ "$subject" == *"UPDATE"* ]]; then
        icon_emoji=':warning:'
elif  [[ "$subject" == *"PROBLEM"* ]]; then
        icon_emoji=':slight_frown:'
fi

# Build our JSON payload and send it as a POST request to the Mattermost incoming web-hook URL
payload='{"username":"'$username'","emoji":"'$icon_emoji'","attachments":[{"color":"'${color}'","title":"'${subject}'","text":"'${msg}'","fields": [{"short": true, "title": "Важность","value": "'${severity}'"},{"short": true,"title": "Значение",	"value": "'${item_value}'"}]}]}'

# Send Payload to the Rocket.Chat Server
curl -X POST -H 'Content-Type: application/json' --data "${payload}" $url

# Write errors to log
echo "curl -X POST -H 'Content-Type: application/json' --data '${payload}' $url" 2>>${LOGFILE}
