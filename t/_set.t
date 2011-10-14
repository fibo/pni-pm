use strict;
use warnings;
use Test::More tests => 13;
use PNI::Elem;
use PNI::Set;

my $set = PNI::Set->new;

is $set->min, 0, 'default min';
is $set->max, 0, 'default max';

my $elem1 = PNI::Elem->new;
my $elem2 = PNI::Elem->new;
my $elem3 = PNI::Elem->new;
my $elem4 = PNI::Elem->new;

ok $set->add($elem1), 'add';
is_deeply \( $set->list ), \($elem1), 'list';
ok $set->del($elem1), 'del';
is $set->list, 0, 'empty list';

$set->max(1);
$set->add($elem1);
$set->add($elem2);    # should not be added
ok !exists $set->elem->{ $elem2->id }, 'max';

$set->min(1);
$set->del($elem1);    # should not be deleted
ok exists $set->elem->{ $elem1->id }, 'min';

$set->max(0);
$set->add($elem1);
$set->add($elem2);
$set->add($elem3);
is $set->list, 3, 'max=0 is infinity';

my @list1 = sort ( $elem1, $elem2, $elem3 );
my @list2 = sort $set->list;
is_deeply \@list1, \@list2, 'list';

my @ids1 = sort ( $elem1->id, $elem2->id, $elem3->id );
my @ids2 = sort $set->ids;
is_deeply \@ids1, \@ids2, 'ids';

is $set->add($elem4), $elem4, 'add returns its argument';
is $set->del($elem4), $elem4, 'del returns its argument';

