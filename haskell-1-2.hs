import System.IO

keepCubes :: [Int] -> Int -> Int -> [Int]
keepCubes [] _ _ = []
keepCubes (x:xs) i k
    | i == k^3  = x : keepCubes xs (i + 1) (k + 1)
    | otherwise = keepCubes xs (i + 1) k

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "Введіть список цілих чисел через пробіл (наприклад: 1 2 3 4 5):"
    hFlush stdout
    
    input <- getLine
    let list = map read (words input) :: [Int]
    
    let result = keepCubes list 0 0
    
    putStrLn "Елементи на позиціях 0, 1, 8, 27... :"
    print result