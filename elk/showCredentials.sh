#!/bin/bash

export AC_WHITE_BOLD="\033[1;37m"
export AC_RESET="\033[0m"

# Define the secret name and namespace
SECRET_NAME="elasticsearch-es-elastic-user"
NAMESPACE="elk"
MAX_ATTEMPTS=30
RETRY_INTERVAL=10

# Wait for secret to exist
attempts=0
while [ $attempts -lt $MAX_ATTEMPTS ]; do
    if kubectl -n $NAMESPACE get secret $SECRET_NAME &>/dev/null; then
        break
    fi

    attempts=$((attempts+1))
    if [ $attempts -lt $MAX_ATTEMPTS ]; then
        sleep $RETRY_INTERVAL
    else
        break
    fi
done

# Get the password
password=$(kubectl -n $NAMESPACE get secret $SECRET_NAME -o=jsonpath='{.data.elastic}' | base64 --decode; echo)

echo -e "Kibana Login: ${AC_WHITE_BOLD}elastic${AC_RESET}"
echo -e "Kibana Password: ${AC_WHITE_BOLD}${password}${AC_RESET}"

