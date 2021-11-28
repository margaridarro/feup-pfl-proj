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
fibLista n = last listaFib 
            where listaFib = [0, 1] ++ [ listaFib !! fromIntegral (x-2) + listaFib !! fromIntegral(x-1)  | x <- [2..n] ]

-- 1.3
fibListaInfinita:: (Integral a)  => a -> a
fibListaInfinita n = listaFib !! fromIntegral n
                    where listaFib = [0, 1] ++ [listaFib !! fromIntegral (x-2) + listaFib !! fromIntegral(x-1)  | x <- [2..]]

-- 3
fibRecBN:: BigNumber -> BigNumber
fibRecBN (' ',[0]) = (' ',[0])
fibRecBN ('+',[1]) = ('+',[1])
fibRecBN n = somaBN ( fibRecBN( subBN n ('+',[1]))) (fibRecBN (subBN n ('+',[2])))

-- fibListaBN:: BigNumber -> BigNumber
-- fibListaBN n = last listaFib 
--             where listaFib = [ (' ',[0]),('+',[1]) ] ++ [ listaFib !! ( subBN ('+',[1]) ('+',[2]) ) -- + listaFib !! ( subBN ('+',[x]) ('+',[1]) )  | x <- [2..n] ]



-- fibListaBN n = [fibRecBN(x) | x <- [0..]] !! inn 

--fibListaInfinitaBN.