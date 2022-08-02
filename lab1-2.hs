-- CSci 117, Lab 1:  Introduction to Haskell
-- Thuy Uyen My Tran

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.

{-
I have read the LYAH chapters and I have an idea how Haskell works
and how to implement it
-} 

---------------- Part 2 ----------------

-- The Haskell Prelude has a lot of useful built-in functions related
-- to numbers and lists.  In Part 2 of this lab, you will catalog many
-- of these functions.

-- Below is the definition of a new Color type (also called an
-- "enumeration type").  You will be using this, when you can, in
-- experimenting with the functions and operators below.
data Color = Red | Orange | Yellow | Green | Blue | Violet
     deriving (Show, Eq, Ord, Enum)

-- For each of the Prelude functions listed below, give its type,
-- describe briefly in your own words what the function does, answer
-- any questions specified, and give several examples of its use,
-- including examples involving the Color type, if appropriate (note
-- that Color, by the deriving clause, is an Eq, Ord, and Enum type).
-- Include as many examples as necessary to illustration all of the
-- features of the function.  Put your answers inside {- -} comments.
-- I've done the first one for you (note that "λ: " is my ghci prompt).


-- succ, pred ----------------------------------------------------------------

{- 
succ :: Enum a => a -> a
pred :: Enum a => a -> a

For any Enum type, succ gives the next element of the type after the
given one, and pred gives the previous. Asking for the succ of the
last element of the type, or the pred of the first element of the type
results in an error.

λ: succ 5
6
λ: succ 'd'
'e'
λ: succ False
True
λ: succ True
*** Exception: Prelude.Enum.Bool.succ: bad argument
λ: succ Orange
Yellow
λ: succ Violet
*** Exception: succ{Color}: tried to take `succ' of last tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
λ: pred 6
5
λ: pred 'e'
'd'
λ: pred True
False
λ: pred False
*** Exception: Prelude.Enum.Bool.pred: bad argument
λ: pred Orange
Red
λ: pred Red
*** Exception: pred{Color}: tried to take `pred' of first tag in enumeration
CallStack (from HasCallStack):
  error, called at lab1.hs:18:31 in main:Main
-}

-- succ
  -- succ :: Enum a => a -> a
  -- Takes a value and returns its successor
  -- Works with color type
  {-
  *Main> succ 'b'
  'c'
  *Main> succ 4
  5
  *Main> succ Red
  Orange
  -}

-- pred
  -- pred :: Enum a => a -> a
  -- Takes a value and return its predecessor
  -- Works with color type
  {-
  *Main> pred 'b'
  'a'
  *Main> pred 4
  3
  *Main> pred Violet
  Blue
  -}
  
-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------

  --toEnum
    -- toEnum :: Enum a => Int -> a
    -- returns the item at argument position from an enumeration
    -- works with color type
    {-*Main> toEnum 20 :: Float
    20.0
    *Main> toEnum 1 :: Color
    Orange
    *Main> to Enum 3 :: Bool

    <interactive>:37:1: error:
    Variable not in scope: to :: t0 -> t1 -> Bool

    <interactive>:37:4: error: Data constructor not in scope: Enum
    -}

  --fromEnum
    -- fromEnum :: Enum a => a -> Int 
    -- Returns the argument position in an enumeration
    -- Works with color type
    {- 
    *Main> fromEnum (-1)
    -1
    *Main> fromEnum (-1.1)
    -1
    *Main> fromEnum ('G')
    71
    *Main> fromEnum Orange
    1
    -}

  --enumFrom
    -- enumFrom :: Enum a => a -> [a]
    -- Takes an element of a list and returns  the remaining members of the list
    -- Can return infinite list
    -- Works with color type
    {-
    *Main> enumFrom 'a' (returns an infinite list)
    *Main> enumFrom 2 (returns an infinite list)
    *Main> enumFrom Violet
    [Violet]
    *Main> enumFrom Orange
    [Orange,Yellow,Green,Blue,Violet]
    *Main> enumFrom 7 = 8
    *Main> enumFrom 7
    8
    -}

  --enumFromThen
    -- enumFromThen :: Enum a => a -> a -> [a]
    -- Retuns an array of members of an enumaration
    -- starting with the first argument and with the distances 0, 1, 2,...
    -- Distance from the first argument to the second one is equivalent to the syntax
    {-
    *Main> enumFromThen Orange Red
    [Orange,Red]
    *Main> enumFromThen Red Orange
    [Red,Orange,Yellow,Green,Blue,Violet]
    *Main> take 6 (enumFromThen 1.1 1.4)
    [1.1,1.4,1.6999999999999997,1.9999999999999996,2.2999999999999994,2.599999999999999]
    -}

  --enumFromTo
    -- enumFromTo :: Enum a => a -> a -> [a]
    -- Takes 2 inputs from an EDT and lameks a list
    -- Returns an array of members of an enumeration starting 
    -- with the first argument
    -- Finishes with the second element
    -- It is equivalent to syntax
    {-
    *Main> take 10 (enumFromTo 1.1111 2)
    [1.1111,2.1111]
    *Main> take 2 (enumFromTo 1.3 to 1.4)

    <interactive>:54:24: error: Variable not in scope: to
    *Main> take 10 (enumFromTo Red Violet)
    [Red,Orange,Yellow,Green,Blue,Violet]
    *Main> take 10 (enumFromTo Violet Orange)
    []
    -}

  --enumFromThenTo
    -- numFromThenTo :: Enum a => a -> a -> a -> [a]
    -- Takes 3 inputs from a EDT and makes a list starting with the first value
    -- Returns an array of members of an enumeration starting 
    -- with the first argument and finishing with the third one in distances 
    -- determined by the second one
    -- Works with color type
    {-
    *Main> enumFromThenTo 1 10 20
    [1,10,19]
    *Main> enumFromThenTo 20 10 40
    []
    *Main> enumFromThenTo 1 10 9
    [1]
    *Main> enumFromThenTo Red Blue Violet
    [Red,Blue]
    *Main> enumFromThenTo 0.1 1.2 6.3
    [0.1,1.2,2.3,3.4,4.499999999999999,5.599999999999999,6.699999999999999]
    *Main> take 10 (enumFromThenTo False False False)
    [False,False,False,False,False,False,False,False,False,False]
    -}

-- As one of your examples, try  (toEnum 3) :: Color --------------------------
  {-
  *Main> (toEnum 3) :: Color
  Green
  -}

-- ==, /= ---------------------------------------------------------------------
  -- == 
    -- (==) :: Eq a => a -> a -> Bool
    -- Equality operator (1==1 TRUE)
    -- Works with color type
    {-
    *Main> 1 == 1
    True
    *Main> 1 == 2
    False
    *Main> 'a' == 'a'
    True
    *Main> 2 == 1 + 1
    True
    *Main> Blue == Red
    False
    *Main> Blue == Blue
    True
    -}

  -- /=
    -- (/=) :: Eq a => a -> a -> Bool
    -- Unequality operator
    -- Returns false if the values are equal
    -- Works with color type
    {-
    *Main> Green /= Red
    True
    *Main> 1 /= 2
    True
    *Main> 1 /= 1
    False
    *Main> 1 /= 1.0
    False
    *Main> 
    -}

-- quot, div (Q: what is the difference? Hint: negative numbers) --------------
  -- The difference is quot is integer division truncated toward zero, 
  -- while the result of div is truncated toward negative infinity

  -- quot
   -- quot :: Integral a => a -> a -> a
   -- Integer division
   -- Divides the first argument by the second argument, discarding the remainder
   -- Does not work with color type
   {-
    *Main> quot 15 5 
    3
    *Main> quot 16 5
    3
    *Main> quot Blue Red

    <interactive>:78:1: error:
        • No instance for (Integral Color) arising from a use of ‘quot’
        • In the expression: quot Blue Red
      In an equation for ‘it’: it = quot Blue Red
    *Main> quot 5 0
    *** Exception: divide by zero
    *Main> quot 15 -3

    <interactive>:80:1: error:
        • Non type-variable argument in the constraint: Num (a -> a)
          (Use FlexibleContexts to permit this)
        • When checking the inferred type
          it :: forall a. (Integral a, Num (a -> a)) => a -> a

    *Main> quot 2 (-123)
    0
   -}

   -- div
    -- div :: Integral a => a -> a -> a
    -- Divides the first argument by the second argument
    -- Truncates towards negativity
    -- Does not work with color type
    {-
    *Main> div 15 (-3)
    -5
    *Main> div 15 3
    5
    *Main> div Red Green

    <interactive>:86:1: error:
    • No instance for (Integral Color) arising from a use of ‘div’
    *Main> div 2 (-123)
    -1
    -}


-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------
  {-
  Q: what is the difference? 
  A: 
  - rem finds a remainder after preforming division,
  - mod finds the modulus after doing division. 
  - Basically mod can move past zero to find a remainder, rem can't.
  - Result of mod is always negative, result of rem can be either
  - positive or negative
  -}
  --rem
    -- rem :: Integral a => a -> a -> a
    -- Takes two inputs from the intergral typeclass 
    -- and divices the first input by the second input
    -- Returns the remainder
    -- Satisfies (x `quot` y)*y + (x `rem` y)
    -- Can't divide by zero
    -- Does not work with color type 
    {-
    *Main> rem 10 3
    1
    *Main> rem (-3) 2
    -1
    *Main> rem 4 2
    0
    *Main> rem 5 3
    2
    *Main> rem Orange Red

    <interactive>:97:1: error:
        • No instance for (Integral Color) arising from a use of ‘rem’
        • In the expression: rem Orange Red
          In an equation for ‘it’: it = rem Orange Red
    *Main> rem 3 0
    *** Exception: divide by zero
    -}

  --mod
    -- mod :: Integral a => a -> a -> a
    -- Takes two inputs from the integral typeclass and does modular 
    -- division of the first input with the second input
    -- Can't divide by zero
    -- Does not work with color type
    {-
    *Main> mod 10 3
    1
    *Main> mod 10 2
    0
    *Main> mod 10

    <interactive>:101:1: error:
        • No instance for (Show (Integer -> Integer))
            arising from a use of ‘print’
            (maybe you haven't applied a function to enough arguments?)
        • In a stmt of an interactive GHCi command: print it
    *Main> mod 2 (-1)
    0
    *Main> mod 5 (-4)
    -3
    *Main> mod Red Orange

    <interactive>:104:1: error:
        • No instance for (Integral Color) arising from a use of ‘mod’
        • In the expression: mod Red Orange
        In an equation for ‘it’: it = mod Red Orange
    -}

-- quotRem, divMod ------------------------------------------------------------
  --quotRem
    -- quotRem :: Integral a => a -> a -> (a, a)
    -- It returns a tuple: (result of integer division, reminder)
    -- Can't divide by zero
    -- Does not work with color type
    {-
    *Main> quotRem 5 2
    (2,1)
    *Main> quotRem 10 7
    (1,3)
    *Main> quotRem 10 (-7)
    (-1,3)
    *Main> quotRem (-10) (-7)
    (1,-3)
    *Main> quotRem (-10) 7
    (-1,-3)
    *Main> quotRem Orange Red

    <interactive>:110:1: error:
        • No instance for (Integral Color) arising from a use of ‘quotRem’
        • In the expression: quotRem Orange Red
          In an equation for ‘it’: it = quotRem Orange Red
    -}

  --divmod
    -- divMod :: Integral a => a -> a -> (a, a)
    -- The function returns a tuple containing the result of 
    -- integral division and modulo.
    -- Can't divide by zero
    -- Does not work with color type
    {-
    *Main> divMod 10 1
    (10,0)
    *Main> divMod 1 10
    (0,1)
    *Main> divMod 4 3
    (1,1)
    *Main> divMod 4 (-3)
    (-2,-2)
    *Main> divMod (-3) 4
    (-1,1)
    *Main> divMod (-4) 3
    (-2,2)
    *Main> divMod Blue Green

    <interactive>:117:1: error:
        • No instance for (Integral Color) arising from a use of ‘divMod’
        • In the expression: divMod Blue Green
          In an equation for ‘it’: it = divMod Blue Green
    -}

-- &&, || ---------------------------------------------------------------------
  -- &&
    -- (&&) :: Bool -> Bool -> Bool
    -- Logical AND: takes two boolan inputs and returns a bool
    -- Does not work with numbers
    -- Does not work with color type
    {-
    *Main> True && True
    True
    *Main> True && False
    False
    *Main> False && False
    False
    *Main> 1 && 1

    <interactive>:121:1: error:
        • No instance for (Num Bool) arising from the literal ‘1’
        • In the first argument of ‘(&&)’, namely ‘1’
          In the expression: 1 && 1
          In an equation for ‘it’: it = 1 && 1

    *Main> Blue && Blue

    <interactive>:123:1: error:
        • Couldn't match expected type ‘Bool’ with actual type ‘Color’
        • In the first argument of ‘(&&)’, namely ‘Blue’
          In the expression: Blue && Blue
          In an equation for ‘it’: it = Blue && Blue

    <interactive>:123:9: error:
        • Couldn't match expected type ‘Bool’ with actual type ‘Color’
        • In the second argument of ‘(&&)’, namely ‘Blue’
          In the expression: Blue && Blue
          In an equation for ‘it’: it = Blue && Blue
    -}

  -- ||
    -- (||) :: Bool -> Bool -> Bool
    -- Logical OR: takes two boolan inputs and returns a bool
    -- Does not work with color type
    {-
    *Main> True || False
    True
    *Main> True || True
    True
    *Main> False || False
    False
    *Main> False || True
    True
    *Main> False || 1

    <interactive>:129:10: error:
        • No instance for (Num Bool) arising from the literal ‘1’
        • In the second argument of ‘(||)’, namely ‘1’
          In the expression: False || 1
          In an equation for ‘it’: it = False || 1
    *Main> i = True
    *Main> i || True
    True
    *Main> Green || Blue

    <interactive>:132:1: error:
        • Couldn't match expected type ‘Bool’ with actual type ‘Color’
        • In the first argument of ‘(||)’, namely ‘Green’
          In the expression: Green || Blue
          In an equation for ‘it’: it = Green || Blue

    <interactive>:132:10: error:
        • Couldn't match expected type ‘Bool’ with actual type ‘Color’
        • In the second argument of ‘(||)’, namely ‘Blue’
          In the expression: Green || Blue
          In an equation for ‘it’: it = Green || Blue
    -}

-- ++ -------------------------------------------------------------------------
  -- (++) :: [a] -> [a] -> [a]
  -- Takes two lists as input and returns the second list appended to the first
  -- Works with color type
  {-
  *Main> 1 ++ 1

  <interactive>:133:1: error:
      • Non type-variable argument in the constraint: Num [a]
        (Use FlexibleContexts to permit this)
      • When checking the inferred type
          it :: forall a. Num [a] => [a]
  *Main> [1] ++ [1]
  [1,1]
  *Main> [a] ++ [b] ++ [c]

  <interactive>:135:2: error: Variable not in scope: a

  <interactive>:135:9: error: Variable not in scope: b

  <interactive>:135:16: error: Variable not in scope: c
  *Main> 1 ++ 1

  <interactive>:136:1: error:
      • Non type-variable argument in the constraint: Num [a]
        (Use FlexibleContexts to permit this)
      • When checking the inferred type
          it :: forall a. Num [a] => [a]
  *Main> [1] ++ [1]
  [1,1]
  *Main> ["a"] ++ ["b"] ++ ["c"]
  ["a","b","c"]
  *Main> [Orange] ++ [Green]
  [Orange,Green]
  -}

-- compare --------------------------------------------------------------------
  -- compare :: Ord a => a -> a -> Ordering
  -- takes two inputs or lists, compares them then returns their ordering
  -- Returns GT, LT, or UQ
  -- Works with color type
  {-
  *Main> compare 1 5
  LT
  *Main> compare 1 (-6)
  GT
  *Main> compare 'A' 'T'
  LT
  *Main> compare Orange Violet
  LT
  *Main> Compare [1,2,3] [1,2,4]

  <interactive>:146:1: error:
      • Data constructor not in scope: Compare :: [a0] -> [a1] -> t
      • Perhaps you meant variable ‘compare’ (imported from Prelude)
  *Main> compare [1,2,3] [1,2,3]
  EQ
  *Main> compare 1.1 1.11
  LT
  -}

-- <, > -----------------------------------------------------------------------
  -- <
    -- (<) :: Ord a => a -> a -> Bool
    -- Takes two input and checks to see if the first input is greater 
    -- than the second input
    -- Works with color type
    {-
    *Main> 2 < 1
    False
    *Main> 1 < 2
    True
    *Main> Orange < Red
    False
    *Main> 1 < (-1)
    False
    *Main> 1 < 'A'

    <interactive>:153:1: error:
        • No instance for (Num Char) arising from the literal ‘1’
        • In the first argument of ‘(<)’, namely ‘1’
          In the expression: 1 < 'A'
          In an equation for ‘it’: it = 1 < 'A'
    *Main> 1 < "A"

    <interactive>:154:1: error:
        • No instance for (Num [Char]) arising from the literal ‘1’
        • In the first argument of ‘(<)’, namely ‘1’
          In the expression: 1 < "A"
          In an equation for ‘it’: it = 1 < "A"
    *Main> [2,3] < [3,4]
    True
    -}

  -- >
    -- (>) :: Ord a => a -> a -> Bool
    -- Takes two inputs and checks to see if the first input is 
    -- less than the second input
    -- Works with color type
    {-
    *Main> Orange > Green
    False
    *Main> 1 > 2
    False
    *Main> 1 > 0.99
    True
    *Main> 'A' < 'B'
    True
    -}

-- max, min -------------------------------------------------------------------
  -- max
    -- max :: Ord a => a -> a -> a
    -- Takes 2 inputs and returns the greater one
    -- Works with color type
    {-
    *Main> max 0 1
    1
    *Main> max Blue Green
    Blue
    *Main> max 'B' 'Z'
    'Z'
    *Main> max [1,2] [3,2]
    [3,2]
    -}

  -- min
    -- min :: Ord a => a -> a -> a
    -- Takes 2 inputs and returns the lesser one
    -- Works with color type
    {-
    *Main> min 0 1
    0
    *Main> min 'B' 'H'
    'B'
    *Main> min Violet Blue
    Blue
    *Main> min [2,9] [2,9]
    [2,9]
    -}

-- ^ --------------------------------------------------------------------------
  -- (^) :: (Integral b, Num a) => a -> b -> a
  -- Takes 2 inputs and raises the first number to the second number's power
  -- Second input has to be positive
  -- Does not work with color type
  {-
  *Main> 2^2
  4
  *Main> 2^(-1)
  *** Exception: Negative exponent
  *Main> Orange^Green

  <interactive>:173:1: error:
      • No instance for (Integral Color) arising from a use of ‘^’
      • In the expression: Orange ^ Green
        In an equation for ‘it’: it = Orange ^ Green
  *Main> 'A' ^ 'B'

  <interactive>:174:1: error:
      • No instance for (Integral Char) arising from a use of ‘^’
      • In the expression: 'A' ^ 'B'
        In an equation for ‘it’: it = 'A' ^ 'B'
  -}

-- concat ---------------------------------------------------------------------
  -- concat :: Foldable t => t [a] -> [a]
  -- Accepts a list of lists and concatenates them
  -- Works with color type
  {-
  *Main> concat [[],[]]
  []
  *Main> concat [[1],[2,3,4]]
  [1,2,3,4]
  *Main> concat [[Orange, Red],[Blue, Violet]]
  [Orange,Red,Blue,Violet]
  *Main> concat [[1],[2,3,4],[5,6,7]]
  [1,2,3,4,5,6,7]
  -}

-- const ----------------------------------------------------------------------
  -- const :: a -> b -> a
  -- Takes 2 inputs and returns the first input
  -- Works with color type
  {-
  *Main> const 2 3
  2
  *Main> const Orange Green
  Orange
  *Main> a = const 2 3 
  *Main> b = const 4 5
  *Main> c = const 6 7
  *Main> a + b + c
  12
  -}

-- cycle ----------------------------------------------------------------------
  -- cycle :: [a] -> [a]
  -- Tt creates a circular list from a finite one
  -- Works with color type
  {-
  *Main> cycle [1] [2]
  infinite list
  *Main> take 10 (cycle [1,2,3])
  [1,2,3,1,2,3,1,2,3,1]
  *Main> colors = [Orange, Green]
  *Main> take 20 (cycle colors)
  [Orange,Green,Orange,Green,Orange,Green,Orange,Green,Orange,Green,Orange,
  Green,Orange,Green,Orange,Green,Orange,Green,Orange,Green]
  -}

-- drop, take -----------------------------------------------------------------
  -- drop
    -- drop :: Int -> [a] -> [a]
    -- Takes an Int for the first inpuut and a list for the second input
    -- The first input is the amount of members that are dropped 
    -- The function then drops those members nd returns the remainder of the list
    -- Works with color type
    {-
    *Main> drop 2 [2,3,4,5]
    [4,5]
    *Main> drop 1 [2,3,4,5]
    [3,4,5]
    *Main> drop 5 [2,3,4,5]
    []
    *Main> drop 1 [Orange, Green, Blue]
    [Green,Blue]
    -}

  -- take
    -- take :: Int -> [a] -> [a]
    -- Takes an Int for the first input and a list for the second input
    -- The first input is the amoount of members that are taken and 
    -- returned to the user in a list
    -- Works with color type
    {-
    *Main> take 4 [1,2,3,4,5,6,7,8]
    [1,2,3,4]
    *Main> take 2 [Orange, Blue, Green]
    [Orange,Blue]
    *Main> color = [Orange, Blue, Green, Violet, Red]
    *Main> take (3) color
    [Orange,Blue,Green]
    -}

-- elem -----------------------------------------------------------------------
  -- elem :: (Foldable t, Eq a) => a -> t a -> Bool
  -- Returns True if the list contains an item equal to the first argument  
  -- Works with color type
  {-
  *Main> colors = [Orange, Green, Blue, Red, Violet]
  *Main> colors
  [Orange,Green,Blue,Red,Violet]
  *Main> elem Green colors
  True
  *Main> elem Yellow colors
  False
  *Main> ten = [1,2,3,4,5,6,7,8,9,10]
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> elem 4 ten
  True
  *Main> elem 12 ten
  False
  -}

-- even -----------------------------------------------------------------------
  -- even :: Integral a => a -> Bool
  -- Takes an integral as an input and returns true if it is even
  -- Return false otherwise
  -- Does not work with color type
  {-
  *Main> even Blue

  <interactive>:33:1: error:
      • No instance for (Integral Color) arising from a use of ‘even’
      • In the expression: even Blue
        In an equation for ‘it’: it = even Blue
  *Main> even 2
  True
  *Main> even (4-2)
  True
  -}

-- fst ------------------------------------------------------------------------
  -- fst :: (a, b) -> a
  -- Takes a tuple as input and returns its firstmember
  -- Works with color type
  {-
  *Main> (Orange, 1)
  (Orange,1)
  *Main> truple = (Orange, 1)
  *Main> truple
  (Orange,1)
  *Main> fst truple
  Orange
  *Main> fst ([1,2,3], ['a','b','c'])
  [1,2,3]
  -}

-- gcd ------------------------------------------------------------------------
  -- gcd :: Integral a => a -> a -> a
  -- Takes two Int as inputs and reeturns the greatest common divisor
  -- Does not work with color type
  {-
  *Main> gcd 8 2
  2
  *Main> gcd 8 4
  4
  *Main> gcd Orange

  <interactive>:43:1: error:
      • No instance for (Integral Color) arising from a use of ‘gcd’
      • In the expression: gcd Orange
        In an equation for ‘it’: it = gcd Orange
  -}

-- head -----------------------------------------------------------------------
  -- head :: [a] -> a
  -- Takes a list and returns the first member
  -- Works with color type
  {-
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> color
  [Orange,Blue,Green,Violet,Red]
  *Main> head ten
  1
  *Main> head color
  Orange
  -}

-- id -------------------------------------------------------------------------
  -- id :: a -> a
  -- Takes a list and returns it 
  -- Works with color type
  {-
  *Main> id ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> id colors
  [Orange,Green,Blue,Red,Violet]
  *Main> id 'k'
  'k'
  *Main> id 1
  1
  -}

-- init -----------------------------------------------------------------------
  -- init :: [a] -> [a]
  -- Takes a list and returns it without reading the last member
  -- Works with color type
  {-
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> init ten
  [1,2,3,4,5,6,7,8,9]
  *Main> colors
  [Orange,Green,Blue,Red,Violet]
  *Main> init colors
  [Orange,Green,Blue,Red]
  -}

-- last -----------------------------------------------------------------------
  -- last :: [a] -> a
  -- Takes a list and returns the first member
  -- Works with color type
  {-
  *Main> colors
  [Orange,Green,Blue,Red,Violet]
  *Main> last colors
  Violet
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> last ten
  10
  *Main> last [1,2,3,4,5]
  5
  -}

-- lcm ------------------------------------------------------------------------
  -- Integral a => a -> a -> a
  -- Takes two Int and returns the lowest common multiple
  -- Does not work with color type
  {-
  *Main> lcm 12 499
  5988
  *Main> lcm 2 5
  10
  *Main> lcm Red Blue

  <interactive>:63:1: error:
      • No instance for (Integral Color) arising from a use of ‘lcm’
      • In the expression: lcm Red Blue
        In an equation for ‘it’: it = lcm Red Blue
  -}

-- length ---------------------------------------------------------------------
  -- length :: Foldable t => t a -> Int
  -- Takes a list as input and returns the length of the list
  -- Works with color type
  {-
  *Main> colors
  [Orange,Green,Blue,Red,Violet]
  *Main> length colors
  5
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> length ten
  10
  *Main> length "Iamhappy"
  8
  -}

-- null -----------------------------------------------------------------------
  -- null :: Foldable t => t a -> Bool
  -- Takes a list and returns true if the list is empty
  -- Returns false otherwise
  -- Works with color type
  {-
  *Main> colors
  [Orange,Green,Blue,Red,Violet]
  *Main> null colors
  False
  *Main> null []
  True
  *Main> null ""
  True
  -}

-- odd ------------------------------------------------------------------------
  -- odd :: Integral a => a -> Bool
  -- Takes an Integral as input and returns true if it is even
  -- Returns false otherwise
  -- Does not work with color type
  {-
  *Main> odd 2
  False
  *Main> odd 3
  True
  *Main> ten
  [1,2,3,4,5,6,7,8,9,10]
  *Main> odd ten

  <interactive>:76:1: error:
      • No instance for (Integral [Integer]) arising from a use of ‘odd’
      • In the expression: odd ten
        In an equation for ‘it’: it = odd ten
  *Main> odd Blue

  <interactive>:77:1: error:
      • No instance for (Integral Color) arising from a use of ‘odd’
      • In the expression: odd Blue
        In an equation for ‘it’: it = odd Blue
  -}

-- repeat ---------------------------------------------------------------------
  -- repeat :: a -> [a]
  -- Takes a value of any types as input and repeats it infinitely in a list
  -- Works with color type
  {-
  *Main> take 2 (repeat 5)
  [5,5]
  *Main> take 10 (repeat 5)
  [5,5,5,5,5,5,5,5,5,5]
  *Main> take 4 (repeat Orange)
  [Orange,Orange,Orange,Orange]
  -}

-- replicate ------------------------------------------------------------------
  -- replicate :: Int -> a -> [a]
  -- Takes an Int and value of any type
  -- Returns a list then filled with copies of the second parameter and uses 
  -- the first paraeter for the size of the list
  -- Works with color type
  {-
  *Main> replicate 3 Green
  [Green,Green,Green]
  *Main> replicate 10 2
  [2,2,2,2,2,2,2,2,2,2]
  *Main> replpicate 4 'Hi'

  <interactive>:13:14: error:
      • Syntax error on 'Hi'
        Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
      • In the Template Haskell quotation 'Hi'
  *Main> replicate 4 'hi'

  <interactive>:14:13: error:
      • Syntax error on 'hi'
        Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
      • In the Template Haskell quotation 'hi'
  *Main> replpicate 4 "Hi"

  <interactive>:15:1: error:
      • Variable not in scope: replpicate :: t0 -> [Char] -> t
      • Perhaps you meant ‘replicate’ (imported from Prelude)
  *Main> replicate 4 "hi"
  ["hi","hi","hi","hi"]
  -}

-- reverse --------------------------------------------------------------------
  -- reverse :: [a] -> [a]
  -- Reversed a list 
  -- Works with color type
  {-
  *Main> reverse "I love boba tea"
  "aet abob evol I"
  *Main> reverse [1,2,3,4,5,6,7,8,9,10]
  [10,9,8,7,6,5,4,3,2,1]
  *Main> reverse [Orange, Green, Blue]
  [Blue,Green,Orange]
  -}

-- snd ------------------------------------------------------------------------
  -- snd :: (a, b) -> b
  -- Returns the second member of a tuple
  -- Works with color type
  {-
  *Main> truple
  ('A',"Tuple")
 *Main> snd truple
  "Tuple"
  *Main> favColors = (Green,Orange)
  *Main> snd favColors
  Orange
  -}

-- splitAt --------------------------------------------------------------------
  -- splitAt :: Int -> [a] -> ([a], [a])
  -- Take and Int and a list, then returns a tuple with two lists
  -- Uses the members of the input list to populate the first list
  -- in the tuple until the length reaches the value of the Int input
  -- Then places the rest of the members in a new list for the second part
  -- of the tuple
  -- Works with color type
  {-
  *Main> splitAt 5 [1,2,3,4,5,6,7,8]
  ([1,2,3,4,5],[6,7,8])
  *Main> splitAt 5 ten
  ([1,2,3,4,5],[6,7,8,9,10])
  *Main> splitAt (-2) ten
  ([],[1,2,3,4,5,6,7,8,9,10])
  *Main> splitAt 2 ten
  ([1,2],[3,4,5,6,7,8,9,10])
  *Main> splitAt 10 ten
  ([1,2,3,4,5,6,7,8,9,10],[])
  *Main> splitAt 11 ten
  ([1,2,3,4,5,6,7,8,9,10],[])
  *Main> splitAt 4 colors
  ([Red,Orange,Yellow,Green],[Blue,Violet])
  -}

-- zip ------------------------------------------------------------------------
  -- zip :: [a] -> [b] -> [(a, b)]
  -- Take two lists and returns a list of tuples
  -- Each tuple contains the members of each slot out of the two input lists
  -- Function stops making tuples when one of the lists runs out of members
  -- Works with color types
  {-
  *Main> zip (take 5 (iterate (2*) 10)) (take 5 (iterate (2/) 10)) 
  (10,10.0),(20,0.2),(40,10.0),(80,0.2),(160,10.0)]
  *Main> zip ["zip"] ["this"]
  [("zip","this")]
  *Main> zip ['a','d','f'] ['b','c','e']
  [('a','b'),('d','c'),('f','e')]
  -}

-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------
  -- all 
    -- all :: Foldable t => (a -> Bool) -> t a -> Bool
    -- Takes a condition in a parenthesis as the first input
    -- Take a list as the second input
    -- Returns True if all items in the list fulfill the condition
    -- Returns False otherwise
    -- Works with color type
    {-
    *Main> all (<=10) [1,2,3,4,5,6,7,8,9,10]
    True
    *Main> all (<Violet) [Red, Orange]
    True
    *Main> all (==2) [(1+1), 2]
    True
    *Main> all (<=10) [1,2,3,4,5,6,7,8,9,10)
    -}


  -- any
    -- any :: Foldable t => (a -> Bool) -> t a -> Bool
    -- Takes a condition in a parenthesis as the first input
    -- Take a list as the second input
    -- Returns True if any of the members in the given list 
    -- satisfy the condition
    -- Returns False otherwise
    -- Works with color type
    {-
    *Main> any (<2) [1,2,3,4,5,6]
    True
    *Main> any (<2) [3,4,5,6]
    False
    *Main> any (==Orange) [Orange, Blue, Red]
    True
    *Main> any (<Orange) [Orange, Blue, Red]
    True
    -}

-- break ----------------------------------------------------------------------
    -- Takes a condition in a parenthesis as the first input
    -- Take a list as the second input
    -- Returns two lists formed as a tuple
    -- Checks each member of the list with the condition
    -- and populates the first part of the tuple with the members 
    -- that return False, puts the remaining members in the second list.
    -- Works with color type
    {-
    *Main> break (<3) [1,2,3,4,5,6,7,8,9,10]
    ([],[1,2,3,4,5,6,7,8,9,10])
    *Main> break (==3) [1,2,3,4,5,6,7,8,9,10]
    ([1,2],[3,4,5,6,7,8,9,10])
    *Main> break (<Blue) [Orange, Green, Blue, Violet]
    ([],[Orange,Green,Blue,Violet])
    -}

-- dropWhile, takeWhile -------------------------------------------------------
  -- dropWhile
    -- dropWhile :: (a -> Bool) -> [a] -> [a]
    -- Takes a condition in a parenthesis as the first input
    -- Take a list as the second input
    -- Drops the members that satisfy the condition
    -- Returns the rest of the list
    -- Works with color type
    {-
    *Main> dropWhile (<4) [1,2,3,4,5,6,7]
    [4,5,6,7]
    *Main> dropWhile (<Green) [Orange, Red, Green, Blue]
    [Green,Blue]
    *Main> dropWhile (==Green) [Orange, Red, Green, Blue]
    [Orange,Red,Green,Blue]
    -}

  -- takeWhile
    -- takeWhile :: (a -> Bool) -> [a] -> [a]
    -- Takes a condition in a parenthesis as the first input
    -- Take a list as the second input
    -- Takes the members that satisfy the condition puts them in a list
    -- Returns the list
    -- Works with color type
    {-
    *Main> takeWhile (<5) [1,2,3,4,5,6,7]
    [1,2,3,4]
    *Main> takeWhile (<Green) [Orange, Red, Green, Blue]
    [Orange,Red]
    *Main> takeWhile (==Green) [Orange, Red, Green, Blue]
    []
    *Main
    -}

-- filter ---------------------------------------------------------------------
  -- filter :: (a -> Bool) -> [a] -> [a]
  -- Takes a condition in a parenthesis as the first input
  -- Take a list as the second input
  -- traverses the list 
  -- Returns a new list that contains all of the members
  -- that satisfied the condition
  -- Works with color type
  {-
  *Main> filter (<4) [1,2,3,4,5,6,7]
  [1,2,3]
  *Main> filter (<Green) [Orange, Red, Green, Blue]
  [Orange,Red]
  *Main> filter (==Green) [Orange, Red, Green, Blue]
  [Green]
  -}

-- iterate --------------------------------------------------------------------
  -- iterate :: (a -> a) -> a -> [a]
  -- Takes a functions and a value as an input
  -- Applies the value to the function and repeatedly applies the value to
  -- the function after using the results to populate the list
  -- Populates the list infinity
  -- Does not work with color type
  {-
  *Main> take 5 (iterate (5*) 2)
  [2,10,50,250,1250]
  *Main> take 5 (iterate (/2) 20)
  [20.0,10.0,5.0,2.5,1.25]
  *Main> take 10 (iterate (*2) 2)
  [2,4,8,16,32,64,128,256,512,1024]
  -} 

-- map ------------------------------------------------------------------------
  -- map :: (a -> b) -> [a] -> [b]
  -- Takes a function and a list as input
  -- takes each member of the list and uses it as input for the function
  -- places each outputs in a list and returns it
  -- Works with color type
  {-
  *Main> map odd [1,2,3,4,5,6,7,8,9,10]
  [True,False,True,False,True,False,True,False,True,False]
  *Main> map id [Orange, Red, Blue]
  [Orange,Red,Blue]
  -}

-- span -----------------------------------------------------------------------
  -- span :: (a -> Bool) -> [a] -> ([a], [a])
  -- Applies to a predicate p and a list xs, returns a tuple where first
  -- element is longest prefix (possibly empty) of xs of elements 
  -- that satisfy p and second element is the remainder of the list.
  -- Works with Color type
  {-
  *Main> span (<5) [1,2,3,4,5,6,7,8,9]
  ([1,2,3,4],[5,6,7,8,9])
  *Main> span (>5) [1,2,3,4,5,6,7,8,9]
  ([],[1,2,3,4,5,6,7,8,9])
  *Main> span (==5) [1,2,3,4,5,6,7,8,9]
  ([],[1,2,3,4,5,6,7,8,9])
  *Main> span (==Orange) [Orange, Red, Blue]
  ([Orange],[Red,Blue])
  *Main> span (>Orange) [Orange, Red, Blue]
  ([],[Orange,Red,Blue])
  -}


