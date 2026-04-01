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

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "--- Аналіз продуктивності станів автомата ---"
    
    putStrLn "Введіть усі стани автомата (через пробіл):"
    hFlush stdout
    allStatesInput <- getLine
    let allStates = map read (words allStatesInput) :: [Int]

    putStrLn "Введіть фінальні стани (через пробіл):"
    hFlush stdout
    finalInput <- getLine
    let finalStates = map read (words finalInput) :: [Int]

    putStrLn "Введіть переходи у форматі 'звідки куди' (порожній рядок для завершення):"
    hFlush stdout
    transitions <- readTransitions
    
    let productive = findProductive transitions finalStates
    let nonProductive = [s | s <- allStates, s `notElem` productive]

    putStrLn "\n--- РЕЗУЛЬТАТ ---"
    putStrLn $ "Продуктивні стани: " ++ show productive
    putStrLn $ "Непродуктивні стани: " ++ show nonProductive

readTransitions :: IO [(Int, Int)]
readTransitions = do
    line <- getLine
    if null line
        then return []
        else do
            let [from, to] = map read (words line)
            rest <- readTransitions
            return ((from, to) : rest)