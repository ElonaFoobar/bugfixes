# chara.hsp


## [x] すくつの敵キャラクターにすくつ補正がつかないことがある問題
援軍の巻物などすくつ補正がかからないキャラ生成を行う際はnovoidlv = 1となるが
場所がすくつでなかった場合これが0にならず1のまま残り続けるため、
すくつに入ったときにまったく関係ないキャラクターにすくつ補正がかからないことがある
キャラ生成処理のところで場所に関わらずnovoidlv = 0にすれば問題ないはず

## [x] 冒険者が潰されて息絶えたとき復活時間が設定されない問題
潰されて息絶えた　で検索して出るあたり
cExist(rc)=cAdvHospitalの後に復活時間を設定しておく
通常死亡と同じにしたいなら
:cRespawn(tc)=dateId+respawnTimeAdv+rnd(respawnTimeAdv/2) とでも追加
逆コンなら
cdata(5, tc) = gdata(13) + gdata(12) * 24 + gdata(11) * 24 * 30 + gdata(10) * 24 * 30 * 12 + 24 + rnd(24 / 2)

雇っているときはペットと同様にはぐれた処理でもいいかもしれないが…

## [x] 終末の日でドラゴンと巨人以外の『』付が生成される問題
489 名前：以下、名無しにかわりましてVIPがお送りします[sage] 投稿日：2012/02/07(火) 20:35:55.50 ID:PtE4F4VX0
魔の塔のボスがリッチ種以外になってしまう問題だけれども、これvanillaからあるバグっぽい。
終末の日でごく稀にドラゴンと巨人以外のモンスターが出現するのはこのバグのせい。

627 名前：以下、名無しにかわりましてVIPがお送りします[] 投稿日：2012/02/07(火) 22:20:52.20 ID:NkYREkkP0
~>>489
低確率でゴダ等から選ぶモードになってfltnraceがドラゴンだからdbidに0が返って
再度選ぶときにflt命令内でfltnraceがリセットされるってところのことであってる？


キャラ生成での種類制限を行うフィルターはなぜか4種類もある。
-fltSelect
ユニーク・特殊ユニーク・街NPCなどの分類
-fltn(filterN)
猫・駒・不死・ミノタウロス・人間等の分類
召喚やマップでの生成、特効などの判定に使う
-fltnRace
種族での分類
-fltTypeMajor(creaturePack)
群れを作るときの分類

キャラIDを指定せずに生成する場合、fltSelectが未指定なら低確率でspUniqueから選ぶのだが、
指定された条件でキャラが見つからなければ
品質を奇跡、生成レベルを+10としたのち、fltSelect・fltn・fltnRace・fltTypeMajorを初期化して選びなおす。

これがいわゆるゴダ・イスカ等の特殊ユニークや、『』付きを生成している部分。
終末の日イベントのようにfltnRaceを指定している場合は、
指定されたfltnRaceを無視した『』付きが生成されてしまうことがある。

chara.hsp 458行目
    if fltSelect=0{
↓
    if fltSelect=0:if filterMax=0:if fltnRace="":if fltTypeMajor=0{

## [x] 高レベルで生成されたカオスシェイプの部位が最大30まで増える問題

chara.hsp 46行目
    repeat cLevel(r1)/3
↓
    repeat limit(cLevel(r1)/3,0,12)

## [x] 遺伝子引継ぎをキャンセルしてもマテリアルが引き継がれる問題

冒険者の引継ぎ→遺伝子の選択→種族の選択→キャンセルしてタイトルに戻る
→新しい冒険者を作成すると、マテリアルが引き継がれている

遺伝子の選択のときに読み込んだMat()が初期化されていないのが原因


chara.hsp 1080行目
  if geneUse!"":gosub *apply_gene
↓
  if geneUse!""{
    gosub *apply_gene
  }else{
    memset mat(0),0,maxMat*sizeInt
  }

