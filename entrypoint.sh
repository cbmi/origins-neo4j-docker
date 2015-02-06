#!/bin/bash

# Increase number of concurrent files that can be opened
# Neo4j disk optimization: http://docs.neo4j.org/chunked/stable/server-installation.html#linux-install
ulimit -n 65536

# Setup/migrate database
/neo4j/bin/neo4j-shell -path /neo4j/data/graph.db -file /neo4j/schema.cypher > /dev/null

if [ "$AUTH_ENABLED" = '1' ]; then
    auth='true'
else
    auth='false'
fi

# Set the authorization flag
sed -i "s/dbms.security.authorization_enabled=.*/dbms.security.authorization_enabled=$auth/g" conf/neo4j-server.properties

# Server
if [ "$1" = 'serve' ]; then
    /neo4j/bin/neo4j console

# Shell
elif [ "$1" = 'shell' ]; then
    /neo4j/bin/neo4j-shell -path /neo4j/data/graph.db "${@:2}"

# Everything else
else
    "$@"
fi
