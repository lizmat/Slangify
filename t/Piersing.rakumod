my role Piersing {
    token identifier {
        <.ident> [ <.apostrophe> <.ident> ]* <[?!]>?
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
