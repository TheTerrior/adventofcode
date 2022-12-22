import System.IO
import Control.Monad






-- Split a list of elements into groups of 3
--processThrees :: [a] -> [(a, a)] -> [(a, a)]
--processThrees :: [[a]] -> [((a, a), (a, a), (a, a))] -> [((a, a), (a, a), (a, a))]
--processThrees (line0:line1:line2:xs) accum = processThrees xs $ accum ++ [(lineToGame line0, lineToGame line1, lineToGame line2)]
--processThrees xs accum = accum

--lineToGame :: [a] -> (a, a)
--lineToGame [x,y,z] = (x,z)


-- Maps a set of lines to simple tuples representing games
linesToGames :: [String] -> [(Char,Char)]
linesToGames xs = map (\[x,y,z] -> (x,z)) xs


-- Calculate the score of a single game
gameScore :: (Char,Char) -> Int
gameScore (x,y)
    | x == 'A' && y == 'X' = 4 -- 1 + 3
    | x == 'A' && y == 'Y' = 8 -- 2 + 6
    | x == 'A' && y == 'Z' = 3 -- 3 + 0

    | x == 'B' && y == 'X' = 1 -- 1 + 0
    | x == 'B' && y == 'Y' = 5 -- 2 + 3
    | x == 'B' && y == 'Z' = 9 -- 3 + 6

    | x == 'C' && y == 'X' = 7 -- 1 + 6
    | x == 'C' && y == 'Y' = 2 -- 2 + 0
    | x == 'C' && y == 'Z' = 6 -- 3 + 3

    | otherwise = 0


-- Take in a list of games and returns a score
linesToScore :: [String] -> Int
linesToScore xs = foldr ((+) . gameScore) 0 $ linesToGames xs


-- Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let contentLines = lines contents
    let test = linesToScore contentLines
    print test
    --putStrLn contents

