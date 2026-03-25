import System.IO

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

splitRecursive :: [Int] -> Int -> [[Int]]
splitRecursive [] _ = []
splitRecursive xs k = 
    let n = factorial k
        currentChunk = take n xs
        rest = drop n xs
    in currentChunk : splitRecursive rest (k + 1)

processList :: [Int] -> [[Int]]
processList xs = 
    let reversedInput = reverse xs
        chunks = splitRecursive reversedInput 1
    in reverse (map reverse chunks)

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "--- Завдання: Розбиття списку за факторіалом з кінця ---"
    putStrLn "Введіть числа через пробіл (наприклад, від 1 до 10):"
    hFlush stdout
    
    input <- getLine
    let list = map read (words input) :: [Int]

    let result = processList list
    
    putStrLn "Результат розбиття:"
    print result