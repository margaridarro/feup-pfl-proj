import Data.Char (digitToInt)
import Data.Char (intToDigit)
import Data.List

----------------------
----2.1.definition----
----------------------
type Signal = Char
type BigNumber = (Char, [Int])

------------------
----2.2-scanner---
------------------
scanner:: String -> BigNumber
scanner (x:xs)  | (x == '-' || x == '+') && (removeLeftZeros (map digitToInt xs) == [0]) = (' ', [0])
                | x == '-' || x == '+' = (x, removeLeftZeros (map digitToInt xs))
                | removeLeftZeros (digitToInt x : map digitToInt xs) == [0] = (' ', [0])
                | otherwise = ('+', removeLeftZeros (digitToInt x : map digitToInt xs))
                
------------------
----2.3-output----
------------------
output:: BigNumber -> String
output a | getDigits a == ['0']  = "0"
         | otherwise             = [getSignal a] ++ getDigits a

------------------
----2.4-somaBN----
------------------
somaBN:: BigNumber -> BigNumber -> BigNumber
somaBN a b  | getSignal a == getSignal b  = (fst a, calcSoma (snd a) (snd b))
            | getDigits a == getDigits b  = ((' '), [0])
            | (maxBN a b) == a            = (calcSomaSignal a b, calcSub (snd a) (snd b))
            | otherwise                   = (calcSomaSignal a b, calcSub (snd b) (snd a))
            
-- testeSoma: somaBN ('+',[1,1,2]) ('-',[1, 2])

------------------
----2.5-subBN-----
------------------
subBN:: BigNumber -> BigNumber -> BigNumber
subBN a b | getDigits a == getDigits b && getSignal a == getSignal b  = ((' '), [0])
          | getSignal a /= getSignal b = (getSignal (maxBN a b), calcSoma (snd a) (snd b))
          | (maxBN a b) == a           = (getSignal a, calcSub (snd a) (snd b))
          | (maxBN a b) == b           = (invertSignal (getSignal b), calcSub (snd b) (snd a))

-- testeSub: subBN ('+',[1,1,2]) ('+',[1, 2])

-----------------
----2.6-mulBN----
-----------------
mulBN:: BigNumber -> BigNumber -> BigNumber
mulBN a b | getIntList a == [0] || getIntList b == [0] = (' ', [0])
          | getSignal a == getSignal b = ('+', calcMul (snd a) (snd b))
          | otherwise                  = ('-', calcMul (snd a) (snd b))

-- testeMul: mulBN ('+',[1,1,1]) ('-',[1, 1])

-----------------
----2.7-divBN----
-----------------
--divPos::[Int] -> [Int] -> (Int, Int)
{-

divPos:: [Int] -> [Int] -> Int -> Int --retorna quociente
divPos a b n | isMax (take n a) b = calcMul quociente (10**n)
             | otherwise          = divPos a b (n+1)
    where quociente = --TODO AAAAAAAAAAAA

div_:: [Int] -> [Int] -> [Int] -> ([Int], [Int])
div_ a b q | isMax a b    = div_ new_a b (calcSoma q res_div)
           | otherwise      = (q, a)
    where 
        res_div = divPos a b 0
        new_a = calcSub a (calcMul res_div b)

    
calcDiv:: [Int] -> [Int] -> (BigNumber, BigNumber)
calcDiv a b = (('+', fst res_div), ('+', snd res_div))
    where res_div = div_ a b [0]

    
divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b | output b == "0"   = ((' ', []), (' ', []))
        | maxBN b a == b      = ((' ', [0]), b)
        | otherwise           = calcDiv (snd a) (snd b)

   -}

------------------------
-- Auxiliar Functions---
------------------------
--- Generic
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

zeros:: Int->[Int]
zeros n = take n [0, 0..]

invertSignal:: Char -> Char
invertSignal a | a == '+'  = '-'
               | otherwise = '+'

               
--- Comparison
isMax:: [Int] -> [Int] -> Bool
isMax a b | head a > head b  = True
          | head a < head b  = False
          | otherwise        = isMax (drop 1 a) (drop 1 b)

maxBN:: BigNumber -> BigNumber -> BigNumber
maxBN a b | length (getIntList a) > length (getIntList b)   = a
          | length (getIntList a) < length (getIntList b)   = b
          | isMax (getIntList a) (getIntList b)             = a
          | otherwise = b

          
--- Soma
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
soma a b c n  | n < (max (length a) (length b) + 1) = [calcRest res_soma] ++ soma a b (calcCarry res_soma) (n+1) 
              | otherwise  = []
        where res_soma = somaPos a b c n

calcSoma:: [Int] -> [Int] -> [Int]
calcSoma a b = removeLeftZeros (reverseList (soma (reverseList a) (reverseList b) 0 0))

calcSomaSignal:: BigNumber -> BigNumber -> Char
calcSomaSignal a b | isMax (getIntList a) (getIntList b) = getSignal a
                   | otherwise                           = getSignal b
                   

                   
--- Sub
subPos:: [Int] -> [Int] -> Int -> Int -> Int
subPos a b carry n | n >= length b                  = (a !! n) - carry
                   | (a !! n) >= (b !! n) + carry   = (a !! n) - ((b !! n) + carry)
                   | otherwise                      = (a !! n) + 10 - ((b!!n) + carry) 

sub:: [Int] -> [Int] -> Int -> Int -> [Int]
sub a b carry n | n < (max (length a) (length b)) && res_sub > (a !! n) = [res_sub] ++ sub a b 1 (n+1)
                | n < (max (length a) (length b)) = [res_sub] ++ sub a b 0 (n+1)
                | otherwise = []
    where res_sub = subPos a b carry n
             
calcSub:: [Int] -> [Int] -> [Int]
calcSub a b = removeLeftZeros (reverseList (sub (reverseList a) (reverseList b) 0 0))  


-- Mul
mulPos:: Int -> [Int] -> Int -> Int -> [Int]
mulPos a_value b carry nb | nb > length b  = []
                          | nb == length b = [carry]
                          | otherwise      = [calcRest res_mul] ++ mulPos a_value b (calcCarry res_mul) (nb + 1)
    where res_mul = a_value * (b !! nb) + carry
    

mul:: [Int] -> [Int] -> Int -> [[Int]]
mul a b na | na < length a = [zeros na ++ mulPos (a !! na) b 0  0] ++ mul a b (na + 1)
           | otherwise     = []
                     
calcMulListas:: [Int] -> [Int] -> [[Int]]
calcMulListas a b = [ removeLeftZeros (reverseList x) | x <- mul (reverseList a) (reverseList b) 0]
                    
somaMulListas:: [[Int]] -> [Int]
somaMulListas (x:xs) = foldr (calcSoma) x xs -- O ORGULHO DESTE PROJETO RESIDE NESTA LINHA AAAAAAAAAAAA

calcMul:: [Int] -> [Int] -> [Int]
calcMul a b = somaMulListas (calcMulListas a b)
