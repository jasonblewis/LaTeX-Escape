use Test::More;


BEGIN { use_ok('Escape::LaTeX') }
#require_ok( 'Some::Module' );

is( escape_latex("\r"), ' ',"replace Ctrl-m with space");

is( escape_latex('%'), '\\%',"escape %");
is( escape_latex('&'), '\\&',"escape &");
is( escape_latex('$'), '\\$','escape $');
is( escape_latex('\\'), '\\\\','escape \\');

is( escape_latex("\xB0"),'\\degree ', 'degree symbol converted to \\degree ');

is( escape_latex("é"),'\\\'{e}', 'e acute');

is( escape_latex("è"),'\\`{e}', 'e grave');

is( escape_latex("ê"),'\\^{e}', 'e circumflex');

is( escape_latex("Smith et al. claim that..."),'Smith et al.\\ claim that...',"avoid extra space after full stop in abbreviations");

is( escape_latex("Pentium III. This"),'Pentium III\@. This',"ensure extra space after sentence that ends in a capital");

is( escape_latex('\'hello\''),'`hello\'',"open single quote converted to backtick");
is( escape_latex('"hello"'),'``hello"',"open double quote converted to double backtick");

is( escape_latex('’'),'\'',"curly apostrophe and closing single quote should be replaecd with normal single quote");

is( escape_latex('apostrophe\'s'),'apostrophe\'s',"apostrphes should not be changed");

is( escape_latex('123-456'),'123--456','minus between numbers should be changed to double minus');
is( escape_latex('but not if its a dash - between words'),'but not if its a dash - between words','minus between words should not be changed to double minus');

is( escape_latex('<latex>LaTeX'),'\\LaTeX',"escape the escape");

done_testing;
