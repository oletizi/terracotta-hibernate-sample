#!/usr/bin/perl -w

use strict;

my $HOMEDIR = `pwd`;
chomp ($HOMEDIR);

my $SRC = $HOMEDIR . "/src/main/java";
my $TARGET = $HOMEDIR . "/target";
my $JAVA = "java";
my $JAVA_OPTS = "";
my $BUILD_JAR = "$TARGET/terracotta-hibernate-sample.jar";
unless (-e $BUILD_JAR) {
  print "The build jar doesn't exist: $BUILD_JAR.  Have you run 'ant dist.jar' yet?\n" and exit(1);
}
my $CLASSPATH = configureClasspath(qw/antlr-2.7.6.jar commons-collections-3.1.jar dom4j-1.6.1.jar ehcache-1.6.2.jar hibernate3.jar hsqldb.jar javassist-3.9.0.GA.jar jta-1.1.jar log4j-1.2.15.jar slf4j-api-1.5.8.jar slf4j-log4j12-1.5.8.jar/);

my %commands = (
		'jdbc' => "org.terracotta.hibernate.sample.JDBCTest",
		'hibernate' => "org.hibernate.tutorial.EventManager"
	       );

my ($command, @args) = parseArgs(@ARGV);

print usage() and exit(1) unless $command;

print "my command: $command\n";

if ($commands{$command}) {
  runJava($command, $commands{$command}, @args);
} else  {
  print usage() and exit(1);
}

sub runJava {
  my ($command, $class, @args) = @_;
  my $argstring = join(' ', @args);
  my $cmd = "$JAVA $JAVA_OPTS -cp $CLASSPATH $class $argstring";
  print "executing $cmd...\n";
  print `$cmd`;
}

sub parseArgs {
  if (scalar @_) {
    return @_;
  } else {
    return ("__UNKNOWN__");
  }
}

sub configureClasspath {
    my @jarnames = @_;
    my @jars = ();
    my $CLASSPATH = "";
    
    foreach (@jarnames) {
	push @jars, "lib/" . $_;
    }
    push @jars, $BUILD_JAR;
    return join (':', @jars);
    
}

sub usage {
  return "\nrun.pl -- run stuff\n\nUsage:\n\trun.pl <command>\n\nCommands:\n\tjdbc\tRuns a JDBC connection test to the hsqldb.\n\n";
}
