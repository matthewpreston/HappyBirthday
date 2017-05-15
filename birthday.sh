#!/bin/bash
# Used to send an email on somebody's birthday. NOTE: remember to change the
# datesFile path to the file that contains the dates and email!
# Optionally, initialize 'me' with your email to get a confirmation email

me=""
datesFile="dates.txt"
today=$(date +'%d_%m')
read -d '' message << EOF
In short: Happy Birthday!

In long: It is Matt who wrote this small automated program to inform you of this
special day. Consider yourself dearly important to me as your birthday is 
currently occupying UofT server database space. To reiterate, have a nice day!

Matt Preston
Website (on how I did it): matthewpreston.github.io
EOF

# Get the dates and emails in a single array, skipping the 1st header line.
# i.e. let i be even, then the ith entry is the date (DD_MM) and the (i+1)th
# entry is the email
info=($(tail -n +2 $datesFile))

# See if someone has a birthday today
for ((i=0; i < ${#info[@]}; i += 2)); do
  if [ $today == ${info[i]} ]; then
    echo "$message" | mail -s "Happy Birthday" ${info[i+1]}
	if [ "$me" != "" ]; then
      echo "$message" | mail -s "Happy Birthday To ${info[i+1]}" $me
	fi
  fi
done
