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

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "--- Перевірка граматики Кореняка-Хопкрофта ---"
    putStrLn "Введіть кількість нетерміналів:"
    hFlush stdout
    nStr <- getLine
    let n = read nStr :: Int

    grammar <- readGrammar n
    
    if isKorenyakHopcroft grammar
        then putStrLn "РЕЗУЛЬТАТ: Так, це граматика Кореняка-Хопкрофта."
        else putStrLn "РЕЗУЛЬТАТ: Ні, умови не виконано (повтор перших символів або правило не з терміналу)."

readGrammar :: Int -> IO [Rule]
readGrammar 0 = return []
readGrammar n = do
    putStrLn "Введіть нетермінал (велика літера) та правила через пробіл (наприклад: A aB aC):"
    hFlush stdout
    line <- getLine
    let (nt:rules) = words line
    rest <- readGrammar (n - 1)
    return ((head nt, rules) : rest)