# SplitOrderedCollections.jl

Extend the SplittablesBase interface to OrderedCollections

This is a lightweight package that adds method definitions for 
`amount` and `halve` to `OrderedDict` and `OrderedSet` and `LittleDict`.

Add the package with:

```julia
] add https://github.com/April-Hannah-Lena/SplitOrderedCollections.jl.git
```

Use the package with:

```julia
using OrderedCollections
using SplittablesBase
using SplitOrderedCollections
```

The package conforms with the SplittablesBase Interface. In particular, `halve` for 
`OrderedDict`, `OrderedSet`, `LittleDict` should return the same type as `halve` for
regular `Dict` and `Set` so that code can be general without type instabilities.
