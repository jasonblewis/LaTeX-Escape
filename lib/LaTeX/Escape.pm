use strict;
use warnings;
use utf8;

package LaTeX::Escape;

# ABSTRACT: escape characters from supplied text so they are suitable for passing to LaTeX.

use base "Exporter";
our $VERSION = '0.01';

our @EXPORT = qw(escape_latex);

sub escape_latex {
    my ($returnstr) = @_;

    # strip out extraneous Ctrl-M from DOS, replace with space
    $returnstr =~ s/\r/ /g;

    # add characters here that should be escaped for latex, %, &, $
    # and \
    $returnstr =~ s/([%&\$\\])/\\$1/g;

    # turn the degree symbol into a degree symbol
    $returnstr =~ s/°/\\degree /g;

    # turn the é into a real é
    $returnstr =~ s/é/\\'{e}/g;

    # turn the è into a real è
    $returnstr =~ s/è/\\`{e}/g;

    # turn the ê into a real ê
    $returnstr =~ s/ê/\\^{e}/g;

    # this looks for abreviations that end in . and escapes the space so
    # the space remains normal size
    # eg: Smith et al. claim that
    #     Smith et al.\ claim that
    $returnstr =~ s/(\.)(\s)([[:lower:]])/$1\\$2$3/g;

    # this looks for captials at the end of a sentence and puts a \@
    # before the .
    $returnstr =~ s/([[:upper:]])(\.\s[[:upper:]])/$1\\\@$2/g;

    # Convert incorrect single quotes to correct single quotes and try
    # and ignore apostraphes
    #$returnstr =~ s/(\s)(\')(.*\'*)(\%\W)/$1\%$3$4/g;
    $returnstr =~ s/(^|\s)'(.*?)/$1`$2/g;
    $returnstr =~ s/(^|\s)"(.*?)/$1``$2/g;

    # strip out stupid ’ and replace with '
    $returnstr =~ s/’/'/g;

    # convert - between numbers to -- to make the propper length
    # between numbers
    $returnstr =~ s/(\d+)-(\d+)/$1--$2/g;

    # provide a way to escape the escapes - yes, I know it looks like
    # xml, but its not.
    $returnstr =~ s/<latex>/\\/g;

    # check for funny quotes
    if ($returnstr =~ m/¡¯/) {
      warn "WARNING: $returnstr contains a ¡¯\n";
    }

    return $returnstr;
}


1;
