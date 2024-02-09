import System.IO
import Data.List
import Data.Char


parseOne :: [String] -> Int
parseOne lines = foldr (\x acc -> acc + 10 * (getFirst x) + (getSecond x)) 0 lines
    where
        getFirst :: String -> Int
        getFirst str
            | elem (head str) "0123456789" = digitToInt (head str)
            | otherwise = getFirst (tail str)

        getSecond :: String -> Int
        getSecond str
            | elem (last str) "0123456789" = digitToInt (last str)
            | otherwise = getSecond (init str)


parseTwo :: [String] -> Int
parseTwo lines = foldr (\x acc -> acc + 10 * (getFirst x) + (getSecond x)) 0 lines
    where
        getFirst :: String -> Int
        getFirst str
            | elem (head str) "0123456789" = digitToInt (head str)
            | isPrefixOf "zero" str =  0
            | isPrefixOf "one" str =   1
            | isPrefixOf "two" str =   2
            | isPrefixOf "three" str = 3
            | isPrefixOf "four" str =  4
            | isPrefixOf "five" str =  5
            | isPrefixOf "six" str =   6
            | isPrefixOf "seven" str = 7
            | isPrefixOf "eight" str = 8
            | isPrefixOf "nine" str =  9
            | otherwise = getFirst (tail str)

        getSecond :: String -> Int
        getSecond str
            | elem (last str) "0123456789" = digitToInt (last str)
            | isSuffixOf "zero" str =  0
            | isSuffixOf "one" str =   1
            | isSuffixOf "two" str =   2
            | isSuffixOf "three" str = 3
            | isSuffixOf "four" str =  4
            | isSuffixOf "five" str =  5
            | isSuffixOf "six" str =   6
            | isSuffixOf "seven" str = 7
            | isSuffixOf "eight" str = 8
            | isSuffixOf "nine" str =  9
            | otherwise = getSecond (init str)
        

main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let singlelines = lines contents
    print $ parseOne singlelines
    print $ parseTwo singlelines


