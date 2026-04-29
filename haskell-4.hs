import System.IO
import Data.Char (isLower, isUpper)

type Rule = (Char, [String])

isUnique :: [Char] -> Bool
isUnique [] = True
isUnique (x:xs) = notElem x xs && isUnique xs

checkNonTerminal :: Rule -> Bool
checkNonTerminal (_, rhsList) = 
    let firstChars = map head rhsList
        allTerminals = all isLower firstChars
        allDifferent = isUnique firstChars
    in allTerminals && allDifferent

isKorenyakHopcroft :: [Rule] -> Bool
isKorenyakHopcroft grammar = all checkNonTerminal grammar

runTestCase :: String -> [Rule] -> IO ()
runTestCase name grammar = do
    putStrLn $ "=== " ++ name ++ " ==="
    putStrLn $ "Вхідні правила: " ++ show grammar
    if isKorenyakHopcroft grammar
        then putStrLn "РЕЗУЛЬТАТ: ТАК (Граматика відповідає умовам)\n"
        else putStrLn "РЕЗУЛЬТАТ: НІ (Умови не виконано: дублі або нетермінал на початку)\n"

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8
    
    putStrLn "---ТЕСТУВАННЯ ГРАМАТИК КОРЕНЯКА-ХОПКРОФТА ---\n"

    runTestCase "Тест 1:" 
                [('S', ["aA", "b"]), ('A', ["cS", "d"])]

    runTestCase "Тест 2:" 
                [('S', ["xA", "xB"])]

    runTestCase "Тест 3:" 
                [('S', ["Ax"]), ('A', ["a"])]

    runTestCase "Тест 4:" 
                [('S', ["xA", "y"]), ('A', ["zS", "zB"])]