import System.IO
import Control.Monad
import Data.Binary (Binary(putList))
import Control.Monad.Trans.Accum (accum)






-- Split a list of elements into groups of 3
toThrees :: [a] -> [[a]] -> [[a]]
toThrees (x:y:z:xs) accum = toThrees xs $ [x, y, z] : accum
toThrees xs accum = accum

-- Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let contentLines = lines contents
    let test = toThrees contentLines []
    print test
    --putStrLn contents

