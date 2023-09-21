# Interface to activate slangs at compile time inside slang modules

sub EXPORT(Mu $grammar, Mu $actions) {

    # The EXPORT sub that actually does the slanging
    my sub EXPORT() {
        my $LANG := $*LANG;
        $LANG.define_slang(
          'MAIN',
          $grammar<> =:= Mu
            ?? $LANG.slang_grammar('MAIN')
            !! $LANG.slang_grammar('MAIN').^mixin($grammar),
          $actions<> =:= Mu
            ?? $LANG.slang_actions('MAIN')
            !! $LANG.slang_actions('MAIN').^mixin($actions)
        );
        BEGIN Map.new
    }

    # Export the EXPORT sub that does the slanging
    Map.new: ('&EXPORT' => &EXPORT)
}

=begin pod

=head1 NAME

Slangify - Provide an easy interface to activating slangs

=head1 SYNOPSIS

=begin code :lang<raku>

# Code of a slang module with only a grammar change
role Grammar { ... }
use Slangify Grammar, Mu;

# Code of a slang module with both grammar and actions
role Grammar { ... }
role Actions { ... }
use Slangify Grammar, Actions;

# Code of a slang module with only an actions change
role Actions { ... }
use Slangify Mu, Actions;

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
