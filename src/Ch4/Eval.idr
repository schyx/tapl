module Ch4.Eval

import Ch4.Error
import Ch4.Term

singleStep : Term -> Either Error Term
singleStep (TermTernary TermTrue t2 t3) = Right t2
singleStep (TermTernary TermFalse t2 t3) = Right t3
singleStep (TermTernary t1 t2 t3) = do
  t1' <- singleStep t1
  pure $ TermTernary t1' t2 t3
singleStep (TermSucc t1) = do
  t1' <- singleStep t1
  pure $ TermSucc t1'
singleStep (TermPred TermZero) = Right TermZero
singleStep (TermPred t1@(TermSucc t2)) =
  if   isNumeric t2 then pure t2
  else                   do
    t1' <- singleStep t1
    pure $ TermPred t1'
singleStep (TermPred t1) = do
  t1' <- singleStep t1
  pure $ TermPred t1'
singleStep (TermIsZero TermZero) = Right TermTrue
singleStep (TermIsZero t1@(TermSucc nv1)) =
  if   isNumeric nv1 then Right TermFalse
  else                    do
    t1' <- singleStep t1
    pure $ TermIsZero t1'
singleStep (TermIsZero t1) = do
  t1' <- singleStep t1
  pure $ TermIsZero t1'
singleStep _ = Left TypeError

export
evaluate : Term -> Either Error Term
evaluate t =
  if   isValue t then Right t
  else                singleStep t >>= evaluate
