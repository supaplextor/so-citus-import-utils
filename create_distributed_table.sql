SELECT * from master_get_active_worker_nodes() order by node_name asc;

\i so-create.sql 

select * from create_distributed_table('badges', 'id');
select * from create_distributed_table('comments', 'id');
select * from create_distributed_table('posthistory', 'id');
select * from create_distributed_table('postlinks', 'id');
select * from create_distributed_table('posts', 'id');
select * from create_distributed_table('tags', 'id');
select * from create_distributed_table('users', 'id');
select * from create_distributed_table('votes', 'id');
