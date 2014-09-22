# Origins Neo4j

Starts and exposes a Neo4j service optimized for the Origins graph including pre-built indexes and constraints.

## Usage

The `--privileged` flag is required to set the `ulimit` when the Neo4j server starts. See http://docs.neo4j.org/chunked/stable/server-installation.html#linux-install for more details.

```
docker run -d --privileged -p 7474:7474 bruth/origins-neo4j
```

Local mount to data directory:

```
docker run -d --privileged -p 7474:7474 -v /path/to/data:/neo4j/data bruth/origins-neo4j
```
