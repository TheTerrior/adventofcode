import System.IO
import Control.Monad


-- Maps a set of lines to simple tuples representing games
linesToGames :: [String] -> [(Char,Char)]
linesToGames = map (\[x,y,z] -> (x,z))


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


-- Calculate the score of a single game
gameScoreNew :: (Char,Char) -> Int
gameScoreNew (x,y)
    | x == 'A' && y == 'X' = 3 -- 3 + 0
    | x == 'A' && y == 'Y' = 4 -- 1 + 3
    | x == 'A' && y == 'Z' = 8 -- 2 + 6

    | x == 'B' && y == 'X' = 1 -- 1 + 0
    | x == 'B' && y == 'Y' = 5 -- 2 + 3
    | x == 'B' && y == 'Z' = 9 -- 3 + 6

    | x == 'C' && y == 'X' = 2 -- 2 + 0
    | x == 'C' && y == 'Y' = 6 -- 3 + 3
    | x == 'C' && y == 'Z' = 7 -- 1 + 6

    | otherwise = 0


-- Take in a list of games and returns a score
linesToScore :: [String] -> Int
linesToScore xs = foldr ((+) . gameScore) 0 $ linesToGames xs


-- Take in a list of games and returns a score
linesToScoreNew :: [String] -> Int
linesToScoreNew xs = foldr ((+) . gameScoreNew) 0 $ linesToGames xs


-- Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let contentLines = lines contents
    print . linesToScore $ contentLines
    print . linesToScoreNew $ contentLines

