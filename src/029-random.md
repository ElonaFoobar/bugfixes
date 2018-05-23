# random.hsp


## rnd関数の仕様
[[HSP命令講座 <rnd関数>>http://lhsp.s206.xrea.com/command/rnd.html]]
>　rnd(数値)
>　第１パラメータに乱数発生範囲を指定します。指定できる数値は「1～32768」です。たとえば、１００を指定したならば、「０～９９」の範囲でバラバラな数値が返ります。

rnd()の引数が32768を超えても、rnd(32768)と同様に扱われる。
ゴールドベルのドロップ金貨や武器の属性追加ダメージなど、
elonaではいくつもの処理でrnd()の引数が32768を超える場面がある。

## rnd()の引数が32768を超える処理

## ex_rand命令の仕様
[[D.N.A.Softwaresの旧ページ>http://web.archive.org/web/*/http://dna-softwares.go.to/]]でスクリプトとマニュアルがダウンロードできる。

32768を超える数値を扱える他、メルセンヌツイスタを用いた精度の高い乱数を発生させることができる。
elonaではrnd関数に加え、一部ex_rand命令が使用されている。
#br
elonaでex_rand命令が使用されているのは
-ランダムなアイテムを生成する処理
-ランダムなキャラクターを生成する処理
-ランダムなエンチャントを選択する処理
-ランダムな発動エンチャントを選択する処理
-ランダムな魚を生成する処理
の5つだけである。

## 乱数が意図通りに固定されていない問題
534 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/23(土) 23:02:33.98 ID:K4vO9SMw
結局noa猫に聞いてきたよー
//・ブラックマーケットの商品数に上限が無いのは願いのアイテム数がおかしいのと同様。他と同じで80上限が正しい
//*shop_restock(*label_2265)のif p>80:p=80みたいなのを一個後の処理と入れ替え

・リトシス報酬ではリロっても変化しないのが本来の意図
エンチャ関連の二ヶ所ex_rand p,sum→p=rnd(sum)に変えると乱数固定の対象になる。それか乱数固定時に一緒にex_randomizeもするか
逆コンだとexrand_rnd p@～みたいになってる所な
俺には判らんけどex_randじゃないと何か不都合あったりする？

べ、別にBF版を陥れようとしてる訳じゃないんだからねっ
リロだリロだっていうのが前々からちょっと気に食わなかっただけ

リトルシスター報酬・宝箱・ガロクの槌・使用人の雇用で、ex_randomizeがされていない
chat.hsp 2019行目
        repeat maxDB
        if cnt=idTrait:continue
        randomize gDay+cnt
        f=false
        if itemMemory(0,cnt) : f=true
        if cnt=idMagicFruit :if sqKamikaze>=1000:f=true
        if cnt=idHeroCheese :if sqVein>=1000:f=true
        if cnt=idHappyApple :if sqMother>=1000:f=true
        
        if f:flt cLevel(pc)*3/2,calcFixLv(fixGood) :item_create -1,cnt :if stat=true:if iQuality(ci)<fixGreat :iNum(ci)=0
        randomize
        loop
↓
        repeat maxDB
        if cnt=idTrait:continue
        lockRand gDay+cnt
        f=false
        if itemMemory(0,cnt) : f=true
        if cnt=idMagicFruit :if sqKamikaze>=1000:f=true
        if cnt=idHeroCheese :if sqVein>=1000:f=true
        if cnt=idHappyApple :if sqMother>=1000:f=true
        
        if f:flt cLevel(pc)*3/2,calcFixLv(fixGood) :item_create -1,cnt :if stat=true:if iQuality(ci)<fixGreat :iNum(ci)=0
        unlockRand
        loop
action.hsp 979行目
  randomize iParam3(ri)
↓
  lockRand iParam3(ri)

action.hsp 1014行目
  randomize
↓
  unlockRand

proc.hsp 3014行目
  randomize iParam1(efCiBk)
  encAdd ci,randomEnc(randomEncLv(egoLv)),randomEncP()+(fixLv=fixGod)*100+(iBit(iUltimate,ci)=true)*100,20-(fixLv=fixGod)*10-(iBit(iUltimate,ci)=true)*20
  loop
  randomize
↓
  lockRand iParam1(efCiBk)
  encAdd ci,randomEnc(randomEncLv(egoLv)),randomEncP()+(fixLv=fixGod)*100+(iBit(iUltimate,ci)=true)*100,20-(fixLv=fixGod)*10-(iBit(iUltimate,ci)=true)*20
  loop
  unlockRand

map.user.hsp 393行目
  if develop=false:randomize gDay+cnt
↓
  if develop=false:randomize gDay+cnt
map_user.hsp 412行目
  randomize
↓
  unlockRand

## 生きている武器でエンチャントリストを見ると乱数が固定される問題
引数なしのex_randomizeは乱数を固定してしまう

init.hsp 4268行目
  #define global unlockRand randomize:ex_randomize
↓
  #define global unlockRand randomize:ex_randomize_time

