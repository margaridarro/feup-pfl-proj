--2.1 .. 2.7
import Data.Char (digitToInt)
import Data.Char (intToDigit)
import Data.List


--2.1
type BigNumber = (Char, [Int])

--2.2
scanner:: String -> BigNumber
scanner (x:xs)  | x == '-' || x == '+' = (x, map digitToInt xs)
                | otherwise = ('+', digitToInt x : map digitToInt xs)

                
                
teste:: [Int] -> String
teste a = map intToDigit a

--2.3
{-
output1:: BigNumber -> Char
output1 a = fst a

output2:: BigNumber -> String
output2 a = map intToDigit (snd a)
-}
output:: BigNumber -> String
output a = [fst a] ++ map intToDigit (snd a)


--2.4
--somaBN

--2.5
--subBN

--2.6
--mulBN

--2.7
--divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)
