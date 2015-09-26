#!/bin/bash

CRYSTAL_VERSION=`cat .crystal-version`

if crenv versions | grep $CRYSTAL_VERSION >/dev/null 2>&1; then
    exit 0
fi

crenv install $CRYSTAL_VERSION
