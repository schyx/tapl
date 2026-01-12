= Chapter 2: Mathematical Preliminaries

2.2.6) Note that $R'$ is reflexive by definition. To show that it is the smallest possible reflexive relation containing
  $R$, assume we had another relation, $S$, that is smaller and reflexive. Then, there must be a pair $(x, y) in R'
  \\ S$. By construction, $(x, y) in R$ or $x = y$. If $(x, y) in R$, then $R subset.neq S$. Otherwise if $x = y$, then
  $S$ does not contain all reflexive relations. Either way, we have a contradiction.

2.2.7) We show this in the following two steps:
  - We first show that $R^+$ is indeed transitive. Assume that there exists some $(s, t), (t, u) in R^+$. Because $R^+$
    is the union of $R_i$ over all $i$, there must be some $i in NN$ where $(s, t), (t, u) in R_i$. Then by
    construction, $(s, u) in R_(i + 1) subset R^+$, showing transitivity.
  - Next assume that there exists some relation $S$ that contains $R$ and is transitive. We show that, by induction on
    $i$, $S supset.eq R_i$ for all $i$. If $S subset.neq R = R_0$, then we have an immediate contradiction as $S$ must
    contain $R$. Then, say that $S$ contains $R_n$. Then, since $R_(n+1)$ is constructed from $R_n$ by adding only the
    pairs which are one step away by transitivity, $S$ being transitive and containing $R_n$ implies that $R_(n+1)
    subset.eq S$. Thus, $R^+ subset.eq S$, showing that $R^+$ is the smallest transitive closure of $R$.

2.2.8) Let $R^!$ be the transitive closure of $R'$. Then, $R^!$ is both reflexive and transitive, and contains $R$. We
  show that $P$ is a predicate that is preserved by $R^!$, and because $R^* subset.eq R^!$, this implies that $P$ is
  preserved by $R^*$ as well. Note that $P$ is definitely preserved by $R'$ as $P(x) => P(x)$. Thus, it suffices to
  show that for all $i in NN$, $P$ is preserved by $R_i^'$.

       For $i = 0$, $R'_0 = R'$, so this case is trivially true. Let us assume that $P$ is preserved by $R'_i$, and
       then show that $P$ is preserved by $R'_(i + 1)$. The only elements we need to consider are those added to $R'_i$:
       the elements $(s, u)$ where both $(s, t)$ and $(t, u)$ are elements of $R'_i$. However, $(s, t) in R'_i$ means
       $P(s) <=> P(t)$, and similarly $(t, u) in R'_i$ shows us that $P(t) <=> P(u)$. Thus, $P(s) <=> P(u)$ means that
       $R'_(i+1)$ preserves $P$ as well. Every element of $R^!$ is an element of some $R_i$, so we conclude that $R^!$
       preserves $P$.
