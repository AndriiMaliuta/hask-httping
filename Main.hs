{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.PostgreSQL.Simple
import Network.HTTP.Client
import Network.HTTP.Types.Status (statusCode)


main :: IO ()
main = do
  --conn <- connectPostgreSQL ""
  --putStrLn "Hello, Haskell!"
 
  manager <- newManager defaultManagerSettings
  request <- parseRequest "http://httpbin.org/get"
  resp <- httpLbs request manager

  putStrLn $ "The status code was: " ++ (show $ statusCode $ responseStatus resp)
  print $ responseBody resp
