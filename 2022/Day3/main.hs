import System.IO
import qualified Data.List as List
import qualified Data.Set as Set
import Data.Char (ord)


-- | Splits a line into two halves
splitLine :: [Char] -> ([Char], [Char])
splitLine line = splitAt(div (length line) 2) line


-- | Takes in two strings and finds the difference (single char)
findDifference :: [Char] -> [Char] -> Char
findDifference word word1 = do
    let set = Set.fromList word
    let (x:xs) = filter (\x -> elem x set) word1
    x


-- | Converts a char to its integer representation
toInt :: Char -> Int
toInt c = do
    let raw = ord c
    if raw > 90  -- A-Z come before a-z, Z is 90
        then (raw - 96) -- a should be 1
        else (raw - 38) -- A should be 27


-- | Groups all lines into groups of 3
groupThrees :: [[Char]] -> [([Char], [Char], [Char])] -> [([Char], [Char], [Char])]
groupThrees (x:y:z:xs) accum = groupThrees xs (accum ++ [(x, y, z)])
groupThrees _ accum = accum


-- | Finds the common character in the strings
findCommon :: ([Char], [Char], [Char]) -> Char
findCommon (x, y, z) = do
    let set = Set.fromList x
    let set1 = Set.fromList $ filter (\x -> elem x set) y --contains all strings common between x and y
    let (x:xs) = filter (\x -> elem x set1) z
    x


-- | Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let all_lines = lines contents
    let split_lines = map splitLine all_lines
    let diff_chars = map (\(x, y) -> findDifference x y) split_lines
    let vals = map toInt diff_chars
    print $ sum vals
    let comm_chars = map findCommon $ groupThrees all_lines []
    let vals1 = map toInt comm_chars 
    print $ sum vals1


