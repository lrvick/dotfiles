#!/bin/bash
profile=$2
mfa_serial=$(aws --profile "$profile" configure get mfa_serial)
cache_file="$HOME/.aws/cache/${profile}-creds.json"

if [ -e "$cache_file" ]; then
	exp="$(cat $cache_file | jq -r '.Expiration' | xargs date +%s -d)"
	now=$(date +%s)
	if [[ "$exp" > "$now" ]]; then
		cat "$cache_file"
	else
		rm "$cache_file"
		aws --profile "${profile}" configure set \
			aws_access_key_id ""
		aws --profile "${profile}" configure set \
			aws_secret_access_key ""
	fi
fi

if [ ! -e "$cache_file" ]; then
	creds=$(pass $1)
	mfa_token=$( \
		echo $(echo "GETPIN" | pinentry-gtk-2) \
			| sed s'/.*D \([0-9]\+\) .*/\1/g' \
	);
	AWS_ACCESS_KEY_ID=$(echo "$creds" | jq -r '.AccessKeyId')
	AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq -r '.SecretAccessKey')
	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	aws sts get-session-token \
		--serial-number "$mfa_serial" \
		--token-code "${mfa_token}" \
	| jq -r '.[] + { Version: 1 }' >> "$cache_file"
	aws --profile "${profile}-role" configure set \
		aws_access_key_id "$(cat $cache_file | jq -r '.AccessKeyId' )"
	aws --profile "${profile}-role" configure set \
		aws_secret_access_key "$(cat $cache_file | jq -r '.SecretAccessKey' )"
	aws --profile "${profile}-role" configure set \
		aws_session_token "$(cat $cache_file | jq -r '.SessionToken' )"
	cat "$cache_file"
	cat "$cache_file"
fi
