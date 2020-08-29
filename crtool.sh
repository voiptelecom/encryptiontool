#!/bin/bash
clear
echo
echo
echo
echo "===================BY WWW.AJTEL.NET==================================";
echo "                                                                      ";
echo "	   /\      _   _______   ___    			            ";
echo "	  /  \    | |  |_  __| ||____| | |	 			    ";
echo "	 / /\ \   | |    | |   ||___   | |				    ";
echo "	/ /--\ \  |_|    | |   ||___|  | |                                  ";
echo "	_/    \ \_/ |    | |   |_____  | |____  			    ";
echo "	         |  |    |_|   |_____| |______|                             ";
echo "	         |__/                                                       ";
echo "    LICENSED BY AJTEL COMMUNICATIONS NETWORK GROUP LLC.               ";
echo "======================= AJTEL VOIP SYSTEM FOR LINUX =================";
echo

sleep 3echo
echo '----------- Install CRTOOL ----------'
echo
sleep 1
cd /home
wget https://github.com/ajtel/crtool/blob/master/crtool.tar.gz
tar xzvf crtool.tar.gz

echo '----------- Install Cron for CRTOOL ----------'
if [ ${DIST} = "DEBIAN" ]; then
    CRONPATH='/var/spool/cron/crontabs/root'
elif [ ${DIST} = "CENTOS" ]; then
    CRONPATH='/var/spool/cron/root'
fi
echo "
* * * * * /bin/sh /home/crtool/verifica.sh
" > $CRONPATH
chmod 600 $CRONPATH
crontab $CRONPATH

echo '----------- Install SIP CONDITIONALS FOR CRTOOL ----------'
echo "
[general]
context=billing
udpbindaddr=0.0.0.0:5060
tcpbindaddr=0.0.0.0:5060
tlsbindaddr=0.0.0.0:5061
tlscipher=ALL
tlsclientmethod=TLSv1
tlsclientmethod=TLSv1_2
tlsclientmethod=TLSv1_3   
encryption=yes
tlscertfile=/etc/pki/tls/certs/camila.crt
tlsprivatekey=/etc/pki/tls/private/camila.key
tlscafile=/etc/pki/tls/certs/camila-root.crt
tcpenable=yes
tlsenable=yes
tlsdontverifyserver=yes
transport=udp,tcp,tls
nat=force_rport,comedia
accept_outofcall_message=yes
context = billing
dtmfmode=RFC2833
disallow=all
allow=g729
allow=g723
allow=opus
allow=g726
allow=ulaw  
allow=alaw  
allow=gsm
allow=h263p
allow=h264
allow=vp8
rtcachefriends=yes
srvlookup=yes
useragent=Ultra Billing SoftSwitch V 7.4.4
allowsubscribe = yes
alwaysauthreject=yes
rtupdate=yes
allowguest=yes
language=es
rtptimeout=60
rtpholdtimeout=300
rtsavesysname=yes
ice_support=yes
rtcp_mux=yes
rtautoclear=yes
ALLOW_SIP_ANON=yes
insecure=port,invite
externip=$hostname
#include sip_ajtel_usertls.conf
" > /etc/asterisk/sip.conf

echo '----------- CRTOOL has been INSTALLED ----------'
