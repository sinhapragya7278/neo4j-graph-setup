// Load Nodes
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
MERGE (n:BusinessUnit {
  id: row.id,
  label: row.label,
  type: row.type,
  community_summary: row.community_summary,
  created: row.created,
  updated: row.updated
});

// Load Relationships
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
MATCH (a:BusinessUnit {id: row.from})
MATCH (b:BusinessUnit {id: row.to})
MERGE (a)-[:RELATED_TO]->(b);
