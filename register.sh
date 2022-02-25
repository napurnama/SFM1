dt=$(echo "`date +%D` `date +%T`")
flag=0

read -p "Enter username: " usrname
tempusr=$usrname" "
if ! [[ -z $(cat user.txt | grep -w $tempusr) ]]  #change directory to ./users/user.txt
then
	echo "$dt REGISTER:ERROR User already exists" >> log.txt
	echo "$dt REGISTER:ERROR User already exists" 
	exit 1
fi

echo
read -s -p "Enter password: " passwd
echo

minlen=8
let len=${#passwd}

if [[ "$passwd" == "$usrname" ]]
then 
	flag=1
	echo "$dt REGISTER:ERROR Username and password cannot be the same." >> log.txt
	echo "$dt REGISTER:ERROR Username and password cannot be the same."
fi
if [[ $len -lt $minlen ]]
then
	flag=1
	echo "$dt REGISTER:ERROR Password must be a minimum of 8 characters." >> log.txt
	echo "$dt REGISTER:ERROR Password must be a minimum of 8 characters."
fi
if [[ "$passwd" =~ [^a-zA-Z0-9] ]]
then 
	flag=1
	echo "$dt REGISTER:ERROR Password must only consist of alphanumeric characters." >> log.txt
	echo "$dt REGISTER:ERROR Password must only consist of alphanumeric characters."
fi
if [[ ! "$passwd" =~ [a-z] ]] || [[ ! "$passwd" =~ [A-Z] ]] 
then
	flag=1
	echo "$dt REGISTER:ERROR Password must contain at least 1 uppercase and 1 lowercase character." >> log.txt
	echo "$dt REGISTER:ERROR Password must contain at least 1 uppercase and 1 lowercase character."
fi

if [[ $flag -eq 0 ]]
then
	echo "$dt REGISTER:INFO User $usrname registered successfully." >> log.txt
	echo "$dt REGISTER:INFO User $usrname registered successfully."
	echo "$usrname $passwd" >> user.txt #change directory to ./users/user.txt
fi

