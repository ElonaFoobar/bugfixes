# action.hsp



## [x] 宝箱の開錠難度が不正な数値になる問題

### 概要

宝箱を開けるのに一度失敗して再度鍵を開けようとするとき、開錠の難易度が大幅に上昇する。


### 原因

宝箱を開ける処理ともう一度試すかどうか確認するプロンプトを表示する処理とでは、ともに呼び出し前にグローバル変数 `val` をセットしておく必要がある。この二つのサブルーチンがネストしているために `val` の値が上書きされてしまう。


### 修正方法

鍵開け側の `val` を別の変数名に変更してやればよい。

1. `gosub *label_2208` を行なっている2箇所の直前にある `val` の名前を `lockDifficulty` に変更する。
2. `*label_2208` 内での開錠難易度を表す `val` を `lockDifficulty` に変更する (3箇所)。このとき、`gosub *label_2130` のすぐ上にある `val` の名前は変更してはならない。



## [x] 素材箱を開ける処理でスタックオーバーフローが起こる問題

### 概要

素材箱を連続で何度も開けるとスタックオーバーフローし、クラッシュする。


### 原因

`label_2213` は `gosub` で呼ばれる (`label_2212`から呼ばれる1箇所のみ)。素材箱以外を開けたときは `return` により呼び出し元、ここでは `label_2212` へ帰るが、素材箱を開けると `label_2213` から直接 `goto *label_2742` する。以下に簡略化したコードを示す:

```hsp
*label_2212
	gosub *label_2213
	goto *label_2742

*label_2213
	if (開けた箱が素材箱) {
		goto *label_2742
	} else {
		return
	}

*label_2742
	...
```

すなわち、素材箱を開けると `gosub *label_2213` で積まれた関数のコールスタックが減らないままいつまでも残り続けることになる。これによりスタックオーバーフローが起こる。


### 修正方法

素材箱を開けたときも他の箱を開けたときと同じく呼び出し元に `return` してやればよい。

1. if 文 `if ( inv(3, ri) == 394 ) {` の中の `goto *label_2742` を `return` に変更する。



## [x] 追加攻撃の際攻撃属性が初期化されない問題

### 概要

属性ダメージを与えるエンチャントを持った武器を使ってダメージを与えたあと、追加打撃/射撃が発生するとその属性で攻撃が行われてしまう。


### 原因

ダメージの属性はグローバル変数 `ele` で管理されているが、追加打撃/射撃では `ele` が初期化されず、前の属性が残ってしまう。


### 修正方法

追加打撃/射撃を処理する直前で `ele` を `0` に初期化してやればよい。

1. if 文 `if ( extraattack == 0 ) {` の一行下に `ele = 0` を追加する。



## [x] 近接攻撃のエンチャント発動ダメージ基準で反撃を食らう問題

エンチャントの発動のときにdmgが上書きされてしまう
dmg = calcattackdmg()
の下あたりで
attackdmg = dmg
とでもしておいて
切り傷エンチャの反撃
dmghp cc, attackdmg * cdata(92, tc) / 100 + 1, tc, 61, 100
棘が刺さる方（2箇所）も
dmghp cc, limit(attackdmg / 10, 1, cdata(51, tc) / 10), tc, p, cdata(78, tc) / 1000
としておいて
ifが閉じるあたりで一応
attackdmg = 0
しとく
処理の順変えてもいいかもしれないがテキスト順が変わるし何とも



## [x] 攻撃時のアニメのダメージ参照先が誤っている問題

ダメージの計算をする前に　aniref = dmg * 100 / cdata(51, tc)　としているため、ひとつ前の攻撃のdmgで攻撃時の血飛沫の量（？）が計算されてしまう
一連の処理を　dmg = calcattackdmg()　の後に移動させれば問題ない



## [x] 追加射撃が発生すると炸裂弾が不発する問題

292 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2010/05/18(火) 23:08:19 ID:llhFlLO9
116rfix2bなんだけど、追加射撃発生した時に炸裂弾が炸裂しないのは仕様なのかな？
で、数値550のを首、指、指で3箇所装備すると、追加射撃発生してなくて敵生きてても炸裂しないんだ
これはどういう事なんだろ

追記: 仕様



## [x] 追加射撃が発生したとき炸裂弾・バーストの物理ダメージが減算されていない問題

~>>81,126と同様
追加射撃発生時にammoProc=falseMとするのが考慮に入れられていない
~*act_fire内
if ammoProc=encAmmoRapid{　の直後に
　ammoProcBk=encAmmoRapid　を追加
if ammoProc=encAmmoBurst{　の直後に
　ammoProcBk=encAmmoBurst　を追加

最後にammoProc=falseMしているあたりに
ammoProcBk=falseMを追加

calcAttackDmg関数内
if ammoProc=encAmmoRapid　を
if ammoProcBk=encAmmoRapid　に変更
if ammoProc=encAmmoBurst　を
if ammoProcBk=encAmmoBurst　に変更

逆コンの場合は
~*act_fireは"通常弾を装填した。"で出るあたり
encAmmoRapid→0
encAmmoBurst→5
falseM→-1
で読み替えてくれれば分かると思う



## [x] 武器攻撃時のスキル経験値が減少する要因にキューブタイプの分裂生物が入っていない問題

action.hsp 1251行目
	expModifer=1+cBit(cSandBag,tc)*15+cBit(cSplit,tc)+(gArea=areaShowHouse)
↓
	expModifer=1+cBit(cSandBag,tc)*15+cBit(cSplit,tc)+cBit(cSplit2,tc)+(gArea=areaShowHouse)



## [x] 入り口が1階相当になっているダンジョンでマップ端から脱出できる問題

107 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/11/15 20:42:29 ID:8faZAD1v
レシマスの1層目などレベル1のダンジョンマップで、壁を掘って外へ出られるのはバグだろうか。

マップ端から歩いて脱出できる条件が、
「現在の階層レベルが1 OR マップタイプが6:ルミエスト墓所、混沌の城etc.で、
マップタイプが1:ワールドマップでない場合」となってる。



## [x] 生ものでない食べ物を購入したときにも期限が設定されている問題

action.hsp
iRot(ti)=dateId+iRotOrg(ti)の行の上の条件に
if iMaterial(ci)=mtFresh　を追加
これで店売り小麦粉・パン等に期限が設定されず、スタックしやすくなる

逆コンなら
"店の倉庫が一杯のため売れない。"　の25行ほど下
inv(27, ti) = gdata(13) + gdata(12) * 24 +　～の上の条件に
if ( inv(24, ci) == 35 ) {　を追加しておく


action.hsp 218行目
					if iRot(ti)!0:iRot(ti)=dateId+iRotOrg(ti):if iParam2(ti)!0:iRot(ti)+=72
↓
					if iRot(ti)!0 : if iMaterial(ci)=mtFresh {
						iRot(ti)=dateId+iRotOrg(ti)
						if iParam2(ti)!0:iRot(ti)+=72
					}
また、
item.hsp 696行目
		if iParam2(ci)!0:iPic(ci)=picFood(iParam2(ci),iParam1(ci)/extFood)
↓
		if iParam2(ci)!0{
			iPic(ci)=picFood(iParam2(ci),iParam1(ci)/extFood)
			iWeight(ci)=defCookWeight
		}

としておくと調理済みの店売り食品の重さが自前の調理品と揃い、スタックしやすくなる

さらに、
item.hsp 829行目
    item_stack pc,ci,1
を挿入することで調理後自動スタックさせられる



## [x] 小さなメダル・ガシャポンの玉を生成する際に生成レベル・品質が初期化されていない問題

flt命令による初期化がないため、特別品質のアイテムを生成した直後にガシャポンの玉を生成すると★が付く

action.hsp 1527行目
				item_create -1,idMedal,x,y
↓
				flt:item_create -1,idMedal,x,y

command.hsp 4437行目
		item_create -1,p,cX(cc),cY(cc):if stat!false:iParam2(ci)=0
↓
		flt:item_create -1,p,cX(cc),cY(cc):if stat!false:iParam2(ci)=0



## [x] クーラーボックスで消費期限がリセットされない問題

794 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/04(水) 07:50:30.95 ID:KXmJ7i1U
Noa猫氏のお返事
・未調理の食品が消費期限を過ぎる -> 腐敗アイコン
・調理済の食品が消費期限を過ぎる -> 腐敗アイコン
・消費期限を過ぎ、腐敗アイコンとなっている未調理の食品を調理する -> 料理アイコン
これで多分意図通り、でも３番目のパターンで腐敗アイコンにしてもいいかもー
クーラーボックス等で消費期限がリセットされるのは仕様
ホントは入れてる間は腐らないようにしたかったけどやり方がわからなかったか
面倒だったのどっちかでリセットにした…多分

とのこと
とりあえず四次元ポケットの方は仕様にするとしてクーラーボックスの方
・クーラーボックスに腐った食べ物を入れてクーラーボックスを足元に置く
　開く→足元のクーラーボックスで取り出すと消費期限がリセットされる
足元に置かない場合リセットされないのが気になって調べてみたら
バグでしたとさ

action.hsp 912行目
～ : invContainer(1)=ci
を
～ : invContainer(1)=iId(ci)
に修正
action.hsp 931行目
if (invFile=roleFileFreezer)or(iId(invContainer(1))=idCoolerBox){
を
if (invFile=roleFileFreezer)or(invContainer(1)=idCoolerBox){
に修正

逆コンパイルソース
169846行目
invcontainer(1) = ci
を
invcontainer(1) = inv(3, ci)
に修正
169901行目
if ( invfile == 6 | inv(3, invcontainer(1)) == 641 ) {
を
if ( invfile == 6 | invcontainer(1) == 641 ) {
に修正

これで「冷蔵庫、クーラーボックスに入れてる間は腐らないように」な動作になる…はず

795 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/04(水) 08:00:26.62 ID:KXmJ7i1U
あ”あ”あ”
クーラーボックスの重量再計算がおかしい…
action.hsp 912行目
～ : invContainer(1)=ci
を
～ : invContainer(1)=iId(ci) : bkci = ci
に修正
action.hsp 931行目
if (invFile=roleFileFreezer)or(iId(invContainer(1))=idCoolerBox){
を
if (invFile=roleFileFreezer)or(invContainer(1)=idCoolerBox){
に修正
action.hsp 946行目
if refWeight!0:iWeight(bkci)=refWeight :call calcBurdenPc
を
に修正

逆コンパイルソース
169846行目
invcontainer(1) = ci
を
invcontainer(1) = inv(3, ci) : bkci = ci
に修正
169901行目
if ( invfile == 6 | inv(3, invcontainer(1)) == 641 ) {
を
if ( invfile == 6 | invcontainer(1) == 641 ) {
に修正
169925行目
inv(7, bkci) = refweight
を
に修正

これで大丈夫かな？

796 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/04(水) 08:02:25.30 ID:KXmJ7i1U
ミスった…
action.hsp 946行目
if refWeight!0:iWeight(invContainer(1))=refWeight :call calcBurdenPc
を
if refWeight!0:iWeight(bkci)=refWeight :call calcBurdenPc
に修正



## [x] はく製を染料で染めるとキャラグラフィックが変わる問題

染料で色替えしようと絵が冒険者用の絵に変化するバグに注意。俺だけかもしれないが -- 2010-01-10 (日) 00:07:51 
大量に手に入る盗賊団の首領の剥製を染料で巫女さんにして鑑賞してます -- 2010-05-27 (木) 17:03:56


inv(22,アイテムNo)には普段色情報が格納されているが、はく製・カードの場合はキャラチップ番号が格納される
染色のとき除外していないのが問題



## [x] 名声が低いときに盗賊団の頭領が基本レベルで生成される問題

低名声時(1000未満)の盗賊団の頭領のレベル調整
　名声が1000未満の場合、盗賊団の首領が基本レベル(Lv12)で生成される
　対処
　action.hsp 673行目
　　encounterLv=cFame(pc)/1000の後ろに:if encounterLv=0:encounterLv=1を追加
　※名声1000～1999時と同じレベルになるため要調整？



## [x] 木になっている果物がスタックされない問題

action.hsp 398行目
			item_stack -1,ci
を挿入



## [x] 水を置いても神に祝福されないことがある問題

item_stack命令→祝福判定の順なので
足元に祝福されてない水と祭壇がある状態でさらに水を置くと
祝福のメッセージがでるものの実際は祝福されていない


action.hsp
	if iId(ti)=idWater{
↓
	if iId(ti)=idWater:if iNum(ti)>0{
とりあえず応急処置

