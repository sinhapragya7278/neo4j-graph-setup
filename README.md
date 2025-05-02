
# 📊 Neo4j Graph Setup via Docker + CSV

This project sets up a **Neo4j knowledge graph** using Docker and loads graph data from CSV files. It's ideal for quick testing, POCs, or handing off to teams like MCP for further integration.

---

## 📁 Folder Structure

```
neo4j-graph-setup/
├── docker-compose.yml       # Spins up Neo4j with plugins and config
├── Dockerfile               # Builds custom Neo4j image (optional use)
├── init.sh                  # (Legacy) Cypher load script, not auto-run
├── load_graph.sh            # ✅ Main script to manually load CSV graph data
├── import/
│   ├── nodes.csv            # Nodes file with `~id`, `~label`, etc.
│   └── edges.csv            # Edges file with `~from`, `~to`, etc.
└── README.md
```

---

## 🚀 Quick Start

### 1. Start the Neo4j container
```bash
docker compose up -d
```

### 2. Load your CSV data into the graph
```bash
./load_graph.sh
```

---

## 🔍 CSV Format

### ✅ `nodes.csv`
| ~id                | ~label        | type           | community_summary | created               | updated               |
|--------------------|---------------|----------------|--------------------|------------------------|------------------------|
| `f9ct89lau6974d3`  | Loans and Credit Lines | business_unit | ...              | 2024-12-14T21:03:38Z | 2024-12-24T03:52:09Z |

### ✅ `edges.csv`
| ~from              | ~to              | ~label    | weight | created               | updated               |
|--------------------|------------------|-----------|--------|------------------------|------------------------|
| `8eg39oz345m8m91` | `v7lurh7vy44689w` | provides  | 1      | 2024-12-15T01:21:26Z | 2024-12-15T01:21:26Z |

---

## 🧪 Query Example

After loading, try this in [Neo4j Browser](http://localhost:7474):

```cypher
MATCH (a:BusinessUnit)-[r:RELATED_TO]->(b:BusinessUnit)
RETURN a, r, b LIMIT 25;
```

🧠 Login:
- Username: `neo4j`
- Password: `test@123`

---

## 🧼 Cleanup

To stop and remove everything:
```bash
docker compose down -v
```

---

## 📦 Git Setup (optional for team use)

```bash
git init
git add .
git commit -m "Initial Neo4j graph setup with Docker and CSV"
git remote add origin https://github.com/YOUR_USERNAME/neo4j-graph-setup.git
git push -u origin main
```

---

## 👨‍💻 Author & Maintainer

**Pragya Sinha**  
Neo4j | Docker | Automation

---

## 📌 Notes
- Don't run `init.sh` automatically — use `load_graph.sh` after container is up
- CSV files must be placed inside the `/import` folder
- If you modify the CSVs, just re-run `./load_graph.sh`