#!/bin/bash

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"
CONFIG="${DOCS}/config.ld"

cd "${ROOT}"

# Clean old files
rm -rf "${DOCS}/api" "${DOCS}/scripts" "${DOCS}/modules"
# Create new files
ldoc -c "${CONFIG}" -d "${DOCS}" -o "api" "${ROOT}"

# Remove "html" extension
if [ -f "${DOCS}/api.html" ]; then
	mv "${DOCS}/api.html" "${DOCS}/api"
fi
