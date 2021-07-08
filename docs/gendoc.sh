#!/bin/bash

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"
CONFIG="${DOCS}/config.ld"

cd "${ROOT}"

# Clean old files
rm -rf "${DOCS}/index.html" "${DOCS}/scripts" "${DOCS}/modules" "${DOCS}/topics"
# Create new files
ldoc -c "${CONFIG}" -d "${DOCS}" "${ROOT}"
