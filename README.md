# SplitOrderedCollections.jl

Extend the SplittablesBase interface to OrderedCollections

This is a lightweight package that adds method definitions for 
`amount` and `halve` to `OrderedDict`, `OrderedSet`, `LittleDict`.
There is also a method for `BitSet` from Julia Base.

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

The package conforms with the SplittablesBase Interface. In particular, 
the methods defined here return the same type as `amount` and `halve` for
regular `Dict` and `Set` so that code can be general without type instabilities. 
