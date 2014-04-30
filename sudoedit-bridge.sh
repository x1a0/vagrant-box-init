#!/bin/bash

if grep -Fxq "zhangxiao" "$1"; then
  echo "Already disabled sudo auth - do nothing"
else
  echo "zhangxiao ALL=NOPASSWD: ALL" >> "$1"
fi

exit 0;
