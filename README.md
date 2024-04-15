`experiments` contains old work and miscellaneous prototypes.

`shrub-examples` contains ~hastuc-dibtux's original `neo/src/std` code, as well as some additions from the Aegean team. These are likely out of date and have tangled/misnamed dependencies, but to the extent they still work, they're excellent for learning.

`shrubs` is the canonical directory where we will work on Aegean product.

**Installation**

1. Create a fake ship, mount base, then delete base and replace it with [pkg/arvo](https://github.com/urbit/shrub/tree/develop/pkg/arvo) from the Shrubbery repo.
2. Commit changes, then `|start %neo` and maybe `|link %neo`.
3. Delete `pier/base/neo/src/std` and replace it with this repo's `shrubs`. `|nuke %neo` and `|commit %base`. (For now, you'll nuke neo every time you change a shrub.)
