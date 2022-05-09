#!/bin/sh

/app/neo4j-community-4.4.6/bin/neo4j start
sleep 5
/app/sh/change-neo4j-pwr

/app/neo4j-community-4.4.6/bin/neo4j stop
sleep 3