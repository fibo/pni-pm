use strict;
use warnings;
use Test::More tests => 16;

BEGIN {
    use_ok($_)
      or BAIL_OUT(" $_ module does not compile :-(")
      for qw(
      PNI
      PNI::Comment
      PNI::Edge
      PNI::File
      PNI::Finder
      PNI::In
      PNI::Elem
      PNI::Line
      PNI::Node
      PNI::Node::PNI::Root
      PNI::Out
      PNI::Point
      PNI::Rectangle
      PNI::Scenario
      PNI::Set
      PNI::Slot
    );
}

