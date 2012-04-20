use 5.008008008;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    ABSTRACT  => 'Node based visual programming via browser',
    AUTHOR    => 'G. Casati <fibo@cpan.org>',
    EXE_FILES => ['bin/pni'],
    NAME      => 'Perl-Node-Interface',
    PREREQ_PM => {
        'File::Find'            => 0,
        'File::Temp'            => 0,
        'File::Spec::Functions' => 0,
        'JSON::PP'              => 0,
        'List::Util'            => 0,
        'Module::Pluggable'     => 0,
        'Mojolicious'           => 0,
        'Scalar::Util'          => 0,
        'Test::More'            => 0,
        'UNIVERSAL::require'    => 0,
    },
    test         => { TESTS => 't/*.t t/node/*.t' },
    VERSION_FROM => 'lib/PNI.pm',
);
