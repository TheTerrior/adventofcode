import System.IO
import Data.List ( sort )


-- Given a set of lines, returns the sorted sums of the groups of calories
groupCalories :: [String] -> [Int]
groupCalories lis = reverse . sort $ groupTail lis [] []
    where
        groupTail :: [String] -> [Int] -> [Int] -> [Int]
        groupTail [] [] accum = accum
        groupTail [] buf accum = accum ++ [sum buf]
        groupTail (x:xs) buf accum
            | x == "" = groupTail xs [] (accum ++ [sum buf])
            | otherwise = groupTail xs (buf ++ [read x :: Int]) accum


-- Returns the first three elements from the given list
topThree :: [Int] -> [Int]
topThree (x:y:z:xs) = [x, y, z]
topThree _ = []


-- Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let all_lines = lines contents
    let res = groupCalories all_lines
    print $ head res
    print $ sum $ topThree res
