import System.IO

unique :: [Int] -> [Int]
unique [] = []
unique (x:xs) = x : unique (filter (/= x) xs)

stepBack :: [(Int, Int)] -> [Int] -> [Int]
stepBack transitions productive =
    [from | (from, to) <- transitions, to `elem` productive]

findProductive :: [(Int, Int)] -> [Int] -> [Int]
findProductive transitions current =
    let next = unique (current ++ stepBack transitions current)
    in if length next == length current 
       then current 
       else findProductive transitions next

runCase :: String -> [Int] -> [Int] -> [(Int, Int)] -> IO ()
runCase name allStates final transitions = do
    putStrLn $ "=== " ++ name ++ " ==="
    putStrLn $ "ВХІДНІ ДАНІ:"
    putStrLn $ "  Усі стани: " ++ show allStates
    putStrLn $ "  Фінальні стани: " ++ show final
    putStrLn $ "  Переходи: " ++ show transitions
    let productive = findProductive transitions final
    let nonProductive = [s | s <- allStates, s `notElem` productive]
    putStrLn "РЕЗУЛЬТАТ:"
    putStrLn $ "  Продуктивні: " ++ show productive
    putStrLn $ "  Непродуктивні: " ++ show nonProductive
    putStrLn ""

main :: IO ()
main = do
    putStrLn "ВИКОНАННЯ ТЕСТІВ (задача 3):\n"
    runCase "Тест 1:" [0,1,2] [2] [(0,1), (1,2)]
    runCase "Тест 2:" [0,1,2] [1] [(0,1), (1,2), (2,2)]
    runCase "Тест 3:" [0,1,2] [2] [(0,1), (1,0), (0,2)]
    runCase "Тест 4:" [0,1,2,3] [1] [(0,1), (2,3)]