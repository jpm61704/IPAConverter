module Main where

import Lib


germ :: [String]
germ = ["stehen", "graben", "vier", "aufstehen", "arbeiten", "Arbeit"]

printListOfTuples :: [(String, String)] -> IO ()
printListOfTuples ((str1, str2):xs) = do
    putStrLn (str1 ++ ", " ++ str2)
    printListOfTuples xs
    return ()
printListOfTuples [] = return ()

main :: IO ()
main = do
    x <- getPronFromXML germ
    printListOfTuples x
    return ()
