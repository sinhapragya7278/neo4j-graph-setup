FROM neo4j:5.12
ENV NEO4J_AUTH=neo4j/test@123
COPY import /var/lib/neo4j/import
# DO NOT COPY init.sh OR RUN IT
