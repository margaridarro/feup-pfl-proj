--1.1
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-1) + fibRec (n-2) 

--1.2 kkkkkkk muito mau isto
fibLista:: [Integer]
fibLista = [fibRec (x) | x <- [0..]]

--1.3
fibListaInfinita:: Int -> [Integer]
fibListaInfinita n = take n ([fibRec (x) | x <- [0..]])
