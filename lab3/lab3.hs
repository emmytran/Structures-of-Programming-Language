-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List (sort)
--import Queue1
import Queue2
import Fraction

---------------- Part 1: Queue client

-- Queue operations (A = add, R = remove)
data Qops a = A a | R

-- Perform a list of queue operations on an emtpy queue,
-- returning the list of the removed elements
perf :: [Qops a] -> [a]
perf xs = help xs mtq where
    help :: [Qops a] -> Queue a -> [a]
    help [] q = []
    help (A x : xs) q = help xs (addq x q)
    help (R: xs) q = let (x, q2) = remq q 
                     in x: help xs q2

-- Test the above functions thouroughly. For example, here is one test:
-- perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] ---> [3,5,7,9,11]

{- Test Cases
*Main> perf [A 12, A 6, R, R, A 8]
[12,6]
*Main> perf [A 12, A 6, R, A 8]
[12]
*Main> perf [A 3, A 5, R, A 7, R, A 9, A 11, R, R, R] 
[3,5,7,9,11]
-}

---------------- Part 2: Using typeclass instances for fractions

-- Construct a fraction, producing an error if it fails
fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
average :: [Fraction] -> Fraction
average [] = error "Empty list."
average xs = sum xs * len xs 1 where
    len [] n= error "Illegal fraction"
    len [x] n= fraction 1 n
    len (x:xs) n= len xs (n+1) 

-- Some lists of fractions

list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
list3 = zipWith (+) list1 list2

-- Make up several more lists for testing
list4 = [fraction (n+3) n | n <- take 20 (cycle [1..7])]
list5 = [fraction (n*2) (n+2) | n <- [1..10]]

list6 = [fraction n (n-1) | n <- filter even [1..30]]
list7 = [fraction n (n-1) | n <- filter odd [2..30]]

-- Show examples testing the functions sort, sum, product, maximum, minimum,
-- and average on a few lists of fractions each. Think about how these library
-- functions can operate on Fractions, even though they were written long ago

{- Test Case Examples 
--------Sort-------
*Main> sort list1
[1/2,2/3,3/4,4/5,5/6,6/7,7/8,8/9,9/10,10/11,11/12,12/13,13/14,14/15,15/16,16/17,
17/18,18/19,19/20,20/21]
*Main> sort list2
[1/20,1/19,1/18,1/17,1/16,1/15,1/14,1/13,1/12,1/11,1/10,1/9,1/8,1/7,1/6,1/5,1/4,
1/3,1/2,1/1]
*Main> sort list3
[421/420,381/380,343/342,307/306,273/272,241/240,211/210,183/182,157/156,133/132,
111/110,91/90,73/72,57/56,43/42,31/30,21/20,13/12,7/6,3/2]
*Main> sort list4
[10/7,10/7,3/2,3/2,3/2,8/5,8/5,8/5,7/4,7/4,7/4,2/1,2/1,2/1,5/2,5/2,5/2,4/1,4/1,
4/1]

--------Sum-------
*Main> sum list4
6007/140
*Main> sum list5
94159/6930
*Main> sun list6
*Main> sum list7
11261813/720720

-------Product-------
*Main> product list3
128335079363657015232198361/55428820724455833600000000
*Main> product list4
1209600/1
*Main> product list5
512/33
*Main> product list6
67108864/9694845

------Maximum------
*Main> maximum list2
1/1
*Main> maximum list3
3/2
*Main> maximum list4
4/1
*Main> maximum list5
5/3

------Minimum------
*Main> minimum list2
1/20
*Main> minimum list3
421/420
*Main> minimum list4
10/7
*Main> minimum list5
2/3

------Average------
*Main> average list2
11167027/62078016
*Main> average list3
22/21
*Main> average list4
6007/2800
*Main> average list5
94159/69300
-}