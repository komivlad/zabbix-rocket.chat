# zabbix-rocket.chat
Rocket.Chat zabbix alerts script
Usage:
* Create incoming webhook for alerts.
* Copy script to the alertscript path.
* Create new mediatype Rocket.Chat with params:
>     {ALERT.SENDTO}
>     {ALERT.SUBJECT}
>     {ALERT.MESSAGE}

* Create action with default subject
>     [{TRIGGER.STATUS}] {TRIGGER.NAME}

Default message:
>     HOST: {HOST.NAME}
>     TRIGGER_NAME: {TRIGGER.NAME}
>     TRIGGER_STATUS: {TRIGGER.STATUS}
>     TRIGGER_SEVERITY: {TRIGGER.SEVERITY}
>     DATETIME: {DATE} / {TIME}
>     ITEM_ID: {ITEM.ID1}
>     ITEM_NAME: {ITEM.NAME1}
>     ITEM_KEY: {ITEM.KEY1}
>     ITEM_VALUE: {ITEM.VALUE1}
>     EVENT_ID: {EVENT.ID}
>     TRIGGER_URL: {TRIGGER.URL}
>     TRIGGER_DESCRIPTION: {TRIGGER.DESCRIPTION}
* Set operations 
>     Send message to users: Admin (Zabbix Administrator) via Rocket.Chat
