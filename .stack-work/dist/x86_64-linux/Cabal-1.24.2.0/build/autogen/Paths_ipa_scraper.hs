{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_ipa_scraper (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/bin"
libdir     = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/lib/x86_64-linux-ghc-7.10.3/ipa-scraper-0.1.0.0-ILQXpElOcZW4qntRBRmnSz"
dynlibdir  = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/lib/x86_64-linux-ghc-7.10.3"
datadir    = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/share/x86_64-linux-ghc-7.10.3/ipa-scraper-0.1.0.0"
libexecdir = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/libexec"
sysconfdir = "/mnt/c/Users/Jack/Documents/Dev/haskell/ipa/ipa-scraper/.stack-work/install/x86_64-linux/lts-6.0/7.10.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ipa_scraper_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ipa_scraper_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ipa_scraper_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ipa_scraper_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ipa_scraper_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ipa_scraper_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
