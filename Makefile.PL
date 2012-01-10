use 5.008008008;
use ExtUtils::MakeMaker;

WriteMakefile
  ABSTRACT_FROM => 'lib/PNI.pm',
  AUTHOR        => 'G. Casati <fibo@cpan.org>',
  NAME          => 'PNI',
  PREREQ_PM     => {
    Carp              => 0,
    Exporter          => 0,
    File::Find        => 0,
    File::Temp        => 0,
    File::Spec        => 0,
    JSON::PP          => 0,
    Module::Pluggable => 0,
    Scalar::Util      => 0,
    Test::More        => 0,
    Time::HiRes       => 0,
  },
  VERSION_FROM => 'lib/PNI.pm',

