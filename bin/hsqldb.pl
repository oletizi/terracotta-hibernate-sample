#!/usr/bin/perl -w

use strict;

my $HSQLDB_HOME = "/usr/local/hsqldb";
my $JAVA = "java";
my $JAVA_OPTS = "";
my $CLASSPATH = $HSQLDB_HOME . "/lib/hsqldb.jar";
my $PRIVATE_DB_NAME = "tutorial";
my $PUBLIC_DB_NAME ="tutorial";

my $cmd = "java $JAVA_OPTS -cp $CLASSPATH org.hsqldb.server.Server --database.0 file:data/$PUBLIC_DB_NAME --dbname.0 $PUBLIC_DB_NAME";
print "cmd: $cmd\n";
system($cmd);


