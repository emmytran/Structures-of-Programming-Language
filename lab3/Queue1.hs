module Queue1 (Queue, mtq, ismt, addq, remq) where

---- Interface ----------------
mtq  :: Queue a                  -- empty queue
ismt :: Queue a -> Bool          -- is the queue empty?
addq :: a -> Queue a -> Queue a  -- add element to front of queue
remq :: Queue a -> (a, Queue a)  -- remove element from back of queue;
                                 --   produces error on empty
---- Implementation -----------
data Queue a = Queue1 [a] deriving Show

mtq = Queue1 []
ismt (Queue1 xs) = null xs
addq x (Queue1 xs) = Queue1 ([x] ++ xs)
remq (Queue1 []) = error "Can't remove an element from an emppty queue"
remq (Queue1 xs) = let a = split xs 
                   in ((fst a), Queue1 (snd a))

split :: [a] -> (a, [a])
split [a] = (a, [])
split(x:xs) = let (ys,zs) = split xs 
              in (ys, x:zs)