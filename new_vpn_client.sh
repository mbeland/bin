#!/bin/bash
# Create new OpenVPN client files
#
# Matt Beland - 10/8/2016
#
usage()
{
cat << EOF
usage: $0 options <common name> 

Create a new OpenVPN config for a client machine.

OPTIONS:
   -h 			Show this message
   -f 			Create single .ovpn file including auth
   -s server	Destination server 
   -p port		Destination port     

EOF
}

CFILE=
SERVER=
PORT=
while getopts ":hfzs:p:" OPTION
do
	case $OPTION in
		h)
			usage
			exit
			;;
		f)
			CFILE=1
			;;
		s)
			SERVER=$OPTARG
			;;
		p)
			PORT=$OPTARG
			;;
		?)
			usage
			exit
			;;
	esac
done
shift $(expr $OPTIND - 1)

# Environment
EASY_RSA_DIR=/etc/easy-rsa
RSA_KEYS_DIR=$EASY_RSA_DIR/keys
KEY_DOWNLOAD_PATH=/home/matt/keys/
if [ -z "$SERVER"]
	then 
	SERVER=odin.rearviewmirror.org
fi
if [ -z "$PORT"]
	then 
	PORT=1194
fi
# Read or prompt for CN
if [ -z "$1" ]
	then 
	echo -n "Enter new client common name (CN): "
	read -e CN
else
	CN=$1
fi

# Exit if CN is undefined
if [ -z "$CN" ]
	then 
	usage
	exit
fi

# Get to the working dir, source vars
cd $EASY_RSA_DIR
source ./vars > /dev/null

# If cert already exists, don't generate a new one
if [ -f $RSA_KEYS_DIR/$CN.crt ] 
	then 
	echo "Reusing existing cert file..."
else
	export EASY_RSA="${EASY_RSA:-.}"
	"$EASY_RSA/pkitool" --batch $CN
fi

# Create file header
echo "##############################################" > /tmp/$CN.ovpn
echo "# Client File for $CN" >> /tmp/$CN.ovpn
echo "##############################################" >> /tmp/$CN.ovpn
echo "client" >> /tmp/$CN.ovpn
echo "dev tun" >> /tmp/$CN.ovpn
echo "proto udp" >> /tmp/$CN.ovpn
echo "remote $SERVER $PORT" >> /tmp/$CN.ovpn
echo "resolv-retry infinite" >> /tmp/$CN.ovpn
echo "nobind" >> /tmp/$CN.ovpn
echo "user nobody" >> /tmp/$CN.ovpn
echo "group nobody" >> /tmp/$CN.ovpn
echo "persist-key" >> /tmp/$CN.ovpn
echo "persist-tun" >> /tmp/$CN.ovpn
echo "mute-replay-warnings" >> /tmp/$CN.ovpn
if [ $CFILE ] # if building single-file config
	then 
	echo "<ca>" >> /tmp/$CN.ovpn
	cat keys/ca.crt >> /tmp/$CN.ovpn
	echo "</ca>" >> /tmp/$CN.ovpn
	echo "<cert>" >> /tmp/$CN.ovpn
	cat keys/$CN.crt >> /tmp/$CN.ovpn
	echo "</cert>" >> /tmp/$CN.ovpn
	echo "<key>" >> /tmp/$CN.ovpn
	cat keys/$CN.key >> /tmp/$CN.ovpn
	echo "</key>" >> /tmp/$CN.ovpn
else # if building multi-file config pkg
	echo "ca ca.crt" >> /tmp/$CN.ovpn
	echo "cert $CN.crt" >> /tmp/$CN.ovpn
	echo "key $CN.key" >> /tmp/$CN.ovpn
fi
echo "ns-cert-type server" >> /tmp/$CN.ovpn
echo "comp-lzo" >> /tmp/$CN.ovpn
echo "verb 1" >> /tmp/$CN.ovpn
echo "mute 20" >> /tmp/$CN.ovpn

# Finished product to download directory
if [ $CFILE ] # single file config
	then 
	mv /tmp/$CN.ovpn $KEY_DOWNLOAD_PATH/$CN.ovpn
else # multi-file config pkg
	zip -jq $KEY_DOWNLOAD_PATH/$CN-`date +%d%m%y`.zip keys/$CN.crt keys/$CN.key keys/ca.crt /tmp/$CN.ovpn
fi
