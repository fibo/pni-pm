package PNI::Mo;
# use Mo 'default import';
#   The following line of code was produced from the previous line by
#   Mo::Inline version 0.26
no warnings;my$M=__PACKAGE__.::;*{$M.Object::new}=sub{bless{@_[1..$#_]},$_[0]};*{$M.import}=sub{import warnings;$^H|=1538;my($P,%e,%o)=caller.::;shift;eval"no Mo::$_",&{$M.$_.::e}($P,\%e,\%o)for@_;%e=(extends,sub{eval"no $_[0]()";@{$P.ISA}=$_[0]},has,sub{my$n=shift;my$m=sub{$#_?$_[0]{$n}=$_[1]:$_[0]{$n}};$m=$o{$_}->($m,$n,@_)for sort keys%o;*{$P.$n}=$m},%e,);*{$P.$_}=$e{$_}for keys%e;@{$P.ISA}=$M.Object};*{$M.'default::e'}=sub{my($P,$e,$o)=@_;$o->{default}=sub{my($m,$n,%a)=@_;$a{default}or return$m;sub{$#_?$m->(@_):!exists$_[0]{$n}?$_[0]{$n}=$a{default}->(@_):$m->(@_)}}};my$i=\&import;*{$M.import}=sub{(@_==2 and not $_[1])?pop@_:@_==1?push@_,grep!/import/,@f:();goto&$i};@f=qw[default import];use strict;use warnings;

1;

=head1 NAME

PNI::Mo - Mo for PNI

=head1 SYNOPSIS

    package PNI::Module;
    use PNI::Mo;

=head1 DESCRIPTION

PNI::Mo is a wrapper of L<Mo> for L<PNI>.

=head1 AUTHOR

G. Casati , E<lt>fibo@cpan.orgE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2009-2011, Gianluca Casati

This program is free software, you can redistribute it and/or modify it
under the same terms of the Artistic License version 2.0.

=cut
