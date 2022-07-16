module SplitOrderedCollections

using OrderedCollections
using SplittablesBase
import SplittablesBase: amount, halve
import SplittablesBase.Implementations: firstslot, lastslot, DictView

_testrehash!(xs::OrderedDict) = xs.ndel > 0      && OrderedCollections.rehash!(xs)
_testrehash!(xs::OrderedSet)  = xs.dict.ndel > 0 && OrderedCollections.rehash!(xs.dict)
_testrehash!(xs::LittleDict)  = nothing

DictView(xs::OrderedDict, i::Int, j::Int) = DictView(xs,      i, j, identity)
DictView(xs::LittleDict,  i::Int, j::Int) = DictView(xs,      i, j, identity)
DictView(xs::OrderedSet,  i::Int, j::Int) = DictView(xs.dict, i, j, first)

firstslot(::Union{OrderedDict,OrderedSet,LittleDict}) = 1

lastslot(xs::Union{OrderedDict,LittleDict}) = length(xs.keys)
lastslot(xs::OrderedSet) = length(xs.dict.keys)

function amount(xs::Union{OrderedDict,OrderedSet,LittleDict})
    _testrehash!(xs)
    return lastslot(xs)# - SplittablesBase.firstslot(xs) + 1
end

function halve(xs::Union{OrderedDict,OrderedSet,LittleDict})
    _testrehash!(xs)
    i1 = firstslot(xs)
    i3 = lastslot(xs)
    i2 = i3 ÷ 2
    left = DictView(xs, i1, i2)
    right = DictView(xs, i2 + 1, i3)
    return (left, right)
end

end # module
