#!/bin/bash

# Script to register with Philips Hue Bridge
# This script waits 30 seconds after you press the link button on your Hue Bridge
# then sends the registration request

# Set your Hue Bridge IP address here
HUE_BRIDGE_IP="192.168.1.151"

# Set your desired app name here
APP_NAME="openhue"

echo "Press the link button on your Hue Bridge now!"
echo "Waiting 30 seconds..."

# Countdown timer
for i in {30..1}
do
   echo -ne "$i seconds remaining...\r"
   sleep 1
done

echo -e "\nSending registration request to Hue Bridge at $HUE_BRIDGE_IP..."

# Make the POST request using curl
response=$(curl -s -X POST "http://$HUE_BRIDGE_IP/api" \
  -H "Content-Type: application/json" \
  -d "{\"devicetype\":\"$APP_NAME\"}")

echo "Response from Hue Bridge:"
echo $response | python -m json.tool

# Check if successful and extract username
if [[ $response == *"success"* ]]; then
  username=$(echo $response | grep -o '"username":"[^"]*' | grep -o '[^"]*$')
  echo ""
  echo "SUCCESS! Your Hue application key is:"
  echo "$username"
  echo ""
  echo "Save this key for future use with your Hue Bridge."
else
  echo ""
  echo "ERROR: Failed to register with Hue Bridge."
  echo "Make sure you pressed the link button and the Bridge IP is correct."
fi

