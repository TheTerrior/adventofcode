import System.IO
import Data.List



-- | Takes the input and sorts it into the start state or the actions
sortInput :: ([[Char]], [[Char]]) -> [Char] -> ([[Char]], [[Char]]) 
sortInput (state, actions) input
    | isPrefixOf "move" input = (state, actions ++ [input])
    | input == "" = (state, actions) --remove blank lines
    | isPrefixOf " 1" input = (state, actions) --remove indicators
    | otherwise = (state ++ [input], actions)


-- | Takes a raw actions and simplifies its form to (source, destination, amount)
simplifyAction :: [Char] -> (Int, Int, Int)
simplifyAction action = do
    let (move:num:from:source:to:destination:xs) = words action
    (read source :: Int, read destination :: Int, read num :: Int)


-- | Prepares the input for conversion
prepareInput :: [Char] -> [Char]
prepareInput input = prepareHelper input [] 1 
-- | Helper for prepareInput
prepareHelper :: [Char] -> [Char] -> Int -> [Char]
prepareHelper [] accum _ = accum
prepareHelper (x:xs) accum include
    | include == 0 = prepareHelper xs (accum ++ [x]) 3 
    | otherwise = prepareHelper xs accum (include - 1) 


-- | Takes one line of input and prepares columns accordingly
prepareColumns :: [Char] -> [[Char]] -> [[Char]]
prepareColumns [] cols = cols
prepareColumns (x:xs) cols
    | x == ' ' = prepareColumns xs (cols ++ [[]]) --ensure spaces aren't added
    | otherwise = prepareColumns xs (cols ++ [[x]])


-- | Takes the input and convers it into a usable state
generateState :: [[Char]] -> [Char] -> [[Char]]
generateState (c:cs) (x:xs)
    | x == ' ' = c : generateState cs xs
    | otherwise = (c++[x]) : generateState cs xs
generateState _ _ = []


-- | Applies an action to the state recursively
applyAction :: [[Char]] -> (Int, Int, Int) -> [[Char]]
applyAction state (from, to, num)
    | num == 0 = state --if we're told to move 0 items, just return the state
    | otherwise = do
        let val = state!!(from-1)!!0 --get top of selected column
        let popped = applyList state (\(x:xs) -> xs) (from-1) --pop top value
        let pushed = applyList popped (\x -> val:x) (to-1)
        applyAction pushed (from, to, num - 1)  --recursion


-- | Applies bulk actions to the state
applyActionNew :: [[Char]] -> (Int, Int, Int) -> [[Char]]
applyActionNew state (from, to, num)
    | num == 0 = state --if we're told to move 0 items, just return the state
    | otherwise = do
        let (vals, _) = splitAt num (state!!(from-1)) --retrieves the vals to be moved
        let popped = applyList state (drop num) (from-1) --drop top values
        let pushed = applyList popped (\x -> vals ++ x) (to-1)
        pushed 


-- | Runs a given function on a list's ith element
applyList :: [a] -> (a -> a) -> Int -> [a]
applyList (x:xs) func index
    | index == 0 = (func x) : xs
    | index > 0 = x : (applyList xs func (index - 1))
    | otherwise = (x:xs)


-- | Retrieve the top item from each column
retrieveTops :: [Char] -> [Char] -> [Char]
retrieveTops accum (x:xs) = accum ++ [x]


-- | Main entry point
main :: IO ()
main = do
    handle <- openFile "input.txt" ReadMode
    contents <- hGetContents handle
    let all_lines = lines contents
    let (start, actions) = foldl sortInput ([], []) all_lines
    let simplified_actions = map simplifyAction actions
    let (first:rest) = map prepareInput start
    let cols = prepareColumns first []
    let start_state = foldl generateState cols rest
    let res = foldl applyAction start_state simplified_actions
    let tops = foldl retrieveTops [] res
    print tops
    let new_res = foldl applyActionNew start_state simplified_actions
    let new_tops = foldl retrieveTops [] new_res
    print new_tops

