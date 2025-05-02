#!/bin/bash
echo "⏳ Loading graph data into Neo4j..."

docker exec -i neo4j-graph cypher-shell -u neo4j -p 'test@123' <<'CYPHER'
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
MERGE (n:BusinessUnit {id: trim(row.`~id`)})
SET
  n.label = trim(row.`~label`),
  n.type = row.type,
  n.community_summary = CASE
    WHEN row.community_summary <> "" THEN row.community_summary
    ELSE NULL
  END,
  n.created = row.created,
  n.updated = row.updated;
CYPHER

docker exec -i neo4j-graph cypher-shell -u neo4j -p 'test@123' <<'CYPHER'
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
MATCH (a:BusinessUnit {id: trim(row.`~from`)})
MATCH (b:BusinessUnit {id: trim(row.`~to`)})
MERGE (a)-[:RELATED_TO {
  label: row.`~label`,
  weight: toInteger(row.weight),
  created: row.created,
  updated: row.updated
}]->(b);
CYPHER

echo "✅ Graph data loaded successfully."
