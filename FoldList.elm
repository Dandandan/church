module FoldList where

{-| List using Church encoding. 


```haskell
    toList (cons 1 (cons 2 empty)) == [1, 2]
```

# FoldList
@docs FoldList, empty, cons

# FoldList functions
@docs isEmpty, length, map, append

# Conversion
@docs show, fromList, toList


-}

import String
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

{-| Length of a FoldList -}
length : FoldList a Int -> Int
length fold = fold (\_ y -> 1 + y) 0

{-| Filter a FoldList using a predicate function -}
filter : (a -> Boolean (FoldList a b)) -> FoldList a (FoldList a b) -> FoldList a b
filter f fold = fold (\x y -> f x (x `cons` y) y) empty

{-| Apply a function to every element -}
map : (a -> b) -> FoldList a (FoldList b c) -> FoldList b c
map f fold = fold (\x y ->  f x `cons` y) empty

{-| Append two FoldLists -}
append : FoldList a b -> FoldList a b -> FoldList a b
append xs ys k z = xs k (ys k z)

{-| Converts a `FoldList` into a `String` -}
show : FoldList a [a] -> String
show fold = String.show (toList fold)


