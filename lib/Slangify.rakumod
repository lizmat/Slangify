# Interface to activate slangs at compile time inside slang modules

sub EXPORT(
  Mu $grammar  is copy,
  Mu $actions? is copy,
  Mu $legacy-grammar?,
  Mu $legacy-actions?
) {

    # The EXPORT sub that actually does the slanging
    my sub EXPORT() {
        my $LANG := $*LANG;

        unless $LANG.^name.starts-with('Raku::') {
            $grammar := $legacy-grammar unless $legacy-grammar<> =:= Mu;
            $actions := $legacy-actions unless $legacy-actions<> =:= Mu;
        }

        $LANG.define_slang('MAIN',
          $grammar<> =:= Mu
            ?? $LANG.slang_grammar('MAIN')
            !! $LANG.slang_grammar('MAIN').^mixin($grammar<>),
          $actions<> =:= Mu
            ?? $LANG.slang_actions('MAIN')
            !! $LANG.slang_actions('MAIN').^mixin($actions<>)
        );

        BEGIN Map.new
    }

    multi sub postcircumfix:<{ }>(Mu $/, Str:D $key) {
        $/.hash.AT-KEY($key)
    }
    multi sub prefix:<~>(Mu $/) {
        $/.Str
    }

    # Export the EXPORT sub that does the slanging
    Map.new: (
      '&EXPORT'              => &EXPORT,
      '&prefix:<~>'          => &prefix:<~>,
      '&postcircumfix:<{ }>' => &postcircumfix:<{ }>
    )
}

=begin pod

=head1 NAME

Slangify - Provide an easy interface to activating slangs

=head1 SYNOPSIS

=begin code :lang<raku>

# Code of a slang module with only a grammar change
role Foo::Grammar { ... }
use Slangify Foo::Grammar, Mu;

# Code of a slang module with both grammar and actions
role Foo::Grammar { ... }
role Foo::Actions { ... }
use Slangify Foo::Grammar, Foo::Actions;

# Code of a slang module with only an actions change
role Foo::Actions { ... }
use Slangify Mu, Foo::Actions;

# code of a slang module with legacy grammar
role Foo::Grammar { ... }
role Foo::Actions { ... }
role Foo::Grammar::Legacy { ... }
role Foo::Actions::Legacy { ... }
use Slangify Foo::Grammar, Foo::Actions,
  Foo::Grammar::Legacy, Foo::Actions::Legacy;

=end code

=head1 DESCRIPTION

The C<Slangify> module is a module intended for slang developers.

It abstracts the internals of slang creation and activation so that
module developers of slangs have a consistent interface they can work
with across current and future versions of the Raku Programming Language.

This module is B<only> needed to install a module that provides a
slang.  And as such, would only need to be specified in the
C<build-depends> section of the META information.

Note that the absence of a grammar role or an actions role, can be
indicated by specifying C<Mu>.  Sadly, some core ideosyncracies make
it currently impossible to indicate no change otherwise.

If the given grammar / actions can work with both the legacy grammar,
as well as with the new RakuAST based grammar, then no changes are
needed.  If there B<is> a different grammar for the legacy grammar
and/or actions for the legacy grammar, then you can specify these as
the 3rd and 4th argument in the C<use Slangify> statement.

=head1 ADDITIONAL EXPORTS

The C<Slangify> module also exports special candidates for postcircumfix
C<{ }> and for prefix C<~>.  This allows slang developers to remain
closer to original grammar code which is often living in NQP land, e.g.:
C<~$<identifier> eq 'foo'>.  Without these special candidates, slang
developers would need to resort to using NQP ops.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Slangify . Comments and
Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2023 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
