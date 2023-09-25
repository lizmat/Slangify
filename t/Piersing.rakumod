my role Piersing {
    token identifier {
        <ident>
        { ~$<ident> }  # just to check it runs ok
        [ <.apostrophe> <.ident> ]*
        <[?!]>?
    }

    token name {
        [
          | <identifier> <morename>*
          | <morename>+
        ]
        <[?!]>?
    }
}

use Slangify Piersing, Mu;

# vim: expandtab shiftwidth=4
