#!/usr/bin/env perl

use ExtUtils::MakeMaker;

WriteMakefile(

    PREREQ_PM => {

        'Plack'      => 0.9986,
        'PNI'        => 0.31,
        'Test::More' => 0,
        'YAML'       => 0,

    },

);

