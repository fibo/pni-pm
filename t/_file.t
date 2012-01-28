use strict;
use File::Spec;
use JSON::PP;
use PNI::File;
use Test::More tests => 4;

my $path = File::Spec->catfile( 't', 'first_file.pni' );
my $file = PNI::File->new( path => $path );
isa_ok $file, 'PNI::File';

local $/;
open my $fh, '<', $path;
my $text    = <$fh>;
my $content = decode_json($text);
close $fh;

$file->read;
is_deeply $file->content, $content, 'read content';

# If path is not provided, defaults to a temporary file with empty content.
my $empty_content = { edges => {}, nodes => {} };
my $file2 = PNI::File->new;
ok $file2->path, 'temporary path';

is_deeply $file2->content, $empty_content, 'default empty content';

