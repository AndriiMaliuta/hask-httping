{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module Main where

import Database.PostgreSQL.Simple
import Network.HTTP.Client
import Network.HTTP.Types.Status
import Control.Monad
import Data.Foldable
import Data.Convertible
import Data.Time.Clock.POSIX


data Page = Page { id :: Integer, 
                  title :: String, body :: String, 
                  space_key :: String ,
                  author_id :: Integer, 
                  created_at :: String, 
                  last_updated :: String,
                  parent_id :: Integer}

parseMy :: IO ()
parseMy = do
  manager <- newManager defaultManagerSettings
  request <- parseRequest "http://httpbin.org/get"
  resp <- httpLbs request manager

  print (statusMessage (responseStatus resp )) 


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
