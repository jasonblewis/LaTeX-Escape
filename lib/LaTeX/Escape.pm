use strict;
use warnings;
package LaTeX::Escape;
# ABSTRACT: escape characters from supplied text so they are suitable for passing to LaTeX.

our @ISA = qw(Exporter);
our @EXPORT = qw(escape_latex);

sub escape_latex {
    my $return = $_[0];

    # strip out extraneous Ctrl-M from DOS, replace with space
    $return =~ s/\r/" "/ge;

    # add characters here that should be escaped for latex, %, &, $
    # and \
    $return =~ s/([%&\$\\])/\\$1/g;

    # turn the degree symbol into a degree symbol
    $return =~ s/\xB0/\\degree /g;

    # turn the é into a real é
    $return =~ s/é/\\'{e}/g;

    # turn the è into a real è
    $return =~ s/è/\\`{e}/g;

    # turn the ê into a real ê
    $return =~ s/ê/\\^{e}/g;

    # this looks for abreviations that end in . and escapes the space so
    # the space remains normal size
    # eg: Smith et al. claim that
    #     Smith et al.\ claim that
    $return =~ s/(\.)(\s)([a-z])/$1\\$2$3/g;

    # this looks for captials at the end of a sentence and puts a \@
    # before the .
    $return =~ s/([A-Z])(\.\s[A-Z])/$1\\\@$2/g;

    # Convert incorrect single quotes to correct single quotes and try
    # and ignore apostraphes
    #$return =~ s/(\s)(\')(.*\'*)(\%\W)/$1\%$3$4/g;
    $return =~ s/(^|\s)'(.*?)/$1`$2/g;
    $return =~ s/(^|\s)"(.*?)/$1``$2/g;

    # strip out stupid ’ and replace with '
    $return =~ s/’/'/g;

    # convert - between numbers to -- to make the propper length
    # between numbers
    $return =~ s/(\d+)-(\d+)/$1--$2/g;

    # provide a way to escape the escapes - yes, I know it looks like
    # xml, but its not.
    $return =~ s/<latex>/\\/g;

    # check for funny quotes
    if ($return =~ m/¡¯/) {
      warn "WARNING: $return contains a ¡¯\n";
    }

    return $return;
  }


1;
