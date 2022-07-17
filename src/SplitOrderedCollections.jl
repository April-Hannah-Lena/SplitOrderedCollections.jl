module SplitOrderedCollections

using OrderedCollections
using SplittablesBase
import SplittablesBase: amount, halve
import SplittablesBase.Implementations: firstslot, lastslot, DictView
import Base: iterate

# common

amount(xs::Union{OrderedDict,OrderedSet,LittleDict,BitSet}) = lastslot(xs)

function halve(xs::Union{OrderedDict,OrderedSet,LittleDict,BitSet})
    i1 = firstslot(xs)
    i3 = lastslot(xs)
    i2 = i3 ÷ 2
    left = DictView(xs, i1, i2)
    right = DictView(xs, i2 + 1, i3)
    return (left, right)
end

# interface for `OrderedCollections`

_testrehash!(xs::OrderedDict) = xs.ndel > 0      && OrderedCollections.rehash!(xs)
_testrehash!(xs::OrderedSet)  = xs.dict.ndel > 0 && OrderedCollections.rehash!(xs.dict)

DictView(xs::OrderedDict, i::Int, j::Int) = DictView(xs,      i, j, identity)
DictView(xs::LittleDict,  i::Int, j::Int) = DictView(xs,      i, j, identity)
DictView(xs::OrderedSet,  i::Int, j::Int) = DictView(xs.dict, i, j, first)

firstslot(::Union{OrderedDict,OrderedSet,LittleDict}) = 1

lastslot(xs::OrderedDict) = (_testrehash!(xs); length(xs.keys))
lastslot(xs::OrderedSet)  = (_testrehash!(xs); length(xs.dict.keys))
lastslot(xs::LittleDict)  = length(xs.keys)

# interface for `BitSet`

DictView(xs::BitSet, i::Int, j::Int) = DictView(xs, i, j, identity)

firstslot(xs::BitSet) = 1

lastslot(xs::BitSet) = length(xs.bits)

function iterate(xs::DictView{BitSet}, i = (Base.CHK0, xs.firstslot - 1))
    last(i) <= xs.lastslot || return nothing
    y = iterate(xs.dict, i)
    y === nothing && return nothing
    x, j = y
    last(j) <= xs.lastslot + 1 && return xs.f(x), j
    return nothing
end

end # module
