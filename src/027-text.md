# text.hsp


## [ ] 収穫依頼の報酬計算がオーバーフローする問題

### 概要

収穫依頼の報酬の計算においてオーバーフローが起こる。

収穫依頼のボーナス計算にバグあるね。報酬11317gp ノルマ132.5sの依頼で201s収穫したのに11317gpだった。同等の他の依頼で170収穫した時はちゃんと増えたから上限ではなさそう。 -- 2011-04-15 (金) 05:07:49
↑追記　140の依頼で250収穫してもボーナスがなかった。セリフは「色をつけた」になってる。200以上収穫したらダメなのかもしれない。 -- 2011-04-15 (金) 19:13:05

