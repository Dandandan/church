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
@docs and, or, not, xor

# Displaying
@docs show

-}

{-| Boolean type -}
type Boolean a = a -> a -> a

{-| true value
    Takes two values and returns the first
-}
true : Boolean a
true x y = x

{-| true value
    Takes two values and returns the second
-}
false : Boolean a
false x y = y

{-| Negate a boolean value: (not true == false) and (not false == true)

-}
not : Boolean a -> Boolean a
not p = flip p

{-| The `and` function. True if both inputs are true. This operator short-circuits if the first argument is false.
-}
and : Boolean (Boolean a) -> Boolean a -> Boolean a
and p q = p q false


{-| The or operator. True if one or both inputs are true. This operator short-circuits if the first argument is true.
-}
or : Boolean (Boolean a) -> Boolean a -> Boolean a
or p q = p true q

{-| The exclusive-or operator. True if exactly one input is true.

-}
xor : Boolean (Boolean a) -> Boolean (Boolean a) -> Boolean a
xor p q = p (q false true) (q true false)


{-| Convert a boolean into a string -}
show : Boolean String -> String
show f = f "true" "false"
