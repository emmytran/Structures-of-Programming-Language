module Fraction (Fraction, frac) where

-- Fraction type. ADT maintains the invariant that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer
  deriving Eq

-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible
frac :: Integer -> Integer -> Maybe Fraction
frac n m
    | m > 0 && gcd n m == 1 = Just (Frac n m)
    | m > 0 && gcd n m /= 1 = Just (reduce (Frac n m))
    | m < 0                 = let n' = (negate n)
                                  m' = (negate m)
                              in frac n' m'
    | otherwise = Nothing

-- Helper function for reduction of a Fraction
reduce :: Fraction -> Fraction
reduce (Frac n m)
      | gcd n m /= 1 = Frac (quot n (gcd n m)) (quot m (gcd n m))
      | otherwise    = Frac n m

-- Show instance that outputs Frac n m as n/m
instance Show Fraction where
  show (Frac n m) = (show n ++ "/" ++ show m)

-- Ord instance for Fraction
instance Ord Fraction where
  compare (Frac n m) (Frac n' m') = compare (n*(m')) (m*(n'))

-- Num instance for Fraction
instance Num Fraction where
  (-) (Frac a b) (Frac c d) = reduce (Frac (a*d-b*c) (b*d))
  (+) (Frac a b) (Frac c d) = reduce (Frac (a*d+b*c) (b*d))
  (*) (Frac a b) (Frac c d) = reduce (Frac (a*c) (b*d))
  signum (Frac a b)
      | a > 0     = 1
      | a == 0    = 0
      | otherwise = (-1)
  fromInteger x = Frac x 1
  abs (Frac a b)
      | a < 0     = Frac (negate a) b
      | otherwise = Frac a b
