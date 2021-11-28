import BigNumber

-- 
-- type BigNumber = (Char, [Int])

-- 1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-1) + fibRec (n-2) 

-- 1.2 
fibLista:: (Integral a) => a -> a
fibLista n = [fibRec (x) | x <- [0..]] !! fromIntegral n

-- 1.3
fibListaInfinita:: (Integral a)  => a -> a
fibListaInfinita n = [fibRec (x) | x <- [0..]] !! fromIntegral n

-- 3
-- fibRecBN:: BigNumber -> BigNumber
-- fibRecBN (' ',[0]) = (' ',[0])
-- fibRecBN ('+',[1]) = ('+',[1])
-- fibRecBN n = somaBN ( fibRecBN( subBN n ('+',[1]))) (fibRecBN (subBN n ('+',[2])))


--fibListaBN

--fibListaInfinitaBN.