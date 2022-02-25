read -p "Username: " usrnm

dt=$(echo "`date +%D` `date +%T`")

if [[ -z $(cat user.txt | grep "$usrnm ")  ]] #change directory to ./users/user.txt
then 
	echo "$dt LOGIN:ERROR Username $usrnm does not exist."
	exit 1
else
	read -s -p "Password: " psswd
	echo
fi
if [[ -z $(cat user.txt | grep -w "$usrnm $psswd" ) ]] #change directory to ./users/user.txt
then
	echo "$dt LOGIN:ERROR Failed login attempt on user $usrnm." >> log.txt
	echo "$dt LOGIN:ERROR Failed login attempt on user $usrnm." 
	flag=1
else
	echo "$dt LOGIN:INFO User $usrnm logged in." >> log.txt
	echo "$dt LOGIN:INFO User $usrnm logged in."
	flag=0
fi

command=""

filename=$(echo "`date +%F`_$usrnm")

until [[ "$command" = "logout" || $flag != 0 ]]
do
	read command
	if [[ "$command" =~ "dl " ]]
	then
		dwn_amt=$(echo "$command" | awk '{printf "%d",$2}')
		echo $dwn_amt
		n=0
		mkdir "$filename"
		chmod 777 "$filename"
		unzip "$filename.zip"
		amt=$(ls "$filename" | awk 'END{printf "%d",NR}')
		while [[ $n -lt $dwn_amt ]]
		do
			let n=$n+1
			let a=($n+$amt)/10
			let b=($n+$amt)%10
			curl 'https://loremflickr.com/320/240' -o "$filename/PIC_$a$b.jpg"
			echo $n
		done
		zip -P $psswd -r "$filename.zip" "$filename"
		rm -r -f "$filename"
		echo "Download completed."	
	elif [[ "$command" == "att" ]]
	then
		cat log.txt | grep "LOGIN" | grep "$usrnm" | awk 'END {print NR}'
	fi
done

echo "Logged out."
