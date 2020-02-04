--
-- CECS 424
-- Haskell vs C
-- BasicLanguageConstructs.hs
--
-- 1. Basic Language Constructs
--

module BasicLanguageConstructs where

-- variables
seven = 7

sq123 = let x = 123 in x * x

sq321 = x * x where x = 321


-- functions
twice1 n = 2 * n

twice2 = \n -> 2 * n --this is the way haskell actually works

twice3 = (2*)

average1 a b = (a+b)/2

average2 = \a b -> (a+b)/2


-- conditionals
signum1 n = if n < 0 then -1 else if n > 0 then 1 else 0

signum2 n | n < 0     = -1 -- guard
          | n > 0     =  1
          | otherwise =  0


-- recursion
factorial1 n = if n==0 then 1 else n * (factorial1 (n-1))


factorial2 0 = 1
factorial2 n = n * (factorial2 (n-1))

factorial3 n = fact_acc n 1
  where
    fact_acc 0 f = f
    fact_acc n f = fact_acc (n-1) (n * f)

factorial4 n = foldr (*) 1 [1..n]
--recursion example
--play with foldr to see what it does...

-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- foldr f z []     = z ...this isnt tail recursive
-- foldr f z (x:xs) = f x (foldr f z xs)


factorial5 n = foldl (*) 1 [1..n]

-- foldl :: (b -> a -> b) -> b -> [a] -> b
	--fold;, the tail recursive is easy to spot...
-- foldl f z []     = z  ... tail recursive version of up top but it does it from the left. funct on top does it from the right
-- foldl f z (x:xs) = foldl f (f z x) xs


factorial6 n = product [1..n]

-- product = foldl (*) 1

fib1 0 = 0
fib1 1 = 1
fib1 n = fib1 (n-2) + fib1 (n-1)


fib2 n = fib_acc n 0 1
  where
    fib_acc 0 a _ = a
    fib_acc n a b = fib_acc (n-1) b (a+b)

    
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- zipWith f [] _ = []
-- zipWith f _ [] = []
-- zipWith f (a:as) (b:bs) = f a b : zipWith f as bs