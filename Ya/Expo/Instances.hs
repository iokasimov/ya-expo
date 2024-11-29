{-# LANGUAGE UnboxedTuples #-}
{-# LANGUAGE MagicHash #-}
module Ya.Expo.Instances where

import Ya

import "base" Data.Eq
import "base" Text.Show

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
