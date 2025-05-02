// Load Nodes
LOAD CSV WITH HEADERS FROM 'file:///nodes.csv' AS row
WITH row
WHERE row.`~id` IS NOT NULL AND row.`~label` IS NOT NULL
MERGE (n:BusinessUnit {id: row.`~id`})
SET
  n.label = row.`~label`,
  n.type = row.type,
  n.community_summary = CASE 
    WHEN row.community_summary <> "" THEN row.community_summary 
    ELSE NULL 
  END,
  n.created = row.created,
  n.updated = row.updated;

// Load Relationships
LOAD CSV WITH HEADERS FROM 'file:///edges.csv' AS row
WITH row
WHERE row.`~from` IS NOT NULL AND row.`~to` IS NOT NULL
MATCH (a:BusinessUnit {id: row.`~from`})
MATCH (b:BusinessUnit {id: row.`~to`})
MERGE (a)-[r:RELATED_TO {
  label: row.`~label`,
  weight: toInteger(row.weight),
  created: row.created,
  updated: row.updated
}]->(b);
