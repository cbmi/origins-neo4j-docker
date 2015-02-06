// User and organization are accounts. ids are strings; user name
// and org name
CREATE CONSTRAINT ON (u:User) ASSERT u.id IS UNIQUE;
CREATE CONSTRAINT ON (o:Organization) ASSERT o.id IS UNIQUE;

// Transactions are accessed directly by id or relative to time.
CREATE INDEX ON :Tx(id);
CREATE INDEX ON :Tx(time);

// Resources and topologies are unique for an account.
CREATE INDEX ON :Resource(id);
CREATE INDEX ON :Topology(id);

// Entities are defined within a resource. The id is persisted across
// revisions for an entity. The uuid is an identifier for each revision.
CREATE INDEX ON :Entity(id);
CREATE INDEX ON :Entity(uuid);

// Links are defined within a topology. The id and uuid have the same
// semantics as entities.
CREATE INDEX ON :Link(id);
CREATE INDEX ON :Link(uuid);
