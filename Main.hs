{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module Main where

import Database.PostgreSQL.Simple
import Control.Monad
import Data.Foldable
import Data.Convertible
import Data.Time.Clock.POSIX
import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Simple


data Page = Page { id :: Integer, 
                  title :: String, body :: String, 
                  space_key :: String ,
                  author_id :: Integer, 
                  created_at :: String, 
                  last_updated :: String,
                  parent_id :: Integer}


parseMy :: IO ()
parseMy = do
  -- https://hackage.haskell.org/package/http-client-0.7.13.1/docs/Network-HTTP-Client.html#t:Response
  let wikiUrl = "http://en.wikipedia.org/wiki/Main_Page"
  response <- httpLBS "http://httpbin.org/get"
  putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)
  print $ getResponseHeader "Content-Type" response
  L8.putStrLn $ getResponseBody response


get_pages_psql :: IO ()
get_pages_psql = do
  conn <- connectPostgreSQL "host=167.235.52.214 dbname=wiki1 user=dev password="
  pages :: [(String, String)]  <- query_ conn "select title, space_key from pages"  
  mapM_ print pages   
  --for_ [1..10] (print (pages !! 2)
  --for_ pages $ print $ show filterPages
    --where filterPages page = 4 `elem` (fst page)
  

main :: IO ()
main = do
  parseMy
