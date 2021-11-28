-- module BigNumber(
--     BigNumber,
--     scanner,
--     output,
--     somaBN,
--     subBN,
--     mulBN
-- ) where
-- 
-- type BigNumber = (Char, [Int])

--1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-1) + fibRec (n-2) 

--1.2 
fibLista:: (Integral a) => a -> a
fibLista n = [fibRec (x) | x <- [0..]] !! fromIntegral n

--1.3
fibListaInfinita:: (Integral a)  => a -> a
fibListaInfinita n = [fibRec (x) | x <- [0..]] !! fromIntegral n



--3
--fibRecBN:: BigNumber
