-- CSci 117, Lab 1:  Introduction to Haskell

---------------- Part 1 ----------------

-- WORK through Chapters 1 - 3 of LYaH. Type in the examples and make
-- sure you understand the results.  Ask questions about anything you
-- don't understand! This is your chance to get off to a good start
-- understanding Haskell.


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


-- toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo, enumFromThenTo -------
-- As one of your examples, try  (toEnum 3) :: Color --------------------------

-- ==, /= ---------------------------------------------------------------------

-- quot, div (Q: what is the difference? Hint: negative numbers) --------------

-- rem, mod  (Q: what is the difference? Hint: negative numbers) --------------

-- quotRem, divMod ------------------------------------------------------------

-- &&, || ---------------------------------------------------------------------

-- ++ -------------------------------------------------------------------------

-- compare --------------------------------------------------------------------

-- <, > -----------------------------------------------------------------------

-- max, min -------------------------------------------------------------------

-- ^ --------------------------------------------------------------------------

-- concat ---------------------------------------------------------------------

-- const ----------------------------------------------------------------------

-- cycle ----------------------------------------------------------------------

-- drop, take -----------------------------------------------------------------

-- elem -----------------------------------------------------------------------

-- even -----------------------------------------------------------------------

-- fst ------------------------------------------------------------------------

-- gcd ------------------------------------------------------------------------

-- head -----------------------------------------------------------------------

-- id -------------------------------------------------------------------------

-- init -----------------------------------------------------------------------

-- last -----------------------------------------------------------------------

-- lcm ------------------------------------------------------------------------

-- length ---------------------------------------------------------------------

-- null -----------------------------------------------------------------------

-- odd ------------------------------------------------------------------------

-- repeat ---------------------------------------------------------------------

-- replicate ------------------------------------------------------------------

-- reverse --------------------------------------------------------------------

-- snd ------------------------------------------------------------------------

-- splitAt --------------------------------------------------------------------

-- zip ------------------------------------------------------------------------


-- The rest of these are higher-order, i.e., they take functions as
-- arguments. This means that you'll need to "construct" functions to
-- provide as arguments if you want to test them.

-- all, any -------------------------------------------------------------------

-- break ----------------------------------------------------------------------

-- dropWhile, takeWhile -------------------------------------------------------

-- filter ---------------------------------------------------------------------

-- iterate --------------------------------------------------------------------

-- map ------------------------------------------------------------------------

-- span -----------------------------------------------------------------------

