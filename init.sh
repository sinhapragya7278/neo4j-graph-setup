cat > init.sh <<'EOF'
#!/bin/bash
echo ">>> 🟢 init.sh STARTED" >> /var/lib/neo4j/import/init.log

# Wait until Neo4j is ready
until cypher-shell -u neo4j -p 'test@123' "RETURN 1" >> /var/lib/neo4j/import/init.log 2>&1; do
  echo "waiting for Neo4j..." >> /var/lib/neo4j/import/init.log
  sleep 5
done

echo "✅ Connected to Neo4j, running node import..." >> /var/lib/neo4j/import/init.log

# Load nodes
cypher-shell -u neo4j -p 'test@123' <<'CYPHER' >> /var/lib/neo4j/import/init.log 2>&1
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

echo "✅ Nodes loaded. Running edge import..." >> /var/lib/neo4j/import/init.log

# Load edges
cypher-shell -u neo4j -p 'test@123' <<'CYPHER' >> /var/lib/neo4j/import/init.log 2>&1
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

echo ">>> ✅ init.sh COMPLETED" >> /var/lib/neo4j/import/init.log
EOF
