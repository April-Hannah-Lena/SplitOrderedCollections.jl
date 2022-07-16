module SplitOrderedCollections

using OrderedCollections
using SplittablesBase

_testrehash!(xs::OrderedDict) = xs.ndel > 0      && OrderedCollections.rehash!(xs)
_testrehash!(xs::OrderedSet)  = xs.dict.ndel > 0 && OrderedCollections.rehash!(xs.dict)
_testrehash!(xs::LittleDict)  = nothing

SplittablesBase.DictView(xs::OrderedDict, i::Int, j::Int) = SplittablesBase.DictView(xs,      i, j, identity)
SplittablesBase.DictView(xs::LittleDict,  i::Int, j::Int) = SplittablesBase.DictView(xs,      i, j, identity)
SplittablesBase.DictView(xs::Orderedset,  i::Int, j::Int) = SplittablesBase.DictView(xs.dict, i, j, first)

SplittablesBase.firstslot(::Union{OrderedDict,OrderedSet,LittleDict}) = 1

SplittablesBase.lastslot(xs::Union{OrderedDict,LittleDict}) = length(xs.keys)
SplittablesBase.lastslot(xs::OrderedSet) = length(xs.dict.keys)

function SplittablesBase.amount(xs::Union{OrderedDict,OrderedSet,LittleDict})
    _testrehash!(xs)
    return SplittablesBase.lastslot(xs)# - SplittablesBase.firstslot(xs) + 1
end

function SplittablesBase.halve(xs::Union{OrderedDict,OrderedSet,LittleDict})
    _testrehash!(xs)
    i1 = SplittablesBase.firstslot(xs)
    i3 = SplittablesBase.lastslot(xs)
    i2 = i3 ÷ 2
    left = SplittablesBase.DictView(xs, i1, i2)
    right = SplittablesBase.DictView(xs, i2 + 1, i3)
    return (left, right)
end

end # module
