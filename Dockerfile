FROM dockerfile/java:oracle-java8

MAINTAINER Byron Ruth <b@devel.io>

# Install dependencies
RUN apt-get -qq update

# Temporary working directory to download, unpack and rename server.
WORKDIR /neo4j-tmp

# Download Neo4j
RUN wget --quiet -O neo4j.tar.gz "http://www.neo4j.com/artifact.php?name=neo4j-community-2.2.0-M03-unix.tar.gz"

# Unpack and rename to `neo4j`
RUN tar zxf neo4j.tar.gz && rm neo4j.tar.gz
RUN mv `ls` /neo4j

# Change to neo4j directory and remove temp.
WORKDIR /neo4j

RUN rm -rf /neo4j-tmp

# Uncomment server address to allow for incoming connections.
RUN sed -i "s/#org.neo4j.server.webserver.address/org.neo4j.server.webserver.address/g" conf/neo4j-server.properties

# Entrypoint into running the Neo4j server
# Defined as a separate entrypoint because it requires running as a privileged container
# for setting the session ulimit
ADD schema.cypher /neo4j/
ADD entrypoint.sh /neo4j/
RUN chmod +x /neo4j/entrypoint.sh

EXPOSE 7474

ENTRYPOINT ["/neo4j/entrypoint.sh"]

CMD ["serve"]
