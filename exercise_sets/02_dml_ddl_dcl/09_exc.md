Does the following statement use the DDL or DML component of SQL?

DROP DATABASE xyzzy;

==

ddl

LS:
This one is a bit ambiguous. Depending on how you look at DROP DATABASE,
you can say it is part of the DML, part of the DDL, or both.

DROP DATABASE removes all data from the database, including any and
all tables in the database. In this respect, it manipulates data,
so it is considered part of the DML sublanguage.

However, DROP DATABASE also deletes everything about the structure
of the database and its tables. Furthermore, all variants of the
DROP statement are generally treated as DDL. In these respects,
DROP DATABASE manipulates how the data is structured, so it is
considered part of the DDL sublanguage.