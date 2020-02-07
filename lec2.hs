doubleMe x = x + x
doubleUs x y = x*2 + y*2 --this means that in the terminal you can do doubleUs 4 9 and get 26
--cuz 4*2 = 8 and 9*2 = 18
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1