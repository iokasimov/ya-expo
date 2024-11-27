{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE MagicHash #-}
module Ya.Expo.Instances where

import Ya

import "base" Data.Eq
import "base" Text.Show

import qualified "ghc-prim" GHC.Prim as GHC (State#, RealWorld)
import qualified "ghc-prim" GHC.Types as GHC (IO (IO))

deriving instance Eq i => Eq (I i)
deriving instance (Eq l, Eq r) => Eq (l `LM` r)
deriving instance (Eq l, Eq r) => Eq (l `ML` r)
deriving instance Eq Void

deriving instance Show i => Show (I i)
deriving instance (Show l, Show r) => Show (l `LM` r)
deriving instance (Show l, Show r) => Show (l `ML` r)
deriving instance (Show l, Show r) => Show (U_I_II LM l r)
deriving instance (Show l, Show r) => Show (U_I_II ML l r)
deriving instance (Show l, Show r) => Show (U_II_I ML r l)
deriving instance (Show l, Show r) => Show (U_II_I LM r l)
deriving instance Show Void

instance Mapping Straight Straight Arrow Arrow GHC.IO GHC.IO
 where mapping = rewrap / \m x -> bindIO x (returnIO `fio` m)

instance Mapping Straight Straight Arrow Arrow (GHC.IO `T'TT'I` L () GHC.IO) GHC.IO
 where mapping = rewrap / \m (T'TT'I ioio) -> bindIO (bindIO ioio unwrap) (returnIO `fio` m)

instance Mapping Straight Straight Arrow Arrow (Day Straight Arrow LM LM GHC.IO GHC.IO i ii) GHC.IO
 where mapping = rewrap / \from (U_V_UU_UUU_UUUU_T'TT'I_II_III (These (These x y) (U_I_II f))) -> bindIO x (\xx -> from `compose` f `compose` These xx `fo` y)

instance Mapping Straight Straight Arrow Arrow (Straight Arrow ()) GHC.IO
 where mapping = rewrap / \from (U_I_II f) -> returnIO `ha` from `li` f ()

returnIO :: a -> GHC.IO a
returnIO x = GHC.IO (\ s -> (# s, x #))

bindIO :: GHC.IO a -> (a -> GHC.IO b) -> GHC.IO b
bindIO (GHC.IO m) k = GHC.IO (\s -> case m s of (# new_s, x #) -> unIO (k x) new_s)

unIO :: GHC.IO a -> (GHC.State# GHC.RealWorld -> (# GHC.State# GHC.RealWorld, a #))
unIO (GHC.IO x) = x

pattern IO :: GHC.IO e -> L () GHC.IO e
pattern IO e = Labeled e
