# action.hsp


## [x] 宝箱の開錠難度が不正な数値になる問題
97 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/02/28(月) 17:23:36.91 ID:vuzB5+ut
鍵開けバグの原因:
ジャンプ直前に変数valをセットする必要があるサブルーチン同士のネスト。

概要:
ロックピック使用サブルーチンとプロンプト表示サブルーチンが、
共にジャンプ前にセットされた変数valの値を使うから、
開錠に失敗して前者から後者にジャンプした時点で、valの中身が開錠難度からプロンプトのX座標になってしまう。
再試行を選択するとロックピック使用サブルーチンの先頭にジャンプするだけだから、
キャンセルしてロックピック使用サブルーチンから抜けない限り、開錠難度 = プロンプトのX座標のままになる。


別変数作って退避すればよい
action.hsp 868行目
	f=false
	if i*2 <  val : txt lang("この鍵を開ける技術はない。","The lock mechanism is beyond your skill."): f=true
	if f=false:if i/2 >= val{
		txt lang("楽勝だ。","Easy.")
		}else{
		if rnd(rnd(i*2)+1) < val : txt lang("開錠に失敗した。","You fail to unlock it.") : f=true	
		}

↓
	f=false
	if i*2 <  keyLv : txt lang("この鍵を開ける技術はない。","The lock mechanism is beyond your skill."): f=true
	if f=false:if i/2 >= keyLv{
		txt lang("楽勝だ。","Easy.")
		}else{
		if rnd(rnd(i*2)+1) < keyLv : txt lang("開錠に失敗した。","You fail to unlock it.") : f=true	
		}
action.hsp 952行目
		val=iParam2(ci):gosub *lockpick
↓
		keyLv=iParam2(ci):gosub *lockpick

## [x] 素材箱を開ける処理でスタックオーバーフローが起こる問題
627 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/07(木) 21:14:15.17 ID:qvc+3rNS
ん、開けてアイテムが出てくる類の物を開けると呼ばれるのが*act_open
これはgotoでしか呼ばれない
で、*act_open内からお年玉かそれ以外かで*open_newYearもしくは*open_chestが
gosubで呼ばれ、returnしてきた場合は画面再描画後、goto *turn_endする
~*open_chestが呼び出された場合、開けたアイテムが素材箱の場合returnせずに
~*open_chest内の処理から直接goto *turn_endする
素材箱以外の場合は相応の処理後returnで*act_openへ戻る
ちなみに*open_chestは*act_open以外からの呼び出しは無い

となっててこれはまずいんじゃないか？ってことHSPがその辺無問題なら
単に俺のHSPに対する知識不足ってことでいいんだけど

631 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/07(木) 21:59:22.49 ID:2XGY+/YV
~>>627
素材箱240個くらい連続で空けてみたら落ちたよ

HspError 29 WinError 0 Ver 1220 Mode 0
efId 1117 efP 160 Area 14/1
ci -1#394 ti 0#636 cc 0#0 tc 0#0 rc 80#39
3. com_inventory15/0 ct:0
2. turn_end:pc ct:0
1. pc_turn_init ct:0
0. com_inventory15/0 ct:0
~* error in function:screen_draw:2

たしかにそれはバグだね


action.hsp 973行目
		call effect:goto *turn_end
↓
		call effect:return

## [x] 追加攻撃の際攻撃属性が初期化されない問題
742 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/09(水) 20:04:14.78 ID:nRrH0tc4 [4/5]
公式掲示板にあったやつ
攻撃時のエンチャント処理の後eleが初期化されてないので
属性ダメ追加があると追加打撃/射撃時にその属性で攻撃してしまう
適当なところでele=0に戻してやる必要がある


追加打撃、追加射撃時のダメージ属性修正
　属性ダメ追加があると追加打撃/射撃時にその属性で攻撃してしまう
　対処
　action.hsp 1452行目
　　最後に:ele=0を追加



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

## [ ] 追加射撃が発生すると炸裂弾が不発する問題
292 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2010/05/18(火) 23:08:19 ID:llhFlLO9
116rfix2bなんだけど、追加射撃発生した時に炸裂弾が炸裂しないのは仕様なのかな？
で、数値550のを首、指、指で3箇所装備すると、追加射撃発生してなくて敵生きてても炸裂しないんだ
これはどういう事なんだろ

## [ ] 追加射撃が発生したとき炸裂弾・バーストの物理ダメージが減算されていない問題
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

## [ ] 入り口が1階相当になっているダンジョンでマップ端から脱出できる問題
107 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/11/15 20:42:29 ID:8faZAD1v
レシマスの1層目などレベル1のダンジョンマップで、壁を掘って外へ出られるのはバグだろうか。

マップ端から歩いて脱出できる条件が、
「現在の階層レベルが1 OR マップタイプが6:ルミエスト墓所、混沌の城etc.で、
マップタイプが1:ワールドマップでない場合」となってる。

## [ ] 生ものでない食べ物を購入したときにも期限が設定されている問題
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

## [ ] 小さなメダル・ガシャポンの玉を生成する際に生成レベル・品質が初期化されていない問題

flt命令による初期化がないため、特別品質のアイテムを生成した直後にガシャポンの玉を生成すると★が付く

action.hsp 1527行目
				item_create -1,idMedal,x,y
↓
				flt:item_create -1,idMedal,x,y

command.hsp 4437行目
		item_create -1,p,cX(cc),cY(cc):if stat!false:iParam2(ci)=0
↓
		flt:item_create -1,p,cX(cc),cY(cc):if stat!false:iParam2(ci)=0

## [ ] クーラーボックスで消費期限がリセットされない問題
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

## [ ] 水を置いても神に祝福されないことがある問題

item_stack命令→祝福判定の順なので
足元に祝福されてない水と祭壇がある状態でさらに水を置くと
祝福のメッセージがでるものの実際は祝福されていない


action.hsp
	if iId(ti)=idWater{
↓
	if iId(ti)=idWater:if iNum(ti)>0{
とりあえず応急処置

