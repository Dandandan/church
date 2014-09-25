module Boolean where

{-| Booleans using Church encoding. Useful for creating control structures.
    
```haskell
type Level a = { ready : Boolean a}

start = { ready = false }

render { ready } = ready renderScore renderLevel
  
```


# Boolean values
@docs Boolean, true, false

# Boolean functions
@docs and, or, not, xor, equals

# Conversion
@docs show, fromBool, toBool

-}

{-| Boolean type -}
type Boolean a = a -> a -> a

{-| Takes two values and returns the first
-}
true : Boolean a
true x y = x

{-| Takes two values and returns the second
-}
false : Boolean a
false x y = y

{-| Negate a boolean value: `(not true == false)` and `(not false == true)`

-}
not : Boolean a -> Boolean a
not p = flip p

{-| `true` if both inputs are `true`. This operator short-circuits if the first argument is `false`.
-}
and : Boolean (Boolean a) -> Boolean a -> Boolean a
and p q = p q false


{-| `true` if one or both inputs are `true`. This operator short-circuits if the first argument is `true`.
-}
or : Boolean (Boolean a) -> Boolean a -> Boolean a
or p q = p true q

{-| The exclusive-or function. True if exactly one input is true.

-}
xor : Boolean (Boolean a) -> Boolean (Boolean a) -> Boolean a
xor p q = p (q false true) (q true false)

{-| `true` if the first argument equals the second  -}
equals : a -> a -> Boolean b
equals a b = fromBool (a == b)

{-| Convert a `Boolean` into a string -}
show : Boolean String -> String
show p = p "true" "false"

{-| Convert a `Boolean` into a Bool -}
toBool : Boolean Bool -> Bool
toBool p = p True False

{-| Convert a `Bool` into a `Boolean` -}
fromBool : Bool -> Boolean a
fromBool b = if b then true else false
