#!/usr/bin/perl -w

use strict;

my $HOMEDIR = `pwd`;
chomp ($HOMEDIR);

my $SRC = $HOMEDIR . "/src/main/java";
my $TARGET = $HOMEDIR . "/target";
my $JAVA = "java";
my $JAVA_OPTS = "";
my $CLASSPATH = configureClasspath(qw/antlr-2.7.6.jar commons-collections-3.1.jar dom4j-1.6.1.jar hsqldb.jar javassist-3.9.0.GA.jar jta-1.1.jar slf4j-api-1.5.8.jar/);

my %commands = (
		'jdbc' => "org.terracotta.tutorial.JDBCTest"
	       );

my $command = parseArgs(@ARGV);

print usage() and exit(1) unless $command;

print "my command: $command\n";

if ($commands{$command}) {
  runJava($commands{$command});
} else  {
  print usage() and exit(1);
}

sub runJava {
  my ($class) = @_;
  my $cmd = "$JAVA $JAVA_OPTS -cp $CLASSPATH $class";
  print "executing $cmd...\n";
  print `$cmd`;
}

sub parseArgs {
  my $rv = "";
  if (scalar @_) {
    $rv = $_[0];
  }
  return $rv;
}

sub configureClasspath {
    my @jarnames = @_;
    my @jars = ();
    my $CLASSPATH = "";
    
    foreach (@jarnames) {
	push @jars, "lib/" . $_;
    }
    push @jars, "target/";
    return join (':', @jars);
    
}

sub usage {
  return "\nrun.pl -- run stuff\n\nUsage:\n\trun.pl <command>\n\nCommands:\n\tjdbc\tRuns a JDBC connection test to the hsqldb.\n\n";
}
