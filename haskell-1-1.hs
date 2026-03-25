import System.IO

myMinimum :: [Int] -> Int
myMinimum [x] = x
myMinimum (x:xs) = 
    let minRest = myMinimum xs 
    in if x < minRest then x else minRest

removeFirst :: Int -> [Int] -> [Int]
removeFirst _ [] = []
removeFirst target (x:xs)
    | x == target = xs
    | otherwise   = x : removeFirst target xs

removeNSmallest :: Int -> [Int] -> [Int]
removeNSmallest n xs 
    | n <= 0    = xs
    | null xs   = []
    | otherwise = 
        let m = myMinimum xs
            updatedList = removeFirst m xs
        in removeNSmallest (n - 1) updatedList

main :: IO ()
main = do

    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "Введіть список чисел через пробіл (наприклад: 10 2 8 1 5):"
    hFlush stdout
    listLine <- getLine

    let list = map read (words listLine) :: [Int]

    putStr "Введіть кількість елементів для вилучення (N): "
    hFlush stdout
    nLine <- getLine
    let n = read nLine :: Int
    
    putStrLn $ "Початковий список: " ++ show list
    putStrLn $ "Вилучаємо " ++ show n ++ " найменших..."

    let result = removeNSmallest n list
    putStr "Результат: "
    print result