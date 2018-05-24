# item.hsp


## [ ] 運勢を維持するエンチャントが付いた装備を食べると落ちる問題
36 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/19 11:52:34 ID:ypI9MVdS
運勢維持食バグ 再根124749行下にif ( var_1277 != 19 ) {}を追加
魔力制御不具合 >>26
PC死亡タイミング >>27
PC死亡スポットライト >>32
自宅(洞窟)軟禁バグ >>33

未解決？ >>22-24 >>29

公式フォーラムに併せて勝手にまとめた
安価制限のため多重になり失礼

37 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/19 17:45:05 ID:p7Ex0SK2
こっちで書くけど運勢維持は「運勢の成長」ってバフが無いからみたい
追加してやればアイコン無いけどちゃんと働く、けど運だけわざと除外した可能性もある
ちなみに運勢にも潜在もあるし運勢装備食えば固定でない経験も入るはず

食べた物に付与されていたエンチャントにより適用される効果の修正
　「運勢を維持する」が付与された生もの製の武具を食べると落ちる
　対処
　item.hsp 1197行目
　　if enc2=encSustain{をif &#40;(enc2=encSustain)&(enc!rsLUC)){に変更する事で
　　「運勢を維持する」によって成長期が発生しないように対処できる
　※運の成長率が0%なのが問題？運に成長率を設定するのとどちらが良いか？

## [x] 生もの製の武器を食べたときのメッセージがおかしい問題
910 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/12(火) 13:20:58.67 ID:xxwKthJG
oreで軽いバグ？報告
食用ＡＦで魅力１魔力１増加の手袋食べた時の表示が、「衰えた」になっている
経験置はちゃんと増加していた

公式1.22でも起こるバグ
item.hsp 1193行目
			skillExp enc,cc,calcEncAttb(iEncP(cnt,ci))*100*(1+(cc!=pc)*5)
			if sync(cc):if iEncP(cnt,ci)>=0:txt lang(name(cc)+"の"+skillName(enc)+"は発達した。",name(cc)+his(cc)+" "+skillName(enc)+" develops."):else:txt lang(name(cc)+"の"+skillName(enc)+"は衰えた。",name(cc)+his(cc)+" "+skillName(enc)+" deteriorates.")
↓
			skillExp enc,cc,calcEncAttb(iEncP(cnt,ci))*100*(1+(cc!=pc)*5)
			if sync(cc):if calcEncAttb(iEncP(cnt,ci))>=0:txt lang(name(cc)+"の"+skillName(enc)+"は発達した。",name(cc)+his(cc)+" "+skillName(enc)+" develops."):else:txt lang(name(cc)+"の"+skillName(enc)+"は衰えた。",name(cc)+his(cc)+" "+skillName(enc)+" deteriorates.")


## [x] 生もの製の生きている武器に料理ランク補正がかかる問題
料理ランクと生きている武器の経験値は同じ変数inv(26,)で管理されているので
生もの製の生きている武器を食べると最大で料理ランク100相当の満腹度補正がかかる
気になるなら生きている武器ビットを使って回避しておく

## [x] 食べ過ぎフラグが機能していない問題
565 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 10:11:39.97 ID:rMmy3Wy1
食事時の体重増加も満腹度増やした後に持ってこないといけない気がするな


満腹度増やす前に満腹度の判定をしているのでmodweightに食過ぎフラグが送られない
ただし、この修正を行うとやたらとキャラクターが太るので要調整


item.hsp 1086行目
 	if nutrition>=3000:if (rnd(10)=0)or(cHunger(cc)>=hungerBloated):modWeight cc,rnd(3)+1,cHunger(cc)>=hungerBloated
 
	cHunger(cc)+=nutrition
↓
 	cHunger(cc)+=nutrition
	if nutrition>=3000:if (rnd(10)=0)or(cHunger(cc)>=hungerBloated):modWeight cc,rnd(3)+1,cHunger(cc)>=hungerBloated

## [ ] 固定AFの冒険者交換によりランダムAFが増殖する問題

125 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/24(木) 20:04:51.68 ID:z2dgVO5m [3/3]
固定AFの冒険者交換によるランダムAF増殖修正

オリジナルソース
　item.hsp 21行目
　　iQuality(ci)をiQuality(ci@)に修正

逆コンパイルソース(公式Ver1.22開発版)
　122334行目
　　if ( inv(4, prm_930) != 6 ) {
　　を
　　if ( inv(4, ci) != 6 ) {
　　に修正

固定AF交換の問題について補足
~>>44だけの修正だと固定AFの重複所持ができてしまう可能性があるので
goto *label_1569する前にinv(0, ci) = 0しておくといい気がした

## [x] 盗賊団の頭領の落とす交易品の数がおかしい問題
405 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/01(金) 04:42:11.55 ID:tns7sz5b [4/4]
これも多分まずいなー

盗賊団の頭領が想定と違う個数の戦利品をドロップする可能性がある

item.hsp 381行目
行頭に
noStack=true:
を追加

逆根
123112行目のすぐ上に
nostack = 1
を追加

## [x] ブルーカプセルドラッグが落ちない問題
61 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/14 21:05:10 ID:lqENsSR/
噂話に出るのにブルーカプセルドラッグが出ないのはバグ？

62 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/14 21:13:19 ID:1mSce1VV
うん、バグ(スペルミス)

オリジナル
item.hsp 359行目
　idCupsule -> idCapsule

逆コンパイル
123068行目
　idcupsule -> 771

で「盗賊団の～」から出るようになるはず

## [x] 終焉の書が生成されない問題
アイテム生成処理のところで古書物の内容を決定する部分は
inv(25, ci) = rnd(rnd(limit(objlv / 2, 1, 14)) + 1)　となっているが、
これだと終焉の書が出ないため14ではなく15にする

