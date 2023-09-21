[![Actions Status](https://github.com/lizmat/Slangify/actions/workflows/test.yml/badge.svg)](https://github.com/lizmat/Slangify/actions)

NAME
====

Slangify - Provide an easy interface to activating slangs

SYNOPSIS
========

```raku
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
```

DESCRIPTION
===========

The `Slangify` module is a module intended for slang developers.

It abstracts the internals of slang creation and activation so that module developers of slangs have a consistent interface they can work with across current and future versions of the Raku Programming Language.

This module is **only** needed to install a module that provides a slang. And as such, would only need to be specified in the `build-depends` section of the META information.

Note that the absence of a grammar role or an actions role, can be indicated by specifying `Mu`. Sadly, some core ideosyncracies make it currently impossible to indicate no change otherwise.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/Slangify . Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a [small sponsorship](https://github.com/sponsors/lizmat/) would mean a great deal to me!

COPYRIGHT AND LICENSE
=====================

Copyright 2023 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

