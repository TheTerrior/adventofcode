import System.IO
import qualified Data.List as List
import Data.Maybe


-- | Splits a line into four integers
splitToTuple :: [Char] -> (Int, Int, Int, Int)
splitToTuple line = do
    let ind = fromJust $ List.elemIndex ',' line
    let (x,comma:y) = List.splitAt ind line
    let indx = fromJust $ List.elemIndex '-' x 
    let (x0,dash0:y0) = List.splitAt indx x
    let indy = fromJust $ List.elemIndex '-' y 
    let (x1,dash1:y1) = List.splitAt indy y 
    (read x0 :: Int, read y0 :: Int, read x1 :: Int, read y1 :: Int)


-- | Returns whether one set of coordinates fully contains the other
isContained :: (Int, Int, Int, Int) -> Bool
isContained (x, y, z, a) = (x <= z && y >= a) || (z <= x && a >= y)


-- | Returns whether the coordinates overlap at all
isOverlapping :: (Int, Int, Int, Int) -> Bool
isOverlapping (x, y, z, a) = (x <= a && y >= z) || (z <= y && a >= x)


-- | Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let all_lines = lines contents
    let ints = map splitToTuple all_lines
    print $ length $ filter isContained ints
    print $ length $ filter isOverlapping ints

