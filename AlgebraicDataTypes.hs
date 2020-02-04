--
-- CECS 424
-- Haskell vs C
-- AlgebraicDataTypes.hs
-- 
-- 2. Algebraic Data Types
--

module AlgebraicDataTypes where

import Data.Foldable


-- co-product (disjunction, enumeration)
data Gender = Female | Male deriving (Show, Eq)
--female and male are constants

isMale :: Gender -> Bool
isMale Male = True
isMale _    = False

isFemale g = case g of
                Female     -> True
                otherwise  -> False


-- product (conjunction, tuple, struct)

data Person = Person String Int Gender deriving (Show, Eq)
--defined a new type Person, Person on right of equal is a data constructor

name :: Person -> String
name   (Person n a g) = n

age :: Person -> Int
age    (Person n a g) = a 

gender :: Person -> Gender
gender (Person n a g) = g


-- Declare an order on persons (by name)
instance Ord Person where
  p <= q = name p <= name q
  --defined order on person, a person p is less than person q only is name is less than or equal to person q's
  --person implements interface ord if you wanna think about it in java

-- A list of 4 people
somePeople = [Person "Alice" 19 Female, Person "Bob" 20 Male, Person "Carol" 17 Female, Person "Dave" 30 Male]


-- Haskel can help to define the projections
data Person' = Person' {
                 name'   :: String,
                 age'    :: Int,
                 gender' :: Gender }
                   deriving (Show, Eq)



-- recursive data structures

-- make our own list (to understand how lists work)
data List a = Nil | Cons a (List a) deriving Show
-- list of element type a is either nill or cons. a cons has element of type a, and a cons of list of elements a
--

-- make our own lists foldable
instance Foldable List where
  foldr op z Nil = z
  foldr op z (Cons a as) = a `op` (foldr op z as)


-- binary tree data structure
data Tree a = Tip | Branch (Tree a) a (Tree a) deriving Show


-- insert an element into a sorted tree
insert :: Ord a => a -> Tree a -> Tree a
insert a Tip = Branch Tip a Tip
insert a (Branch l p r) | a <= p    = Branch (insert a l) p r
                        | otherwise = Branch l p (insert a r)

-- convert a list to a sorted tree
toTree :: Ord a => [a] -> Tree a
toTree = foldr insert Tip


-- tree traversal

-- traverse in order
trInOrd :: Tree a -> [a]
trInOrd Tip = []
trInOrd (Branch l a r) = trInOrd l ++ [a] ++ trInOrd r

trInOrd' :: Tree a -> [a] -> [a]
trInOrd' Tip = \x -> x
trInOrd' (Branch l a r) = trInOrd' l . (a:) . trInOrd' r

instance Foldable Tree where
  foldr f z Tip            = z
  foldr f z (Branch l m r) = foldr f (f m (foldr f z r)) l

-- toList = foldr (:) []


-- traverse pre order
trPreOrd' :: Tree a -> [a] -> [a]
trPreOrd' Tip = \x -> x
trPreOrd' (Branch l a r) = (a:) . trPreOrd' l . trPreOrd' r 

-- traverse pre order
trPostOrd' :: Tree a -> [a] -> [a]
trPostOrd' Tip = \x -> x
trPostOrd' (Branch l a r) = trPostOrd' l . trPostOrd' r . (a:)