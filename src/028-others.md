# Others


## [x] カジノで連勝するほどエーテル抗体の取得率が下がる問題
カジノ景品おまけのエーテル抗体の取得率修正
　カジノ景品のおまけで貰えるエーテル抗体の取得率が連勝数が４の時が最大で以降
　連勝するごとに下がっていく
　対処
　Noa氏への問い合わせの結果、「連勝すればするほど取得率が上がるように」が意図との
　ことだったので
　txtadv.hsp 737行目
　　if rnd(200)>(winRow*5+5)をif rnd(200)<(winRow*5+5)へ変更
　※エーテル抗体の取得難度が上がると思われるため要調整？

## [ ] ダンジョンで下り階段の前に帰還できる問題
ちょっと小耳に挟んだのですが、

レシマスの洞窟で上り階段を上がった直後、レシマスに帰還をすると、
なんと到達最下層の下り階段の目の前に帰還できるそうですよ！

冒険者 (2010-07-17 (土) 20:28:47)

裏技というか変な挙動なんで、動作を確認してバグ報告予定リストに入れてみた。 -- 2010-07-17 (土) 21:04:46
verはいくつだ -- 2010-07-17 (土) 21:41:42

map.func.hsp

## [x] 信仰が既に限界まで高まっているときに捧げものをするとご褒美フラグが立たない問題

処理の順だけ変えておく
god.hsp 6行目

 #deffunc modPiety int a
  if sPrayer(pc)*100<cPiety(pc){
    txt lang("あなたの信仰は既に限界まで高まっている。"," Your God becomes indifferent to your gift.")
    return false
    }
  if gGodRank=4 : if cPiety(pc)>=defGodGift3:gGodRank++:txtGod cGod(pc),txtGodLove
  if gGodRank=2 : if cPiety(pc)>=defGodGift2:gGodRank++:txtGod cGod(pc),txtGodLike
  if gGodRank=0 : if cPiety(pc)>=defGodGift1:gGodRank++:txtGod cGod(pc),txtGodLike
 
  cPiety(pc)+=a/(1+(gArea=areaShowHouse)*9)
  return true
↓
 #deffunc modPiety int a
  if gGodRank=4 : if cPiety(pc)>=defGodGift3:gGodRank++:txtGod cGod(pc),txtGodLove
  if gGodRank=2 : if cPiety(pc)>=defGodGift2:gGodRank++:txtGod cGod(pc),txtGodLike
  if gGodRank=0 : if cPiety(pc)>=defGodGift1:gGodRank++:txtGod cGod(pc),txtGodLike
 
  if sPrayer(pc)*100<cPiety(pc){
    txt lang("あなたの信仰は既に限界まで高まっている。"," Your God becomes indifferent to your gift.")
    return false
    }
  cPiety(pc)+=a/(1+(gArea=areaShowHouse)*9)
  return true


## [x] 捧げ物のエフェクトがPC以外に表示される問題

god.hsp 376行目
  call anime,(animeId=aniOffer)
↓
  call anime,(animeId=aniOffer,tc=pc)

## [x] 護衛依頼の報酬が正しく計算されていない問題

quest.hsp 168行目
    p=qMap(qParam1(rq))
↓
    p=qParam1(rq)

## [x] 暗記スキル未取得のとき、脳機械化の変異でスキルが上昇する問題

trait.hsp 550-551行目
    if sORG(rsMemorize,pc)=0:return false
を挿入


## [ ] 護衛依頼失敗時に護衛対象がマップ上に残り続けることがある問題

詳細な再現手順と現象については http://www.nicovideo.jp/watch/sm32556762 の 7:00頃を参照
動画はoomExであるが、v1.22でも発生することを確認済み
鼓舞などによって護衛依頼失敗時の大ダメージ(999,999)を耐えさせることで護衛対象者が生き残った場合、
扱いとしては対象者が死んだことになり依頼も失敗するが、画面上には残り続け、さらに話しかけるといった動作も行うことができる。
これ以外の簡単な再現方法として、ソースコードを書き換えてdmghp関数に渡すダメージ量を減らす、護衛対象のHPを999,999よりも大きくする、dmghpを呼び出さないようにする、といった方法がある。

以下擬似コード
 function 依頼失敗:
    if その依頼が護衛:
        show_message "あなたは護衛の任務を果たせなかった。"
        foreach 全ペット:
            if そのペットが護衛対象で、その依頼が今まさに失敗した依頼:
                護衛対象であるというフラグを折る
                if まだ生きている:
                    show_message "「時間切れだ。こうなったら...」"
                    999,999のダメージを与える
                強制的に殺す (*)
問題なのは(*)の箇所で、cdata(0, X)（Xはキャラクタ番号） をゼロにしているのだが、これだけでは完全に殺しきることができない。
Elonaにおいてキャラクタ番号はmap(X, Y, 1)（X、Yはマップの座標）でも参照されており、こちらもゼロにしておかないと
画面上の描写が残ったり、話しかけることができたりする。cdata(0, X)がゼロになっていてもメモリ上には存在しているので
cdata(0, X)がゼロでないかを確認しない処理ではキャラクタが残り続ける。逆に言えば、cdata(0, X)を確認する場合には
無効なキャラクタと判定される。これによって上述の動画に挙げられているような、動かない、マップ移動すると消えるといった
現象を説明することができる。すなわちこれらの処理ではcdata(0, X)が非ゼロかどうかを確認しているため、死んだキャラクタであると
正確に判断されている。

この問題はmap(X, Y, 1)を参照する箇所において参照先のキャラクタのcdata(0, X)がゼロでないかどうかを確認するという方法でも修正可能だが、
(*)の箇所で同時にmap(X, Y, 1)もゼロクリアしておく方が無難と考えられる。すなわち、
 cdata(0, tc) = 0
 cell_removechara cdata(1, tc), cdata(2, tc) ; 追加

この問題はキャラクタを強制的に殺す方法としてcdata(0, X) = 0を用いていることである。これだけではマップ上から消し去れないため、
関数を新たに定義して、cdata(0, X)のクリアとmap(X, Y, 1)のクリアを両方行わせるべきである。
なお、chara_vanquishがほぼ同様の動作をするがそれで良いかは未確認。
この件のように「必ず死ぬと思われる処理」の後に「cdata(0, X)のクリア」を行なっている箇所は他にリリーを
殺す処理がある。リリーを何らかの方法でダメージ(9,999)に耐えさせると同様の現象が発生することを確認している。



## [ ] rnd関数の仕様
[[HSP命令講座 <rnd関数>>http://lhsp.s206.xrea.com/command/rnd.html]]
>　rnd(数値)
>　第１パラメータに乱数発生範囲を指定します。指定できる数値は「1～32768」です。たとえば、１００を指定したならば、「０～９９」の範囲でバラバラな数値が返ります。

rnd()の引数が32768を超えても、rnd(32768)と同様に扱われる。
ゴールドベルのドロップ金貨や武器の属性追加ダメージなど、
elonaではいくつもの処理でrnd()の引数が32768を超える場面がある。

## [ ] ex_rand命令の仕様
[[D.N.A.Softwaresの旧ページ>http://web.archive.org/web/*/http://dna-softwares.go.to/]]でスクリプトとマニュアルがダウンロードできる。

32768を超える数値を扱える他、メルセンヌツイスタを用いた精度の高い乱数を発生させることができる。
elonaではrnd関数に加え、一部ex_rand命令が使用されている。

elonaでex_rand命令が使用されているのは
-ランダムなアイテムを生成する処理
-ランダムなキャラクターを生成する処理
-ランダムなエンチャントを選択する処理
-ランダムな発動エンチャントを選択する処理
-ランダムな魚を生成する処理
の5つだけである。

## [ ] 乱数が意図通りに固定されていない問題
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

## [x] 生きている武器でエンチャントリストを見ると乱数が固定される問題
引数なしのex_randomizeは乱数を固定してしまう

init.hsp 4268行目
  #define global unlockRand randomize:ex_randomize
↓
  #define global unlockRand randomize:ex_randomize_time

追記: 引数なしのex_randomizeは時刻でシード設定するように元からしていたので無問題
