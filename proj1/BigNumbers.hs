--2.1 .. 2.7
import Data.Char (digitToInt)


--2.1

type BigNumber = (Char, [Int])

--2.2
scanner:: String -> BigNumber
scanner (x:xs) = (x, map digitToInt xs)

--2.3
--output

--2.4
--somaBN

--2.5
--subBN

--2.6
--mulBN

--2.7
--divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)
