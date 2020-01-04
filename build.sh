#!/usr/bin/env bash

function main
{
    local package_name="$1"
    docker build --tag pkgbuild-builder:latest --file Dockerfile .
    docker run --volume "$(pwd)":/mnt/return_target --rm --env package="${package_name}" pkgbuild-builder:latest
}

main "$@"
