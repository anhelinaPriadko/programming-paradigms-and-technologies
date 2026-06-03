import System.IO

safeLog10 :: Double -> Maybe Double
safeLog10 x | x > 0 = Just (logBase 10 x)
            | otherwise = Nothing

safeSqrt :: Double -> Maybe Double
safeSqrt x | x >= 0 = Just (sqrt x)
           | otherwise = Nothing

safeDiv :: Double -> Double -> Maybe Double
safeDiv a b | b /= 0 = Just (a / b)
            | otherwise = Nothing

u1 :: Double -> Maybe Double
u1 x = do
    lx <- safeLog10 x
    safeDiv 1 (10 * x + lx)

u2 :: Double -> Maybe Double
u2 x = do
    lx <- safeLog10 x
    val <- safeSqrt (10 + lx)
    safeDiv 1 val

u3 :: Double -> Maybe Double
u3 x = safeSqrt (x**2 - 1)

comp1Do :: Double -> Maybe Double
comp1Do x = do
    res3 <- u3 x
    res2 <- u2 res3
    u1 res2

comp1Monad :: Double -> Maybe Double
comp1Monad x = u3 x >>= u2 >>= u1

v :: Double -> Double -> Maybe Double
v x n = do
    ln <- safeLog10 n
    safeSqrt (x**2 - ln)


comp2Do :: Double -> Maybe Double
comp2Do x = do
    arg1 <- u1 x
    arg2 <- u2 x
    v arg1 arg2

comp2Monad :: Double -> Maybe Double
comp2Monad x = u1 x >>= \a1 -> u2 x >>= \a2 -> v a1 a2

main :: IO ()
main = do
    hSetEncoding stdout utf8
    hSetEncoding stdin utf8

    putStrLn "--- Лабораторна робота №5: Тестування Maybe-функцій ---"

    putStrLn "Введіть значення x (аргумент для унарних функцій):"
    hFlush stdout
    inputX <- getLine
    let x = read inputX :: Double

    putStrLn "Введіть значення n (аргумент для бінарної функції v):"
    hFlush stdout
    inputN <- getLine
    let n = read inputN :: Double

    putStrLn "\n========================================================"
    
    putStrLn "1. Результати унарних функцій (n=10):"
    putStrLn $ "   u1(x) = " ++ show (u1 x)
    putStrLn $ "   u2(x) = " ++ show (u2 x)
    putStrLn $ "   u3(x) = " ++ show (u3 x)

    putStrLn "\n2. Суперпозиція u1(u2(u3(x))):"
    putStrLn $ "   З використанням do-нотації:     " ++ show (comp1Do x)
    putStrLn $ "   Без використання do-нотації:    " ++ show (comp1Monad x)

    putStrLn $ "\n3. Бінарна функція v(x, n) при n=" ++ show n ++ ":"
    putStrLn $ "   v(x, n) = " ++ show (v x n)

    putStrLn "\n4. Суперпозиція v(u1(x), u2(x)):"
    putStrLn $ "   З використанням do-нотації:     " ++ show (comp2Do x)
    putStrLn $ "   Без використання do-нотації:    " ++ show (comp2Monad x)
    
    putStrLn "========================================================\n"