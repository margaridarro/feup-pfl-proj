--2.1 .. 2.7
import Data.Char (digitToInt)
import Data.Char (intToDigit)
import Data.List



--2.1
type BigNumber = (Char, [Int])

--2.2
scanner:: String -> BigNumber
scanner (x:xs) | x == '-' || x == '+' = (x, removeLeftZeros (map digitToInt xs))
                | otherwise = ('+', removeLeftZeros (digitToInt x : map digitToInt xs))

--2.3
{-
outputSignal:: BigNumber -> Char
outputSignal a = fst a

outputDigits:: BigNumber -> String
outputDigits a = map intToDigit (snd a)
-}
output:: BigNumber -> String
output a = [fst a] ++ map intToDigit (snd a)

--2.4

calcCarry:: Int -> Int
calcCarry a = div a 10

calcRest:: Int -> Int
calcRest a = mod a 10 

somaIndex:: [Int] -> [Int] -> Int -> Int -> Int
somaIndex a b carry n   | n < length a && n < length b  = (a !! n) + (b !! n) + carry
                        | n < length a                  = (a !! n) + carry 
                        | n < length b                  = (b !! n) + carry
                        | otherwise                     = carry

soma:: [Int] -> [Int] -> Int -> Int -> [Int]
soma a b c n | (n < (max (length a) (length b) + 1)) = [ calcRest (somaIndex a b c n) ] ++ soma a b (calcCarry (somaIndex a b c n)) (n+1)
                    | otherwise  = []
        

calcSoma:: [Int] -> [Int] -> [Int]
calcSoma a b = removeLeftZeros (reverseList (soma (reverseList a) (reverseList b) 0 0))


somaBN:: BigNumber -> BigNumber -> BigNumber
somaBN a b  | fst a == fst b =  (fst a, calcSoma (snd a) (snd b))
            | otherwise = a


--somaBN ('+',[1,2,1,2,4]) ('+',[2,1,2,4])


--2.5
--subBN

--2.6
--mulBN

--2.7
--divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)


-- Auxiliar Functions

removeLeftZeros::   [Int] -> [Int]
removeLeftZeros x   | (head x == 0) = [] ++ removeLeftZeros (drop 1 x)
                    | otherwise = x

reverseList:: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]
