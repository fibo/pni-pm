package PNI::Node::Mo;

# use Mo qw[ build ];
#   The following line of code was produced from the previous line by
#   Mo::Inline version 0.27
no warnings;my$M=__PACKAGE__.::;*{$M.Object::new}=sub{bless{@_[1..$#_]},$_[0]};*{$M.import}=sub{import warnings;$^H|=1538;my($P,%e,%o)=caller.::;shift;eval"no Mo::$_",&{$M.$_.::e}($P,\%e,\%o,\@_)for@_;return if$e{M};%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;my$m=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}};$m=$o{$_}->($m,$n,@_)for sort keys%o;*{$P.$n}=$m},%e,);*{$P.$_}=$e{$_}for keys%e;@{$P.ISA}=$M.Object};*{$M.'build::e'}=sub{my($P,$e)=@_;$e->{new}=sub{$c=shift;my$s=bless{@_},$c;my@B;do{@B=($c.::BUILD,@B)}while($c)=@{$c.::ISA};exists&$_&&&$_($s)for@B;$s}};@f=qw[build];use strict;use warnings;

=head1 NAME

PNI::Node::Mo - is a Mo wrapper for PNI nodes

=head1 SYNOPSIS

    package PNI::Node::Foo::Bar;
    use PNI::Node::Mo;
    extends 'PNI::Node';

    sub BUILD {
        my $self = shift;
        $self->in('lead');
        $self->out('gold');
    }

    sub task {
        my $self = shift;
        ...    # turn lead into gold
    }

=head1 DESCRIPTION

PNI::Node::Mo is a wrapper of L<Mo> used to build L<PNI> nodes.

=head1 SEE ALSO

L<Mo>

L<Mo Moo Moose not really stuttering|http://perl-node-interface.blogspot.com/2011/09/mo-moo-moose-not-really-stuttering.html>

=cut

