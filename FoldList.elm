module FoldList where
import String
{-| List using Church encoding. 
    A FoldList is a fold function.

```haskell
    toList (cons 1 (cons 2 empty)) == [1, 2]
```

# FoldList
@docs FoldList, empty, cons

# Pair functions
@docs isEmpty

# Conversion
@docs show, fromList, toList


-}

import Boolean (..)

{-| `FoldList` type -}
type FoldList a b = (a -> b -> b) -> b -> b

{-| Empty list -}
empty : FoldList a b
empty c n = n

{-| Add element to the front of the list `toList (cons 1 (cons 2 empty)) == [1,2]` -}
cons : a -> FoldList a b -> FoldList a b
cons x fold f b = f x (fold f b)

{-| Returns `true` when list is empty, `false` otherwise -}
isEmpty : FoldList a (Boolean b) -> Boolean b
isEmpty fold = fold (\_ _ -> false) true

{-| Converts a `List` into a `FoldList` -}
fromList : [a] -> FoldList a b
fromList xs = foldr cons empty xs

{-| Converts a `FoldList` into a `List` -}
toList : FoldList a [a] -> [a]
toList fold = fold (::) []

{-| Converts a `FoldList` into a `String` -}
show : FoldList a [a] -> String
show fold = String.show (toList fold)

