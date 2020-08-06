#!/bin/bash

<<<<<<< HEAD
url="https://rocket.chat/hooks/$1"
zabbix_baseurl="https://zabbix"
username='zabbix'
LOGFILE="./zabbix-rocketchat.log"

subject="$2"
params="$3"

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

item_value='`'$item_value'`'
trigger_chart="[$host](${zabbix_baseurl}/history.php?action=showgraph&itemids[]=${item_id})"

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

severity='`'$severity'`'

payload='{"username":"'$username'","text":"'${subject}'" ,"attachments":[{"color":"'${color}'","title":"'${subject}'","text":"'${msg}'","fields": [{"short": true,"title": "History","value": "'${trigger_chart}'"},{"short": true, "title": "Severity","value": "'${severity}'"},{"short": true,"title": "Value", "value": "'${item_value}'"}]}]}'

curl -X POST -H 'Content-Type: application/json' --data "${payload}" $url

echo "curl -X POST -H 'Content-Type: application/json' --data '${payload}' $url" 2>>${LOGFILE}
