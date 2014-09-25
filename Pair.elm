module Pair where
{-| Pairs using Church encoding.

```haskell
    p = pair 1 2
    one = first p
```

# Pair
@docs Pair, pair

# Pair functions
@docs first, second

# Conversion
@docs show, fromTuple, toTuple
-}
import String

{-| `Pair` type -}
type Pair a b c = (a -> b -> c) -> c

{-| Create a pair
```haskell
toTuple (pair 1 2) = (1, 2)
```
-}
pair : a -> b -> Pair a b c
pair x y z = z x y

{-| Convert a `Pair` into a `String` -}
show : Pair a b String -> String
show p = p (\x y -> String.show (x, y))

{-| Get the first value from the pair
```haskell
first (pair 1 2) == 1
```
-}
first : Pair a b a -> a
first p = p (\x y -> x)

{-| Get the second value from the pair
```haskell
first (pair 1 2) == 2
```
-}
second : Pair a b b -> b
second p = p (\x y -> y)

{-| Convert a Pair into a Tuple -}
toTuple : Pair a b (a, b) -> (a, b)
toTuple p = p (\x y -> (x,y))

{-| Convert a tuple into a `Pair` -}
fromTuple : (a, b) -> Pair a b c
fromTuple (a, b) = pair a b
