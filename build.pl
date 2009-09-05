#!/usr/bin/perl -w

use strict;
my $HOMEDIR = `pwd`;
chomp $HOMEDIR;
my $SRC = $HOMEDIR . "/src/main/java";
my $TARGET = $HOMEDIR . "/target";
my $JAVAC = "javac";
my $CLASSPATH = configureClasspath(qw/antlr-2.7.6.jar commons-collections-3.1.jar dom4j-1.6.1.jar hibernate3.jar javassist-3.9.0.GA.jar jta-1.1.jar slf4j-api-1.5.8.jar/);
my $classfiles = `cd $SRC; find . -type f -name '*.java'`;
$classfiles =~ s/\n/ /g;

print "classpath: $CLASSPATH\n";
print "classfiles: $classfiles\n";

if (-e $TARGET ) {
 print "$TARGET exists!  Giving up.\n" and exit (1) if (-e $TARGET);
}
mkdir $TARGET;

my $cmd = "cd $SRC; javac -d $TARGET -sourcepath $SRC -cp $CLASSPATH $classfiles";
print "compile command: $cmd\n";
`$cmd`;

sub configureClasspath {
  my @jarnames = @_;
  my @jars = ();
  my $CLASSPATH = "";
  
  foreach (@jarnames) {
    push @jars, "lib/" . $_;
  }
  return join (':', @jars);
}
