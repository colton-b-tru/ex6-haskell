import Control.Monad.Trans.Maybe
import Control.Monad.Trans.Reader
import Control.Monad.Trans.State
import Data.Maybe
import Control.Monad

main = do
        runMaybeT $ kadddr ['a'..'z']
kar :: Show a => [a] -> MaybeT IO a
kar xs = case xs of 
            [] -> MaybeT $ return Nothing                                  
            (x:xs) -> MaybeT $ do{putStrLn (show x); return $ Just x}

kdr :: Show a => [a] -> MaybeT IO [a] 
kdr xs = case xs of
            [] -> MaybeT $ return Nothing
            (x:xs) -> MaybeT $ do{putStrLn (show xs); return $ Just xs}
kadddr = kar <=< kdr <=< kdr <=< kdr

--2
type Parser a = StateT String Maybe a

item :: Parser Char
item = do { x <- get; put $ tail x; guard(x /= ""); return $ head x}

sat :: (Char -> Bool) -> Parser Char                                            
sat pred = do x <- item
              guard(pred x)
              return x

string :: String -> Parser String 
string (c:[]) = do sat (c ==)
                   return [c]
string (c:cs) = do sat (c ==)
                   string cs
                   return (c:cs)


--3 ask WILL GET GLOBAL STATE...but how do we get the result? runReaderT?
---strategy for item...
-- We know that our Parser' is a ReaderT whose result is a Parser
--So our strategy is to get the parser out and run (get) on the Parser we've extracted
--we can the proceed as we did with the first Parser combinators we wrote for this exercise

--runReaderT should pull a function out of the reader that we can use to get our Parser...we think.
--in the previous item, we were able to kick things off using get. That option isn't available to us here
--because we need to pull out the parser first.

type Dictionary = [String]
type Parser' a = ReaderT Dictionary (StateT String Maybe) a
--a
item' :: Parser' Char
item' = do
           c <- liftM item 
           ReaderT $ return c

--b
--sat' :: (Char -> Bool) Parser' Char
--sat' = undefined
--c
--string' :: String -> Parser' String
--string' = undefined

--d
--word' :: Parser' String 
--word' = undefined

--4
data Btree a = Leaf a | Fork (Btree a)  (Btree a) deriving Show

btree :: (Read a, Show a) => [a] -> String -> Btree a
btree = undefined 