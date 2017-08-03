#!/bin/bash

DOCS="$(dirname $(readlink -f $0))"
ROOT="$(dirname ${DOCS})"

CONFIG="${DOCS}/config.ld"
OUT="${DOCS}/api"

cd "${ROOT}"

# Clean old files
rm -rf "${OUT}"
# Create new files
ldoc -c "${CONFIG}" -d "${OUT}" "${ROOT}"

# Create basic index file
INDEX="<html>\n\
<head>\n\
<title>List Items Mod for Minetest</title>\n\
</head>\n\
\n\
<body>\n\
<a href=\"api\">API</a>\n\
</body>\n\
</html>\n"

echo -e "${INDEX}" > "${DOCS}/index.html"
