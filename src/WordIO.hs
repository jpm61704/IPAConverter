module WordIO
    (
        printListOfTuples,
        convertTupleListToCSVString,
        getWords,
        putWords
    ) where

import Data.List.Split

printListOfTuples :: [(String, String)] -> IO ()
printListOfTuples ((str1, str2):xs) = do
    putStrLn (str1 ++ ", " ++ str2)
    printListOfTuples xs
    return ()
printListOfTuples [] = return ()

convertTupleListToCSVString :: [(String, String)] -> String
convertTupleListToCSVString [] = ""
convertTupleListToCSVString ((ger,pron):xs) = ger ++ "," ++ pron ++ "\n" ++ (convertTupleListToCSVString xs)

getWords :: FilePath -> IO [String]
getWords f = do
    contents <- readFile f
    return $ filter (not . null) $ (splitOn "\n") $ filter ((/=) '\r') contents

putWords :: [(String, String)] -> FilePath -> IO ()
putWords wrds f = writeFile f str
    where str = convertTupleListToCSVString wrds
