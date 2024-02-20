CREATE KEYSPACE axonops WITH replication = {}  AND durable_writes = true;

CREATE TABLE axonops.metrics5 (
    orgid text,
    metricid int,
    time int,
    value float,
    PRIMARY KEY ((orgid, metricid), time)
) WITH CLUSTERING ORDER BY (time DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': '256'}
    AND cdc = false
    AND comment = '7 days retention for 5 seconds resolution metrics'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 'compaction_window_size': '1', 'compaction_window_unit': 'DAYS', 'max_threshold': '32', 'min_threshold': '4', 'unsafe_aggressive_sstable_expiration': 'true'}
    AND compression = {'chunk_length_in_kb': '8', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 604800
    AND extensions = {}
    AND gc_grace_seconds = 86400
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '2000ms';

CREATE TABLE axonops.metrics60 (
    orgid text,
    metricid int,
    time int,
    value float,
    PRIMARY KEY ((orgid, metricid), time)
) WITH CLUSTERING ORDER BY (time DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': '256'}
    AND cdc = false
    AND comment = '30 days retention for 60 seconds resolution metrics'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 'compaction_window_size': '3', 'compaction_window_unit': 'DAYS', 'max_threshold': '32', 'min_threshold': '4', 'unsafe_aggressive_sstable_expiration': 'true'}
    AND compression = {'chunk_length_in_kb': '8', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 2592000
    AND extensions = {}
    AND gc_grace_seconds = 172800
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '2000ms';

CREATE TABLE axonops.metrics720 (
    orgid text,
    metricid int,
    time int,
    value float,
    PRIMARY KEY ((orgid, metricid), time)
) WITH CLUSTERING ORDER BY (time DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': '256'}
    AND cdc = false
    AND comment = '60 days retention for 720 seconds resolution metrics'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 'compaction_window_size': '6', 'compaction_window_unit': 'DAYS', 'max_threshold': '32', 'min_threshold': '4', 'unsafe_aggressive_sstable_expiration': 'true'}
    AND compression = {'chunk_length_in_kb': '8', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 5184000
    AND extensions = {}
    AND gc_grace_seconds = 14400
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '2000ms';

CREATE TABLE axonops.metrics7200 (
    orgid text,
    metricid int,
    time int,
    value float,
    PRIMARY KEY ((orgid, metricid), time)
) WITH CLUSTERING ORDER BY (time DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': '256'}
    AND cdc = false
    AND comment = '180 days retention for 7200 seconds resolution metrics'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 'compaction_window_size': '30', 'compaction_window_unit': 'DAYS', 'max_threshold': '32', 'min_threshold': '4', 'unsafe_aggressive_sstable_expiration': 'true'}
    AND compression = {'chunk_length_in_kb': '8', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 15552000
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '2000ms';

CREATE TABLE axonops.metrics86400 (
    orgid text,
    metricid int,
    time int,
    value float,
    PRIMARY KEY ((orgid, metricid), time)
) WITH CLUSTERING ORDER BY (time DESC)
    AND additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': '365'}
    AND cdc = false
    AND comment = '365 days retention for 86400seconds resolution metrics'
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.TimeWindowCompactionStrategy', 'compaction_window_size': '60', 'compaction_window_unit': 'DAYS', 'max_threshold': '32', 'min_threshold': '4', 'unsafe_aggressive_sstable_expiration': 'true'}
    AND compression = {'chunk_length_in_kb': '8', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 31536000
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '2000ms';
