# Neo4j Knowledge Graph – Docker Setup

This repository contains a Dockerized setup to deploy a Neo4j knowledge graph using CSV files for nodes and relationships.

---ls


## 📦 Project Structure

```
neo4j-kg-docker-setup/
├── docker-compose.yml
├── .env
├── init.cypher
├── import/
│   ├── nodes_1.csv
│   └── edges_1.csv
```

---

## 🛠 Requirements

- Docker installed (locally or on your server)
- Git installed (optional if using ZIP)

---

## 🚀 Steps to Run

```bash
git clone https://github.com/sinhapragya7278/neo4j-kg-docker-setup.git
cd neo4j-kg-docker-setup
docker-compose up -d
```

This will start a Neo4j container with your knowledge graph data loaded from `nodes_1.csv` and `edges_1.csv`.

---

## 🌐 Access Neo4j

- URL: [http://localhost:7474](http://localhost:7474)
- Username: `neo4j`
- Password: from `.env` file (e.g., `Neo4j123`)

---

## 🧠 Query to Visualize the Graph

Paste this in the Neo4j Browser to explore the graph:

```cypher
MATCH (a)-[r]->(b) RETURN a, r, b LIMIT 50;
```

---

## 📩 Questions?

Feel free to raise an issue in this repo or contact [@sinhapragya7278](https://github.com/sinhapragya7278).
