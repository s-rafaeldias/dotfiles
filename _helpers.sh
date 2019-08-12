#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


echo_error() {
	printf '\n\033[31mERROR:\033[0m %s\n' "$1"
}

echo_warning() {
  printf '\n\033[33mWARNING:\033[0m %s\n' "$1"
}

echo_done() {
  printf '\n\033[32mDONE:\033[0m %s\n' "$1"
}

echo_info() {
  printf '\n\033[36m%s\033[0m\n' "$1"
}
