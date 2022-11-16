{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module Main where

import Database.PostgreSQL.Simple
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)
import Control.Monad
import Data.Foldable
import Data.Convertible


parseMy :: IO ()
parseMy = do
  manager <- newManager defaultManagerSettings
  request <- parseRequest "http://httpbin.org/get"
  resp <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus resp)
  print $ responseBody resp 


get_pages_psql :: IO ()
get_pages_psql = do
  conn <- connectPostgreSQL "host=167.235.52.214 dbname=wiki1 user=dev password=possum!"
  pages :: [(String, String)]  <- query_ conn "select title, space_key from pages"  
  mapM_ print pages   
  --for_ [1..10] (print (pages !! 2)
  --for_ pages $ print $ show filterPages
    --where filterPages page = 4 `elem` (fst page)
  

main :: IO ()
main = do
  parseMy
