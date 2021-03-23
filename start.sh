#!/bin/sh

set -o errexit
set -o nounset

# filesystem
certs_dir="/certs"
app_dir="/app"

# final cmd components
cmdpart_main="twist web -p tcp:6080 --path=$app_dir"
cmdpart_key=""
cmdpart_crt=""
cmdpart_https=""
cmdpart_others="$@"

key_file="${certs_dir}/${KEY_FILE:-app.key}"
crt_file="${certs_dir}/${CRT_FILE:-app.crt}"
if [[ -f "$key_file" ]] && [[ -f "$crt_file" ]]; then
	echo "Key file found: $key_file."
	echo "Crt file found: $crt_file."
	
	cmdpart_key="-k $key_file"
	cmdpart_crt="-c $crt_file"
	cmdpart_https="--https=6443"
else
	echo "Key file or crt file missing. Default to http only mode..."
fi

cmd="$cmdpart_main $cmdpart_key $cmdpart_crt $cmdpart_https $cmdpart_others"
eval $cmd
