import BigNumber

-- 1.1
{- 
    Receives an integer
    Returns the respective number with index = argument in the fibonacci list, by recursively calling the function
    Calculates Fibonacci number, computing all the elements before that one in fibonacci list
-}
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-1) + fibRec (n-2) 

-- 1.2 
{- 
    Receives an integer
    Returns the last element of a list with lengh = argument that correspondes to Fibonacci number
    Calculates fibonacci by consecutively adding two elements until n = argument
-}
fibLista:: (Integral a) => a -> a
fibLista n = last listaFib
            where listaFib = [0, 1] ++ [ listaFib !! fromIntegral (x-2) + listaFib !! fromIntegral(x-1)  | x <- [2..n] ]

-- 1.3
{- 
    Receives an integer
    Returns the element in order = argument of an infinite list that correspondes to Fibonacci number
    Calculates fibonacci  by consecutively adding two elements until n = argument
-}
fibListaInfinita:: (Integral a)  => a -> a
fibListaInfinita n = listaFib !! fromIntegral n
                    where listaFib = [0, 1] ++ [listaFib !! (x-2) + listaFib !! fromIntegral(x-1)  | x <- [2..]]

-- 3
{- 
    Receives a Big Number
    Returns the respective number with index = argument in the fibonacci list, by recursively calling the function
    Calculates Fibonacci number, computing all the elements before that one in fibonacci list and adding the two numbers immediately before the index of this one
-}
fibRecBN:: BigNumber -> BigNumber
fibRecBN (' ',[0]) = (' ',[0])
fibRecBN ('+',[1]) = ('+',[1])
fibRecBN n = somaBN (fibRecBN( subBN n ('+',[1]))) (fibRecBN (subBN n ('+',[2])))

getListElem:: [BigNumber] -> BigNumber -> BigNumber
getListElem l i = head (fst (until (\ (a,b) -> b == (' ',[0])) (\(a,b) -> (tail a,subBN b ('+',[1]))) (l,i)))

list2toBN:: BigNumber -> [BigNumber]
-- list2toBN n | b == n = [b]
--            | otherwise = [b] ++ listBN (somaBN (b) ('-', [1])) n
list2toBN n = fst (until (\ (a,b) -> ('+',[2]) == b) (\(a,b) -> (a++[b], somaBN b ('+',[1]))) ([('+',[2])],n))
 
fibListaBN:: BigNumber -> BigNumber
fibListaBN n 
        | (' ',[0]) == n = n
        | ('+',[1]) == n = n
        | otherwise = last listaFib 
            where listaFib = [ (' ',[0]) , ('+',[1]) ] ++ [ somaBN  (getListElem listaFib (subBN x ('+',[2]))) (getListElem listaFib (subBN x ('+',[1]))) | x <- list2toBN n ]

fibListaInfinitaBN:: BigNumber -> BigNumber
fibListaInfinitaBN n = getListElem listaFib n
            where listaFib = [ (' ',[0]) , ('+',[1]) ] ++ [ somaBN x y | (x,y) <- zip listaFib (tail listaFib)]
