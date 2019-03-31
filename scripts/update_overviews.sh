#!/usr/bin/env bash

BASE_DIR="$(realpath $(dirname $0)/..)"

cd "${BASE_DIR}"

for file in $(ls ${BASE_DIR}/overviews/raw/*_radar.dds); do
    target="${BASE_DIR}/overviews/$(basename "${file}" _radar.dds).jpg"
    name="$(basename "${target}" .jpg)"
    echo "Creating $(basename "${target}")"
    convert "${file}" "${target}"
    case "${name}" in
        de_lake|de_mirage)
	    convert -flip "${target}" "${target}"
	    ;;
    esac
    cjpeg -outfile "${target}.bu" "${target}"
    mv "${target}.bu" "${target}"
done