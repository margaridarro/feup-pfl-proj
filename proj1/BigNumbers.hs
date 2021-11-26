--2.1 .. 2.7
import Data.Char (digitToInt)
import Data.Char (intToDigit)
import Data.List

-----------
----2.1----
-----------
type Signal = Char
type BigNumber = (Char, [Int])

-----------
----2.2----
-----------
scanner:: String -> BigNumber
scanner (x:xs)  | (x == '-' || x == '+') && (removeLeftZeros (map digitToInt xs) == [0]) = (' ', [0])
                | x == '-' || x == '+' = (x, removeLeftZeros (map digitToInt xs))
                | removeLeftZeros (digitToInt x : map digitToInt xs) == [0] = (' ', [0])
                | otherwise = ('+', removeLeftZeros (digitToInt x : map digitToInt xs))
-----------
----2.3----
-----------
output:: BigNumber -> String
output a | getDigits a == ['0']  = "0"
         | otherwise             = [getSignal a] ++ getDigits a


-----------
----2.4----
-----------
-------- Soma sinal igual
calcCarry:: Int -> Int
calcCarry a = div a 10

calcRest:: Int -> Int
calcRest a = mod a 10 

somaPos:: [Int] -> [Int] -> Int -> Int -> Int
somaPos a b carry n | n < length a && n < length b  = (a !! n) + (b !! n) + carry
                    | n < length a                  = (a !! n) + carry 
                    | n < length b                  = (b !! n) + carry
                    | otherwise                     = carry

soma:: [Int] -> [Int] -> Int -> Int -> [Int]
soma a b c n  | (n < (max (length a) (length b) + 1)) = [ calcRest res_soma ] ++ soma a b (calcCarry res_soma) (n+1) 
              | otherwise  = []
        where res_soma = somaPos a b c n

calcSoma:: [Int] -> [Int] -> [Int]
calcSoma a b = removeLeftZeros (reverseList (soma (reverseList a) (reverseList b) 0 0))

--------------------
--Soma sinal diferente 

maxBN:: [Int] -> [Int] -> Int
maxBN a b | length a > length b = 0
          | length a < length b = 1
          | head a == head b    = maxBN (drop 1 a) (drop 1 b)
          | head a > head b     = 0
          | otherwise           = 1
          
calcSomaSignal:: BigNumber -> BigNumber -> Char
calcSomaSignal a b | maxBN (getIntList a) (getIntList b) == 0 = getSignal a
                   | otherwise                                = getSignal b

getMaxBN:: BigNumber -> BigNumber -> BigNumber
getMaxBN a b | calcSomaSignal a b == getSignal a = a
             | otherwise = b

calcSub:: [Int] -> [Int] -> [Int] -- TODO
calcSub a b = a
------------------
somaBN:: BigNumber -> BigNumber -> BigNumber
somaBN a b  | getSignal a == getSignal b    = (fst a, calcSoma (snd a) (snd b))
            | getDigits a == getDigits b    = ((' '), [0])
            | (getMaxBN a b) == a           = (calcSomaSignal a b, calcSub (snd a) (snd b))
            | otherwise                     = (calcSomaSignal a b, calcSub (snd b) (snd a))
            


-- testeBase: somaBN ('+',[1,2,1,2,4]) ('+',[2,1,2,4])

-- testeSignal: somaBN ('+',[1,2,1,2,4]) ('+',[2,1,2,4])


--2.5
--subBN

--2.6
--mulBN

--2.7
--divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)



------------------------
-- Auxiliar Functions---
------------------------

getSignal:: BigNumber -> Char
getSignal a = fst a

getDigits:: BigNumber -> String
getDigits a = map intToDigit (snd a)

getIntList:: BigNumber -> [Int]
getIntList a = snd a

removeLeftZeros::   [Int] -> [Int]
removeLeftZeros x   | head x == 0 && length x == 1 = [0]
                    | head x == 0                  = [] ++ removeLeftZeros (drop 1 x)
                    | otherwise                    = x


reverseList:: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]
