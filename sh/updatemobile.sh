#!/bin/bash

BACKUP="/root/backup"
ctime=`date +%Y-%m-%s_%H:%M:%S`
. /etc/init.d/functions

applist="oa cg jf dj ms zz"

mobile()
{
    \cp -f  /webapp/oa/WEB-INF/lib/mobile.jar $BACKUP/mobile.jar.${ctime}.old
    backversion=`md5sum $BACKUP/mobile.jar.${ctime}.old | awk '{print $1}'`
    newvesion=`md5sum /root/mobile.jar | awk '{ print $1 }'`
    for app in $applist
    do
        \cp -f /root/mobile.jar  /webapp/${app}/WEB-INF/lib/
        a=`md5sum /webapp/${app}/WEB-INF/lib/mobile.jar | awk '{print $1}'`
        if [[ $a -eq $backversion ]];then
             action "$app mobile.jar update sucessesful"
        else
            failure "$app "


        fi
    done

    mv -f /root/mobile.jar $BACKUP/mobile.jar.${ctime}.new
    
    
}
webservice() 
{
    \cp -f  /webapp/oa/WEB-INF/classess/com/longkey/webservice/webservice.properties  $BACKUP/webservice.properties.${ctime}.old
    backversion=`md5sum $BACKUP/webservice.properties.${ctime}.old |awk '{print $1}'`
    newvesion=`md5sum /root/webservice.properties | awk '{print $1}'` 
    for app in $applist
    do
        \cp -f /root/webservice.properties /webapp/${app}/WEB-INF/classess/com/longkey/webservice/
        a=`md5sum /webapp/${app}/WEB-INF/classess/com/longkey/webservice/webservice.properties | awk '{print $1}'`
        if [[ $a -eq $backversion ]];then
             action "$app mobile.jar update sucessesful"
        else
            failure "$app "
        fi
    done

    mv -f /root/webservice.properties /root/$BACKUP/webservice.properties.${ctime}.new
    
}




case "$1" in 
   
    mob)
        mobile
     ;;
    web)
       webservice
     ;;
    all)
      mobile
      webservice
      ;;
     *)
      echo "Usage: $prog {mob--> mobile  web--> webservice all---> both}"


esac
