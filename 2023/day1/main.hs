import System.IO
import Data.List
import Data.Char
import Data.Maybe


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
        names = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

        getFirst :: String -> Int
        getFirst str
            | elem (head str) "0123456789" = digitToInt (head str)
            | elem str names = fromJust $ elemIndex str names
            | otherwise = getFirst (tail str)

        getSecond :: String -> Int
        getSecond str
            | elem (last str) "0123456789" = digitToInt (last str)
            | elem str names = fromJust $ elemIndex str names
            | otherwise = getSecond (init str)


main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let singlelines = lines contents
    print $ parseOne singlelines
    print $ parseTwo singlelines


