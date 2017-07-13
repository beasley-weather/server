attach 'newPush.db' as toMerge;
BEGIN;
insert into archive select * from toMerge.archive;
COMMIT;
detach toMerge;
