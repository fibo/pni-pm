package PNI::Config;
use PNI::Mo;

use Config::YAML;

# TODO
#
# vedi il perldoc di Config::YAML, metti nel costruttore
#
# config => PNI/Config/default_pni_config.yaml
#
# cosi hai tutti i default di PNI
#
# e output => $PNI_HOME/pni_config.yaml

# ad esempio ci posso mettere la stringa di connessione al db
#
# per ora sarà sempre sqlite ma non è da escludere che un giorno potrò usare Postgres
#
# infatti va benissimo SQLite ma presuppone l' accesso al file
#
# se invece sono9 dietro un bilanciatore, e ho tanti host che rispondono
#
# o gli metto la PNI_HOME in comune via nfs, oppure li faccio puntare direttamente a un db Postgres.
#
#

1;

__END__

=head1 NAME

PNI::Config - uses YAML

=cut


