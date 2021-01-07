#!/bin/sh
set -e
#
# Simple docker build script
#

# Option "-c" (cleanup) will delete ALL containers and images after the build.
CLEANUP=0
while getopts 'c' option
do
  case $option in
    c) CLEANUP=1 ;;
  esac
done

is_macos() {
 case "$(uname -s)" in
  *darwin* ) true ;;
  *Darwin* ) true ;;
  * ) false;;
 esac
}

cleanup() {
  docker rm $(docker ps -aq)
  docker image rm --force $(docker images -f "dangling=true" -q)
}



if is_macos; then
	echo
        echo "Building docker image for platform 'linux/arm64'."
	#docker buildx build --platform linux/arm64,linux/amd64 -t rollwagen/test --push .
	#docker buildx build --platform linux/arm64 . --load
	docker buildx build --platform linux/arm64 .
else
	echo
	echo "Building docker image."
	docker build .
fi

if [ "$CLEANUP" -eq "1" ]; then
	echo "Cleaning up (deleting) unused images and containers."
	cleanup
fi


