# [BUG1:Fixed] Treasure box becomes too difficult to unlock

When retrying to unlock a treasure box(or any "box"), the difficulty becomes
too higher.


## [BUF2:Fixed] Opening material box causes stack overflow

Opening material boxes so many times(in v1.22, about 240 times), Elona will crash because of stack overflow.


# [BUG3:Fixed] Extra attacks/shots use the last dealt element

If the weapon has an enchantment "deals XXX damage.", the following extra
attacks/shots take on the element, i.e., "XXX".


# [BUG4:Fixed] Damage of counterattack depends on damage of enchatment effect.

If the weapon "invokes" something due to its enchantments, the following
counterattack is calculated by the damage, not the physical damage.


# [BUG5:Fixed] Blood splash depends on the previous dealt damage

The amount of blood is calculated by the last damage.


# [BUG6] Special ammos are not applied in extra shot.

Special ammos like burst are not applied in extra shot.


# [BUG7:Fixed] "Cube" does not decrease skill experience

Other NPCs which split decrease the experience of the weapon skills, but, only "cube" does not.


# [BUG8] You can exit some nefias from the 1st floor

Like Lesimas.


# [BUG9] Non-raw foods have expiration date although they never get rotten

Due to this, non-raw foods sold at shops such as bread are not stackable.


# [BUG10] Sometimes an item has the wrong quality

### Cause

In some item generations(small medals or treasure boxes), the quality and the generation level is not reset.


# [BUG11] Cooler box does not reset the expiration data

Cooler box reset the expiration date only if you put it on the ground and take food.
If you have the box in your inventory, not on the ground, cooler box does not reset the expiration date.


# [BUG12:Fixed] Dyeing figure changes the character graphic inner the figure

Then, the graphic become adventurer's.


# [BUG13:Fixed] Rogue bosses have too higher levels when the PC's fame is low

When your fame is less than 1000, the level of the rogue boss is 12, although it is 1 when your fame is 1000.


# [BUG191:Fixed] Fruits which falled down from trees are not stackable

You can stack them by picking them up, but they should be stacked automatically.


# [BUG14] Your god sometimes does not bless water on an altar

If there is an altar and non-blessed and non-cursed water on the altar, your god will not bless water which you put down. Note that message is displayed, but actually water is not blessed.


# [BUG15:Fixed] When a new pet joins, his/her "summoned" flag remains

However, the flag is not used for pets so far.


# [BUG16] Most adventurers remain in the world map(North Tyris)

Thus, it is hard to meet an adventurer you want to.


# [BUG17:Fixed] Sometimes adventurers have "void-adjustment"s.

If an adventurer is generated when PC is in The Void, the new adventurer has "void-adjustment". Void-adjustment is applied to NPCs in The Void, and multiplies the level of them. Due to that, NPCs in The Void has very high levels.



# [BUG18] NPCs freeze if they attempt to quaff empty bottles.

Elona NPCs sometimes quaff thier potion from their inventory, but an empty bottle is not able to be quaffed.


# [BUG19:Fixed] <Gwen> the innocent sometimes retreats from PC

She always follows PC, but sometimes retreats from PC as if she were in status ailment fear.

# [BUG20] Adventurer can break world map object, such as mountain.

Hostile adventurers and unique NPCs can break walls. Normally, adventurers do not appear in world map, but if you contract an adventurer, he or she can go world map as your ally. When the contract period has expired, the adventurer becomes no longer your ally. Then, you make him or her by any means, he or she may break mountain.


# [BUG21:Fixed] If a NPC does "-3 action" and the distance between the target and him/her is 1, the NPC does melee attack and ranged atack in the same turn.

-3 is one of the action IDs and means "do melee attack if he/she can, or stay here".


# [BUG22:Fixed] If you teach your pet words, the character does not save you from choking

When you are chocked by eating rice cake, your pets attempt to save by bashing you. However, pets who are taught words do not that.


# [BUG23] If you draw water from well when your inventory is full, Elona will crash

Does not check whether there is a slot to store new item, i.e., water.


# [BUG24:Fixed] You can equip any items in any equipment slot


＞978 名前：以下、名無しにかわりましてVIPがお送りします[] 投稿日：2012/04/07(土) 18:30:36.38 ID:97zSlpPk0
＞黄金様っていうか再現性ありのバグだねこれは
＞今装備してるものをふかふかパンにする→拾うのかんたん操作
＞公式でも出来たから皆やってみなよ

装備しているアイテムを使用して調合すると装備アイテムの個数が1減るが、アイテムデータが削除されるわけではないので0個のアイテムを装備している状態になる
そこでアイテムを拾ったとき、若い番号から0個のスロットを見つけてアイテム情報を上書きする
キャラデータ側が保持しているのは装備中のアイテム番号だけなので
0個のアイテムのスロットにそのアイテムが入ると拾ったアイテムを装備している状態になるといった不具合

cell_refresh iX(rpRefMat(cnt)),iY(rpRefMat(cnt))のすぐ上に
chara_unequip rpRefMat(cnt):if stat=true:call charaRefresh,(r1=pc)　とでも追加しておくことで装備から外れる
処理はアイテム食べるところから拝借した

逆コンなら*label_1932　cell_refresh inv(5, rpref(10 + cnt～の行のすぐ上に
chara_unequip rpref(10 + cnt * 2)
if ( stat == 1 ) {
　r1 = pc
　gosub *label_1476
}
を追加でおｋ


# [BUG26:Fixed] レシピ選択画面がずれる問題

レシピ選択画面の表示ずれ修正
　config.txtにてwindowH.を600以上に設定した場合に、テスト用フライパンなどを
　使用してレシピ選択ウィンドウを表示すると右ウィンドウの調合の手順以下の表示位置が
　ずれる
　対処
　blend.hsp 287行目
　　dy=120をdy=y+48に変更

# [BUG188:Fixed] レシピの文字色が無関係なアイテムの祝呪の影響を受けている問題
**修正方法
blend.hsp 630行目
	cs_list s,wX+84,wY+60+cnt*19-1,19,0,1,p
↓
	cs_list s,wX+84,wY+60+cnt*19-1,19,0,0,p






# [BUG27] 心眼スキルによるクリティカル上昇が機能していない問題
710 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/02/14(月) 22:31:07 ID:ddkcPGbQ [1/2]
&gt;ハック版作者達

公式版1.22を逆根直後のソース行番号で
118750行目～118755行目
をコピーした上でコメントアウト
コピーした内容を
119017行目と119018行目の間
にコピー

効能
装備品に付与されている心眼スキル上昇効果が心眼スキル値は上昇させるけど
それに伴って上昇するはずのクリティカル率が影響を受けない
つー謎動作の改善

ま、ここしか知らんからここに投下
公式は最低でも１度は報告したはずだけど1.22まで未改善だったし
どっかに消えたrev??の人もrev23時点で未対応だったし
どーでもいい程度のバグ(もしくは正式な仕様)かもしれんけど念のため


心眼エンチャントクリティカル率補正バグ修正
　「それは心眼の技術を上昇させる」のエンチャントの付いた武具を装備しても
　心眼スキル上昇によるクリティカル率の上昇が加味されない
　対処
　calculation.hsp 421行目
　　%%クリティカル率の再計算位置がまずいので421行目を無難と思われる494行目付近へ移動%%
　　これだと今度はクリティカルヒットの機会を増やすエンチャントが機能しなくなってしまう。
　　421行目付近では変数に0を代入させ、494行目付近で代入ではなく加算をすると良い？


# [BUG28:Fixed] レベル1で生成されたキャラクターの耐性が無効化される問題


金ベルの魔法耐性消失は*calcInitialSkill(逆コン*label_1511)だってのが判った
Lv1除外の理由ってプレイヤーの耐性初期化以外ぐらいしか思いつかないんだけど他に何かあるのかな

327 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 23:34:39.15 ID:Myv4aFO+ [4/4]
うん、不具合って事で俺の中で結論が出た。cLevel(r1)=1をr1=pcに変更で特に問題もないっぽい(逆コンならr1==0)
cnpcで半端な耐性が無効化されたりするのも多分不具合、既存敵の耐性がMAXか弱点かしかないからそれを基準にした判定しかしてないため
となると失耐性で下がったペットの耐性が元に戻せないのもやっぱり一種の不具合かな
こっちはスマートな対処法見つかったら書く

転載再upは別に構わないけどバグバグしいのは消した方がいいと思う。あと今はまだ非公式改造版だって書いとくといいかも

# [BUG29:Fixed] 技能のスペルパワーが正しく計算されていない問題
78 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/29 11:52:51 ID:d7sYnnGH
calcspellpowerにて

スキルID >= 600(技能)なら
参照主能力が0でなければ参照主能力ID * 6 + 10を返す

ってなってるけどこれ参照主能力の値の間違いじゃないかな？
具体的にはsdataref(0, prm_918),じゃなくてsdata(sdataref(0, prm_918), prm_919)

このせいでルルウィの憑依が速度+171固定になってたりする
変えたら変えたで他のスキルに変な影響出るかもしれないけど

# [BUG30:Fixed] 遠隔武器の命中補正が無効になっている問題
111 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/11/27 00:53:23 ID:S4q+c/ur
calcattackhitのところで
tohi = tohit * rangemap(rangedist) / 100
って計算があるけどtohiはtohitの誤字っぽい

# [BUG31] 格闘のクリティカル倍率が1になっている問題
calcAttackDmg関数内
dmgMulti*=1.25
↓
dmgMulti=dmgMulti*5/4

# [BUG32] 未鑑定アイテムがPCレベル依存で高くなる問題
完全未鑑定で自店舗モードでないなら
基本売価 = PCレベル / 5 * ((乱数の種 + アイテムID * 31) \ PCレベル + 4) + 10
これはまずいので
基本売価 = (乱数の種 + アイテムID * 31) \ 10 + 10
適当にこんな感じでレベル依存しないようにしておくといいかも


# [BUG33] ショウルームのCNPCのビットがまったく関係ない他のCNPCに付与されてしまうことがある問題
キャラクター情報を更新する処理(*chararefresh)で　memcpy cdata(450, r1), userdata(40, cdata(157, r1)), 30 * 4　を行って
CNPCに設定されたビットをコピーするが、これが行われる時点ではまだCNPC番号がセットし直されていないのが原因
マップに入った後のgetunidの直後にでももう一度このルーチンに飛ばして更新し直すと良い



# [BUG35:Fixed] すくつの敵キャラクターにすくつ補正がつかないことがある問題
援軍の巻物などすくつ補正がかからないキャラ生成を行う際はnovoidlv = 1となるが
場所がすくつでなかった場合これが0にならず1のまま残り続けるため、
すくつに入ったときにまったく関係ないキャラクターにすくつ補正がかからないことがある
キャラ生成処理のところで場所に関わらずnovoidlv = 0にすれば問題ないはず

# [BUG36:Fixed] 冒険者が潰されて息絶えたとき復活時間が設定されない問題
潰されて息絶えた　で検索して出るあたり
cExist(rc)=cAdvHospitalの後に復活時間を設定しておく
通常死亡と同じにしたいなら
:cRespawn(tc)=dateId+respawnTimeAdv+rnd(respawnTimeAdv/2) とでも追加
逆コンなら
cdata(5, tc) = gdata(13) + gdata(12) * 24 + gdata(11) * 24 * 30 + gdata(10) * 24 * 30 * 12 + 24 + rnd(24 / 2)

雇っているときはペットと同様にはぐれた処理でもいいかもしれないが…

# [BUG37:Fixed] 終末の日でドラゴンと巨人以外の『』付が生成される問題
489 名前：以下、名無しにかわりましてVIPがお送りします[sage] 投稿日：2012/02/07(火) 20:35:55.50 ID:PtE4F4VX0
魔の塔のボスがリッチ種以外になってしまう問題だけれども、これvanillaからあるバグっぽい。
終末の日でごく稀にドラゴンと巨人以外のモンスターが出現するのはこのバグのせい。

627 名前：以下、名無しにかわりましてVIPがお送りします[] 投稿日：2012/02/07(火) 22:20:52.20 ID:NkYREkkP0
~>>489
低確率でゴダ等から選ぶモードになってfltnraceがドラゴンだからdbidに0が返って
再度選ぶときにflt命令内でfltnraceがリセットされるってところのことであってる？

**概要
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
**修正方法
chara.hsp 458行目
		if fltSelect=0{
↓
		if fltSelect=0:if filterMax=0:if fltnRace="":if fltTypeMajor=0{

# [BUG187:Fixed] 高レベルで生成されたカオスシェイプの部位が最大30まで増える問題
**修正方法
chara.hsp 46行目
		repeat cLevel(r1)/3
↓
		repeat limit(cLevel(r1)/3,0,12)

# [BUG38:Fixed] 遺伝子引継ぎをキャンセルしてもマテリアルが引き継がれる問題
**概要
冒険者の引継ぎ→遺伝子の選択→種族の選択→キャンセルしてタイトルに戻る
→新しい冒険者を作成すると、マテリアルが引き継がれている

遺伝子の選択のときに読み込んだMat()が初期化されていないのが原因

**修正方法
chara.hsp 1080行目
	if geneUse!"":gosub *apply_gene
↓
	if geneUse!""{
		gosub *apply_gene
	}else{
		memset mat(0),0,maxMat*sizeInt
	}





# [BUG39:Fixed] オパートス信仰のダメージ軽減が機能していない問題
368 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2010/09/20(月) 17:04:09 ID:OBB40phw [1/2]
dmghpを見てて気が付いたんだけど
攻撃されたキャラの現在HPをダメージ値分減少させた後に
攻撃を受けたキャラがPCでオパートス信仰の場合ダメージ値を9割にする処理がされてる

で、動作確認のために信仰を変えて硫酸を飲んで見たところ
オパートスでもそれ以外でも１０ダメージ固定
これってどんな時に役に立つの？

370 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2010/09/20(月) 20:42:00 ID:kWx2VrEr
ちまちまコメントで解析状況メモりつつ解析してた1.12のソースだと
現在HPに対する減算処理前に信仰によるダメージ値の補正がきてるから
色々弄ってるうちに順番おかしくなったんだろ、多分
とりあえずバグ報告しとくよろし

**修正方法
chara_func.hsp 1474行目
		if cGod(pc)=godEarth:dmg=dmg*90/100
まずはこの行をコメントアウト

chara_func.hsp 1462行目
		if tc=pc : if cGod(pc)=godEarth:dmg=dmg*90/100
を挿入

ただ、この方法だとほとんどのダメージを軽減してしまう
特に最大HP49以下のときには餓死ダメージが0になるので要調整

また、
calculation.hsp 340行目
	if tc=pc : if trait(traitGodEarth)!0 : damage--
↓
	if tc=pc{ 
		if trait(traitGodEarth)!0	:damage--
		if cGod(pc)=godEarth		:damage=damage*90/100
	}
こうするとオパートスの甲殻の説明通り物理ダメージだけ軽減するようになる
お好みで

# [BUG40] 魔法属性攻撃が2重に軽減されている問題
968 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/14(木) 02:23:34.50 ID:K3QUA9zw
dmghp見てたけど
属性耐性による軽減処理で無属性魔法のダメージが二重に軽減されてる
解析ページの言葉を借りるなら魔法属性魔法攻撃になってる
どっちか削った方が良い気がする

**修正方法
chara_func.hsp 1444行目
	if (ele=false)or(ele>=tailResist){
 
		}else{
		r=sdata@(ele,tc) / resistGrade
		if r<resistValid{
			dmg = dmg * 150 / limit(  r*50 +50 ,40,150)
			}else{
			if r<resistImmune : dmg = dmg *  100 / ( r*50 + 50 ) :else: dmg=0 
 			}
		dmg=dmg*100/(sResMagic(tc)/2+50)
		}
↓
	if (ele>false)&(ele<tailResist){
		r=sdata@(ele,tc) / resistGrade
		if r<resistValid {
			dmg=dmg*150/limit(r*50+50,50,150)
		}else:if r<resistImmune	{
			dmg=dmg*100/(r*50+50)
		}else{	;r>=resistImmune
			dmg=0 
 		}
		if ele!=rsResMagic {
			dmg=dmg*100/(sResMagic(tc)/2+50)
		}
	}

# [BUG41:Fixed] 対象が濡れているとき、火属性に対し属性無効ビットが機能しない問題
**概要
ダメージ対象が濡れている場合、火炎ダメージを/3したあと無属性ダメージに変更しているため、
死亡メッセージが無属性のものになったり、
ベルなどの属性無効(cResEle)ビット持ちにダメージが通ってしまう

**修正方法
chara_func.hsp 1458行目
	if cWet(tc)>0{
		if (ele=rsResFire)or(dmgSource=dmgFromFire):dmg=dmg/3:ele=0
		if ele=rsResLightning	:dmg=dmg*3/2
		}
↓
	if cWet(tc)>0{
		if (ele=rsResFire)or(dmgSource=dmgFromFire):dmg=dmg/3	;:ele=0	←コメントアウト
		if ele=rsResLightning	:dmg=dmg*3/2
		}

chara_func.hsp 1460行目
		if (ele=rsResFire)or(dmgSource=dmgFromFire): item_fire tc,-1
↓
		if (ele=rsResFire)or(dmgSource=dmgFromFire) :if cWet(tc)=0 :item_fire tc,-1


# [BUG42] PC死亡時に画面から消滅するタイミングがおかしい問題
978 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/17(木) 01:56:28.65 ID:04wseWc/ [2/2]
PC死亡時に画面から消滅するタイミングをNPCと同じにする方法。

animeblood→存在状態を変更の順で処理しているのを、
存在状態を変更→PCの時だけcell_draw→animebloodの順に変えるだけ。

# [BUG43:Fixed] ぺットが視界の外で出現した敵に向かっていく問題
101 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/22(火) 21:19:32.36 ID:X0FeyyND
大広間とかで、ペットが視界の外で出現した敵に向かっていく問題の修正。
場所はdmghp命令内、経験値を加算してcdata(201, 勝利ユニット(== 死因)番号)を0にした後。

「勝利ユニットがPCかペットなら、そのユニットとPCの敵対ユニット番号、pcattackerの3つの値を0にする」
の記述を追加。

z→任意のキーで出るターゲット選択キー表示のずれ。
これは遠隔弾の表示ずれと原因は同じ。
場所は*label_1953。
display_key x * inf_tiles + inf_screenx - 12, y * inf_tiles - 12, cnt
↓
display_key x * inf_tiles + inf_screenx - 12, y * inf_tiles + inf_screeny - 12, cnt


# [BUG44:Fixed] PC以外が敵を倒したときも信仰している神のセリフが表示されることがある問題
dmgHpの末尾で
if cc=pc :
↓
if dmgSource=pc :

逆コンなら
if ( cc@m141 == 0 ) {
↓
if ( prm_855 == 0) {

# [BUG45] 反撃ダメージが原因で死んだとき、死亡メッセージの表示がおかしい問題
143 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/08/13 01:31:25 ID:otxWzItQ
dmghp命令内で、変数ccを参照している箇所があるが、ここは引数3を参照すべきではないだろうか。
cc参照のままだと、棘ダメージが原因でPCが死んだ時に、「PCに殺された」とbone.txtに記載されてしまう。

# [BUG46:Fixed] ネフィアボス勝利イベントが多重に起こる問題

adata(20,)にはボスのユニット番号が入っており、これがリセットされるのはcase evRandBossWinのイベント処理内なので
分裂生物とグレネード発動武器のスウォームを利用し同ターンに同番号にキャラ生成して倒すか
時止め中はイベント処理が行われないことを利用し時止め中に同番号にキャラ生成して倒すことで多重にネフィアボス勝利イベントを追加できる
~>>126と似た感じのバグ

chara_func.hsp　1750行目付近（通常ネフィアとすくつの2箇所）
if areaBoss(gArea)=tc : evAdd evRandBossWin
↓
if areaBoss(gArea)=tc :if cBit(cPrecious,tc)=true : evAdd evRandBossWin
といった感じでcPreciousビットをチェックしておくことにする

逆コンパイルソース　114000行目付近（通常ネフィアとすくつの2箇所）
if ( adata(20, gdata(20)) == prm_853 ) {
　　evadd 5
}
↓
if ( adata(20, gdata(20)) == prm_853 ) {
　　if ( cbit(976, tc) == 1 ) {
　　　　evadd 5
　　}
}

# [BUG47] マップ内のキャラクター数が正しく計算されない問題
91 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/06/06 07:03:16 ID:9AEDTPAC
gdata(3)
これはマップ内のPCペット冒険者以外のユニット数を表す数字らしく
マップ内のランダム沸き等のときに参照されていて
・マップ初期化のあたり、Map:Recaluculate crowdで
0にセットしたのちユニット番号>57で存在するキャラがいればその都度+1
・キャラ生成の最後の方で+1
・dmghpでユニットが死んだとき-1
となっている

問題としては
1.分裂処理(copy_chara)内で+1されていないので分裂したモンスターを倒すと減る一方
2.ユニット番号>57とあるがおそらくユニット番号=>57のミス
3.討伐依頼時に if ( gdata(3) < クエスト残り分 / 600 ) という条件があるが
どうも変なので / 60 のミスではないか

1は分裂生物の討伐依頼で観光客と特殊部隊が異常に増えたり、店内バブル工場で客が沸き続ける原因となっている

92 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/06/09 23:31:55 ID:fIBR6cXJ
~>>91に補足。

dmghp内のgdata(3)--は、ユニット番号が57以上かつ存在状態が0の時を条件にしないと、
冒険者ユニットが死んだ時や、街の住人を蘇生させた時に値が現状と合わなくなる。

ベル系の退却などに使われるchara_vanquish内と、
ユニット配置失敗(マップに空きが無くて何かに潰された)時もgdata(3)を-1する必要がある。
共にユニット番号57以上を条件にすれば大丈夫なはず。

relocate_charaがユニット番号56以下と57以上の間で行われる時も、
gdata(3)を増減させないといけない(例: 支配の魔法、シルバーキャットの引き渡し)。

ユニット生成時のgdata(3)++は、ユニット番号57以上を条件にすべき。
でないと冒険者の入れ替わり時や、奴隷買い取りを取り消す度に値が増えてしまう。

・使用人の雇用でgdata(3)が増え続ける問題
~>>91-92のgdata(3)：マップ内の一般ユニット数のことだが、
使用人の雇用ウィンドウを閉じるとき、cTempのユニットをchara_vanquishする際にgdata(3)を減らしていない
わが家にて使用人の雇用を何度か試みた後モンスター召喚すると不発するくらいしかデメリットはない
再度マップに入れば再計算されて直る

# [BUG48] 援軍でダンジョンクリーナーが仲間になる問題

696 名前：異形の森の名も無き使者[sage] 投稿日：2012/12/13(木) 23:49:59 ID:/jjFf9Xc
念のため言っておくけど解析モリモリなので他所に持ち出さないでね

イスカ・ゴダ・マッドサイエンティスト・ダンジョンクリーナーは特殊なユニークで、
一般モンスターの生成時に生成される可能性があるという特徴と、
キャラ別の生成済みカウントが1以上なら生成されないという特徴がある

なのでPCのレベルが足りていれば援軍の巻物で仲間に出来るが、
ダンジョンクリーナーはキャラ生成後初期洞窟内でレベルを上げて援軍を呼んでもまず出てこない
キャラ生成後ロミアスとの会話が始まる前に少しラグがあるが、そこで全街のNPC等を生成しており、既に生成済みカウントが1になっているからだ

生成済みカウントの変動は、
1.キャラ生成命令の中でまず+1
2.キャラ生成したとき、それが一時スロットなら-1
3.強制再生成マップ（子犬・すくつ・クエストマップ・アリーナ等）を再生成するとき、そのキャラが死んでいないなら-1
すくつや討伐依頼で会ってもイスカにまた会えるのは3の処理が原因

じゃあどうすればダンジョンクリーナーの生成済みカウントが0に戻るかというと
A.バグで減る
B.生成済みカウントのデータを消す
の2つの方法がある

A.バグで減る
http://kohada.2ch.net/test/read.cgi/gameurawaza/1324953084/681-683
この辺で調べる機会があったので自分のデータを見てみたのだが、神の化身・CNPC・バブル等の生成済みカウントがマイナスになっていた

キャラを新規に配置する方法としてはキャラ生成命令だけじゃなくて
キャラ分裂命令・ショウルームのキャラ配置があるのだが、ざっと見たところ両方とも生成済みカウントの変動がない
分裂→強制再生成マップでの再生成や、
ショウルーム（強制再生成マップ）でキャラ配置→再生成が起こるとトータルでマイナスになってしまうようだ

ダンジョンクリーナーが配置されたショウルームに入ってまた他のルームに入るとおそらく生成済みカウントを0に出来る

B.生成済みカウントのデータを消す
生成済みカウントはnpcmemory(1,キャラID)としてknpc.s1に保存されている
これを一時退避して起動してもエラーは吐かないので、退避したまま援軍を読むとレベルが足りていれば仲間に出来る
そのあと戻してプレイを続行できる

また、wikiの裏技のセーブデータの削減という項で、結果的にknpc.s1を削除しているように見える
削除されているとするとこれを行っても仲間に出来る可能性ができる

Bは言わずもがなセーブデータを弄るチートなのでそれを分かった上で実行すること

個人的な意見ではあるが、
ダンジョンクリーナーはイスカ・ゴダ・マッドサイエンティストと違いすくつボスにならない
さらにヴェルニースのNPCとして初期生成されることを考えると特殊なユニーク扱いになっているのは設定ミスではないか

結論としてダンジョンクリーナーが仲間になるのは
設定ミスというバグと A.生成済みカウントのバグ or B.データ消去行為 の複合であると私は思う

# [BUG48] 騎乗時の速度計算の際、騎乗側と被騎乗側双方において過剰部位による速度修正が参照されていない問題
refreshSpeed命令

# [BUG49] 変化したキャラクターの元の関係・初期位置が保存されない問題
**概要
変化したとき、現在の関係は引き継ぐが元の関係は引き継がない
また、初期位置も引き継がない
**修正方法
chara_func.hsp 349行目
	if mode=1:x=cx(tc):y=cy(tc)
	p1=cRelation(tc):p2=cAiAggro(tc):p3=cExist(tc):hp=cHP(tc)
↓
	if mode=1{	;変化
		x=cx(tc):y=cy(tc)
		xorg=cXorg(tc):yorg=cYorg(tc)
		p1=cRelation(tc)
		p2=cAiAggro(tc)
		p3=cOrgRelation(tc)
		p4=cTarget(tc)
		hp=cHP(tc)
	;	p3=cExist(tc) ←コメントアウト
	}
chara_func.hsp 387行目
	if mode=1{
		cExist(tc)=cAlive:cx(tc)=x:cy(tc)=y:cRelation(tc)=p1:cAiAggro(tc)=p2:cHP(tc)=hp:cExist(tc)=p3
		map@(cX(tc),cY(tc),1)=tc+1
		}else{
↓
	if mode=1{		;変化
		cExist(tc)=cAlive
		cx(tc)=x:cy(tc)=y
		cXorg(tc)=xorg:cYorg(tc)=yorg
		cRelation(tc)=p1
		cAiAggro(tc)=p2
		cOrgRelation(tc)=p3
		cTarget(tc)=p4
		cHP(tc)=hp
	;	cExist(tc)=p3	←コメントアウト
		map@(cX(tc),cY(tc),1)=tc+1
	}else{
if mode=1{ }に入れたほうが良さそうな部分は入れ、
cExist(,)を保存している部分はコメントアウトした

# [BUG50] 既に盲目の場合、盲目ターン数が加算されない問題
943 : 名無しさん＠お腹いっぱい。 : 2011/04/13(水) 05:06:18.23 ID:CgKKoLoA
逆コンパイルソース111587行目
cbind@con(prm_818) += p@con / 3 + 1
これ他で出てこない関数だけど
cdata(253, prm_818) += p@con / 3 + 1
の間違いかな？
既に盲目の場合盲目ターンが増えてない気がする

944 : 名無しさん＠お腹いっぱい。 : 2011/04/13(水) 05:22:51.98 ID:et2PZpfz
正規ソース見ないと分からんけどcblindの誤字かね

# [BUG51:Fixed] 体重が身長によって決まる上限に達していると痩せられない問題
体重が上限に達してると痩せられない問題は、modweight命令(対象キャラ、変動量、フラグ)中の条件分岐、
「フラグが0なら～」の箇所に「かつ、変動量が0を超えているとき」を加えることで修正される。
これが欠けているために、変動量が負の値でも「対象の体重が上限を超えているなら処理終了」になってしまう。

ダイエットバグ修正
　体重が上限に達してると痩せられない
　対処
　chara_func.hsp 1866行目
　　if mode=0をif &#40;(mode=0)&(a>0))に変更

# [BUG52:Fixed] 維持の付いている生もの装備を食べると、メッセージの後にあなたと表示される問題
**修正方法
chara_func.hsp 576行目
	if sync(tc):txtMore:txt lang(name(tc)+buffTxt@(0,buff),name(tc)+" "+buffTxt@(0,buff)+_s(tc)+buffTxt@(1,buff))
↓
	if buffType(buff)!buffFood:if sync(tc):txtMore:txt lang(name(tc)+buffTxt@(0,buff),name(tc)+" "+buffTxt@(0,buff)+_s(tc)+buffTxt@(1,buff))


# [BUG53] relationBetween関数の記述に誤りがある問題
**概要
chara_func.hsp 57行目
 #defcfunc relationBetween int cc,int tc
	if cRelation(cc)>=cHate{
		if cRelation(cc)<=cEnemy:return cEnemy
		}else{
		if cRelation(cc)>=cHate:return cEnemy
		}
	
	return cNeutral
↓
 #defcfunc relationBetween int cc,int tc
	if cRelation(cc)>=cHate{
		if cRelation(tc)<=cEnemy:return cEnemy
	}else{
		if cRelation(tc)>=cHate:return cEnemy
	}
	
	return cNeutral

これが正しい記述だと思われるが、仕様がかなり変更されるので注意が必要
sameTeamマクロと統合して書き直したほうがいいかもしれない




クエストを含めたNPCとの会話・店の入荷を行うスクリプト。

# [BUG54:Fixed] チュートリアルでPC側の受け答えがおかしい問題
77 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/26 07:03:48 ID:USteEQji
割と細かい不具合(動作に影響なし)

チュートリアル中、宝箱の開け方の部分でPC側の受け答えがおかしい

逆コンソース 175390行目
strbyeをlang("わかった", "Okay.")とかに変更

# [BUG55:Fixed] ラーネイレが死んでいる状態でロミアスをわが家から追い出そうとしたときのイベントが起きない問題
**修正方法
chat.hsp 629行目
	if chatVal=2{
		tc=findChara(33)
		if tc=false{ ;←ここの判定がおかしい
			tc=findChara(34)
			chatMore lang("ラーネイレ…？ どこにいったんだ？ まさか貴様！","You...you scum!"),strBye:hostileAction pc,tc
			goto *chat_end
			}

# [BUG56:Fixed] クエスト報酬素材槌の色等が一致していない問題
84 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/05/24 09:43:30 ID:4cyP8egr
クエスト報酬素材槌の色等が一致していない問題

逆コンitemcreate -1, 630で検索してすぐ下の

inv(24, ci) = ??
となっている部分を

fixmaterial = ??
gosub *label_0265
に変更(3箇所)

# [BUG57:Fixed] アリーナで指定される敵の名前が食い違うことがある問題
乱数が違うので銀眼などのランダムネームは名前が食い違う
依頼などと同様に
cnName(rc)→cnOrgName(cId(rc))
とすれば種族名だけが表示される
ただし『』や≪≫は付かない
逆コンなら
cdatan(0, rc)→refchara(cdata(27, rc), 2, 1)

引数がユニット番号でなくキャラIDであることに注意

# [BUG58:Fixed] 時を止めている間にメイドに話しかけると待機人数以上に来客イベントが追加できる問題
evAdd evVisitor
↓
if gTimeStopTime=0:evAdd evVisitor
で応急処置

逆コンでも
evadd 25のところに
if gdata(801) = 0 {
の条件を追加しておけばよい

リリィを殺すイベントでもリリィをサンドバッグに吊るして時を止めることで同様のことができるが
特に進行に問題は出ないので放置

# [BUG59:Fixed] ブラックマーケットの商品入荷数がおかしい問題
534 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/23(土) 23:02:33.98 ID:K4vO9SMw
結局noa猫に聞いてきたよー
・ブラックマーケットの商品数に上限が無いのは願いのアイテム数がおかしいのと同様。他と同じで80上限が正しい
~*shop_restock(*label_2265)のif p>80:p=80みたいなのを一個後の処理と入れ替え

# [BUG60] 後に入荷したアイテムが先に入荷した同じアイテムの個数を上書きする問題
558 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 05:22:00.73 ID:RjXe18TX
NPCお店の入荷時の処理についてだけども
item_create -1, dbId
した後で
iNum(ci) = rnd(rtVal) + 1
で入荷個数の調整してるよな？
これ
noStack = true
してないんで同じアイテム入荷した場合、スタック後に個数書き換えに
なってないか？
これが意図通りの動作なのかは分からないけどまずい気がする

560 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 08:24:30.86 ID:jzS1U4/o
~>>558
してみたら交易品が爆発したぞ

561 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 09:08:45.00 ID:RjXe18TX
~>>560
おぉう、交易店はさらにその後２倍、場合によってはさらに２倍もしくは
半分、場合によってはさらに半分みたいな処理がiNum(ci)に対して入ってるね
パン屋さんあたりは入荷数増えて嬉しくなるんだが…どうしたもんだか

564 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 09:46:03.55 ID:tvBbSNWZ
~>>561
っつかnostack入れないとスタックすらされずに個数上書きされてね？
どちらにしろさらに調整しないとバランス大きく変化するから個人的には放置でもいい気がする

# [BUG61:Fixed] 生化学者の野望クエストに誤字がある問題
**修正方法
chat.hsp 1591行目
ボールのLV以下の相手には効かないから
↓
ボールのLV以下の相手にしか効かないから




情報画面の表示・願いの処理を行うスクリプト。
#contents


# [BUG62:Fixed] 乗馬時の武器重量判定が誤って表示される問題

~*show_weaponStatラベル(*label_2049)
"装備中の"+itemName(cw)+"は乗馬中に扱うには重過ぎる。"を含むif文がすぐ上のrepeat-loop文より外にあるため、
素手の場合repeat-loop文の中でcwが書き換わらず、誤ったアイテムで重量判定が行われてメッセージが出ることがある
例えば起動直後に乗馬しながら適当な武器を外して素手にした場合0番のアイテムを参照して重量判定が行われる
特に実害のないバグなので放っておいても問題はないが、repeat-loop文の中に入れてしまってもいいかもしれない

**再現方法
ピアニストで開始→ヴェルニースで適当なペットを仲間にする→装備を全て外し、アイテムを全て置く
→グランドピアノ、武器の順に拾う→武器を装備→乗馬→elonaを終了
→elona起動→武器を外す→装備中のグランドピアノは乗馬中に扱うには重過ぎる。とメッセージが表示される

**修正方法
command.hsp 3205行目
 	if cc=pc:if gRider!0{
		if iWeight(cw)>=def2HandWeight : txt lang("装備中の"+itemName(cw)+"は乗馬中に扱うには重過ぎる。",itemName(cw)+" is too heavy to use when riding.")
 		}
	return
1.22逆コンパイル　152500行目付近

# [BUG63:Fixed] lキー(周囲を見る)でのターゲット選択キー表示がずれる問題
101 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/22(火) 21:19:32.36 ID:X0FeyyND
大広間とかで、ペットが視界の外で出現した敵に向かっていく問題の修正。
場所はdmghp命令内、経験値を加算してcdata(201, 勝利ユニット(== 死因)番号)を0にした後。

「勝利ユニットがPCかペットなら、そのユニットとPCの敵対ユニット番号、pcattackerの3つの値を0にする」
の記述を追加。

z→任意のキーで出るターゲット選択キー表示のずれ。
これは遠隔弾の表示ずれと原因は同じ。
場所は*label_1953。
display_key x * inf_tiles + inf_screenx - 12, y * inf_tiles - 12, cnt
↓
display_key x * inf_tiles + inf_screenx - 12, y * inf_tiles + inf_screeny - 12, cnt


# [BUG64] 願ったアイテムの生成数が想定外の値になっている問題
763 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/10(日) 19:18:32.58 ID:D0q/5C9v [2/4]
そーいやBF以外のヴァリアントの中の人って
~>願い時のアイテムの生成数の修正
これ対応してるんかな？
いちお猫さんに確認済みの不具合なんだけど

オリジナル
command.hsp
1600行目～1604行目と1605行目～1607行目を入れ替え

逆コンパイル(公式1.22開発版)
149690行目～149704行目と149705行目～149713行目を入れ替え

# [BUG65:Fixed] F11キーによるキャラクター情報がうまく出力されない問題
895 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/11(月) 23:20:44.41 ID:bWZeLLpK
餅のアイテム自慢スレに未出と思われるバグ情報が出ていたので一応記載。

F11キー押したときに出る装備の情報が投擲以下からしか出ない。
本家、BF版、ore_hack版の全てで確認。まぁ優先度の低いバグではあるけど。

896 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/11(月) 23:58:08.18 ID:fluqO+BO [5/5]
"装備なし"で検索して見つかる行から次に最初に見つかるgosubのすぐ後ろに
notesel buff
を追加すればちょっとマシになる…んだがまだなんかおかしい気がする
内容これであってたっけか？
例：★《賢者の兜》
頭:
～イルヴァ幻想辞典～ 1.5s
見えない者を見ることが出来る兜だ
それはミスリルで作られている
それは酸では傷つかない
それは炎では燃えない
それは貴重な品だ
それはDVを4上昇させ、PVを15上昇させる
それはより高度な詠唱を可能にさせる [*]
それは死体を残しやすくする [**]
それは魔法への耐性を授ける [**]
それは幻惑への耐性を授ける [***]
それは魔力を5上げる
それは透明な存在を見ることを可能にする
それは混乱を無効にする

賢者がより高みを目指す為に製作した兜。身につけることで知識が深まり、
本来見えない存在まで見ることが出来るという。
～イルヴァ幻想辞典～

903 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/12(火) 00:34:57.54 ID:YFaV4Hnu
~>>896に加えて"装備なし"で検索して見つかる行の前後にある変数qをqqqなりの
別の変数名に書き換えれば概ね大丈夫になるっぽい
意図した情報が表示しきれて無い気がするけどこれは問い合わせるしかないな
原因としてはnoteselでのバッファ切り替え不備＋グローバル変数名の重複による
変数内容の上書きの合わせ技かな

# [BUG65] F11のキャラ情報出力で狂気度が0固定になっている問題
**修正方法
command.hsp 4588行目
	s(3)="狂気度    : 0"
↓
	s(3)="狂気度    : "+cSAN(pc)

# [BUG66] ムーンゲートによるランダムゲート機能が無効化されている問題
69 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/23 19:41:13 ID:pQkMm0iG
微妙に感じていた違和感が解消できたので投下

現象：ムーンゲートによるランダムゲート機能が無効化されている
対策：command.hspの79行目にある" : goto *pc_turn"を削除
※譲渡されたソースでのみ発生すると思われる

# [BUG67] 召喚石でのレベル表示がおかしい問題
召喚石を使った際のCNPC一覧のレベル表示は
mes "" + userdata(2, i)　となっているが、
これだと該当ショウルームに存在する以外のCNPCが読み込まれている場合、違うCNPCのレベルを表示してしまうことがあるため
CNPCの名前をlistn(0, listmax)に代入する処理のあたりでCNPCのレベルも適当な変数（list(1, listmax)とか）に代入してそれを表示すると良い


# [BUG68] NPCに宝の地図等を渡すと何度も読み続ける問題
ペット以外に渡したとき宝の地図・物件の権利書系は何度も読み続けてしまう
if ( inv(3, ci) == 16 | inv(3, ci) == 245 )
のあたりで除外条件を増やして対処する

command.hsp 3801行目

# [BUG69:Fixed] ペットのフィートの表示がおかしい問題
PCがエーテル製の装備をしているとペットの「特徴と体質」にも「彼（彼女）のエーテル病の進行は早い」と表示されてしまう
if ( gdata(800) != 0 ) {　の前に　if ( tc == 0 ) {　を入れると良い

# [BUG189:Fixed] PCがフィートを取得可能な状態だとペットの「特徴と体質」にも「取得できるフィート」と表示されてしまう
検索して一番最初の　if ( gdata(93) > 0 ) {　の前に　if ( tc == 0 ) {　を入れると良い

# [BUG70:Fixed] 装備していないアイテムのエンチャントが特徴と体質に表示されることがある問題
装備によって付与される特徴がまったく関係ないキャラクターの「特徴と体質」にも表示されてしまうことがある
上記の　if ( gdata(800) != 0 ) {　のちょっと下辺りの　repeat 30, 100　で装備品のエンチャントをチェックしているが、
if ( cdata(cnt, tc) \ 10000 != 0 ) {　の下で無条件でciのエンチャントをチェックしているため
if ( cdata(cnt, tc) \ 10000 != 0 ) {　を満たさずciに代入されなかった場合、直前のciがそのまま使われることになるのが原因
if ( cdata(cnt, tc) \ 10000 != 0 ) {　のブロックに　repeat 15　のループも突っ込めば大丈夫なはず

# [BUG71:Fixed] 攻撃倍率が100以上のときに小数点より下が表示されない問題
calcAttackDmg(1)で検索して出る少し下あたり
strmid(s(2),0,3+(int(s(2))>=10))
↓
strmid(s(2),0,3+(int(s(2))>=10)+(int(s(2))>=100))
これでおｋ

# [BUG72] 錬金術・調合・ガロクの槌で大事なもの指定が無視されている問題
問題というほどでもない気がするが

錬金術・ガロク
command.hsp　3960行目あたり
2個目のif invCtrl=23{　のすぐ下に
if (invCtrl(1)=4)or(invCtrl(1)=7):ifnodrop ci:goto *com_inventory_loopを追加でおｋ

~*com_inventoryの最初を見れば分かるがinvCtrl(1)=4が錬金術・invCtrl(1)=7がガロク

調合(blend.hsp)
"を選んだ。"で検索して出てくるすぐ上に
ifnodrop ci:_continue　を追加
このままだとSEがおかしいのでsnd seDrinkの行をifnodropの行の直後に移動しておく

include順がblend.hsp→command.hspなので
command.hsp 26行目
define ifnodrop(%1)～の行を
define global ifnodrop(%1)～として
blend.hspの上の方に移動しておく

逆コンなら2個目のif ( invctrl == 23 ) {　の行のすぐ下に
 if ( invctrl(1) == 4 | invctrl(1) == 7 ) {
	if ( ibit(13, ci) ) {
		snd 27
		txtvalid = 0
		txtc = 1 + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "")
		txtc = rnd(txtc)
		txt_select lang("それはあなたの大事なものだ。<調べる>メニューから解除できる。", "It's set as no-drop. You can reset it from the <examine> menu."), "", "", "", "", "", "", "", ""
		tcol@txtfunc = 255, 255, 255
		goto *label_2060
	}
 }
を追加

146000行目付近
snd 17をコメントアウト
rpref(10 + step * 2) = ci, inv(3, ci)の行のすぐ下に
 if ( ibit(13, ci) ) {
	snd 27
	txtvalid = 0
	txtc = 1 + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "") + ("" != "")
	txtc = rnd(txtc)
	txt_select lang("それはあなたの大事なものだ。<調べる>メニューから解除できる。", "It's set as no-drop. You can reset it from the <examine> menu."), "", "", "", "", "", "", "", ""
	tcol@txtfunc = 255, 255, 255
	goto *label_1928
 }
 snd 17
を追加

# [BUG73] 掲示板から依頼主の元に飛んで足元の罠で死んだ場合も依頼が受けられる問題
依頼主に飛ぶのは接近のスキルを使っており、
テレポート系は移動処理(*procMove)をはさむので足元に罠があれば判定がある

依頼主に会う？　で検索して出るあたり
questTeleport=true　の前にif cExist(pc)=cAlive:を追加

逆コンでも同様に
if ( cdata(0, 0) == 1 ) {
　questteleport = 1
　gosub *label_2242
}
とでも条件を付けておく

# [BUG74] NPCのインベントリを見たとき、(利腕)の表示が実際と食い違う問題
command.hsp *com_inventoryラベル
3315行目付近
mainWeapon=-1
↓
mainHand=-1

3360行目付近
if iEquip(cnt)!0:if mainWeapon=-1:if refType=fltWeapon:mainWeapon=cnt
↓
if iEquip(cnt)!0:if (mainHand=-1)or(iEquip(cnt)<mainHand):if refType=fltWeapon:mainHand=iEquip(cnt)

3637行目付近
if p=mainWeapon:s+=lang("(利腕)"," (Main hand)")
↓
if iEquip(p)=mainHand:s+=lang("(利腕)"," (Main hand)")

「インベントリの上から数えて最初の武器」となっていたのを
「キャラデータの上から数えて最初の部位の武器」とし、実際の計算と一致させてみた
多分これで大丈夫なはず…

逆コンパイルソースなら
153100行目付近
mainweapon = -1
↓
mainhand = -1

153200行目付近
if ( mainweapon == (-1) ) {
　if ( reftype == 10000 ) {
　　mainweapon = cnt
　}
}
↓
if ( mainweapon == (-1) | inv(18, cnt) < mainhand ) {
　if ( reftype == 10000 ) {
　　mainhand = inv(18, cnt)
　}
}

153800行目付近
if ( p == mainweapon ) {
　s += lang("(利腕)", " (Main hand)")
}
↓
if ( inv(18, cnt) == mainhand ) {
　s += lang("(利腕)", " (Main hand)")
}

# [BUG75:Fixed] アイテム最大数を超えてアイテムを置ける問題
772 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2007/11/20(火) 23:50:23 ID:BIqGzqc6
~>>本スレ 40
~>ところで、話は変わるんだけど、うちのセレブ邸アイテム（と家具）で今300個ギリギリなんだけど
~>この状態で普通のアイテムを置くとそれ以上置けないといわれるんだけど
~>家具を置くとどんどん置けていっちゃうんだよね･･･

え”？と思って処理を眺める。
……うん、"家具"なら置けるように処理されてるね。
でも、その前(家具かどうかの判断の前)に最大数(400個の方)のチェックは
別にやってるんで
>既知のバグかな？後、古城とかでも発生するかな？古城だと400個越えた時点でどれかのアイテムが
>破壊されそうな気がするから怖いけど
は大丈夫かと。

776 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2007/11/22(木) 00:37:07 ID:/ujn9YGE
シェルターにアイテム置いていたら、
シェルターには6個のアイテムと0個の家具がある（アイテム最大5個）
って最大より1個多く置けるんだけど、これは仕様？他の建物でもそうなんだろうか。

777 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2007/11/22(木) 00:47:01 ID:Lnor7FLJ
店でもその現象起こったな

**概要
アイテム最大数を超えても400個までなら家具を置ける
アイテム最大数を1個超えて任意のアイテムを置ける
前者は仕様、後者は不等号のミスである可能性が高い
**修正方法
command.hsp 3669行目
 			if mMaxInv!0:if inv_sum(-1)>mMaxInv : if iType(ci)!fltFurniture:txt lang("これ以上は置けない。","You can't drop items any more."):snd seFail1:goto *com_inventory_loop
↓
 			if mMaxInv!0:if inv_sum(-1)>=mMaxInv : if iType(ci)!fltFurniture:txt lang("これ以上は置けない。","You can't drop items any more."):snd seFail1:goto *com_inventory_loop


# [BUG76] スペル表示画面に無意味な数値が表示されている問題
170 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/19(火) 01:42:29.15 ID:QS55o+CL
v画面で見る鑑定・解呪・清浄なる光・全浄化のパワーには
calcskillで計算されたbonusが使われてるけど実際の判定には元のスペルパワーしか使われてない

v画面で見るホーリーヴェイルのパワー・c画面で見るホーリーヴェイル系のパワーには
calcbuffで計算された値が使われてるけどこれも実際の判定に使われてない気がする

**概要
契約のbonus値は判定に使われているので問題ない
それ以外を非表示にしてしまうとよい

command.hsp 2226行目

# [BUG77] ポピーからアイテムを受け取れたり、ブリーダーなどに指定できる問題
**修正方法
command.hsp 461行目
	if allyCtrl!1:if cBit(cBodyguard,cnt)=true:continue
↓
	if allyCtrl!1:if (cBit(cBodyguard,cnt)=true)or(cBit(cGuardTemp,cnt)=true):continue

command.hsp 1834行目
		if tc<maxFollower :if cBit(cBodyguard,tc)=false: goto *com_allyInventory
↓
		if tc<maxFollower :if cBit(cBodyguard,tc)=false:if cBit(cGuardTemp,tc)=false : goto *com_allyInventory

# [BUG78] ペットにおみやげを渡したときの挙動がおかしい問題
**概要
ペットにおみやげを渡す→xキーで再現する。

ペットインベントリの状態が初期化されない。
また、ペットのときに連続渡しが出来なかったり、ペット以外に渡したときにターンが経過しない。
**修正方法
command.hsp 3763行目
			if iId(ci)=idGift{
				txt lang("あなたは"+name(tc)+"に"+itemName(ci,1)+"をプレゼントした。","You give "+name(tc)+" "+itemName(ci,1)+".")
				iNum(ci)--:call calcBurdenPc
				txt lang("「え、これを"+_ore(3)+"にくれるの"+_ka(1)+""+_thanks(2)+"」",cnvTalk("Thank you!"))
				modImp tc,giftValue(iParam4(ci)):cEmoIcon(tc)=emoHeart+extEmo*3
				gosub *screen_draw:goto *pc_turn
			}
↓
			if iId(ci)=idGift{
				txt lang("あなたは"+name(tc)+"に"+itemName(ci,1)+"をプレゼントした。","You give "+name(tc)+" "+itemName(ci,1)+".")
				iNum(ci)--:call *calcBurdenPc
				txt lang("「え、これを"+_ore(3)+"にくれるの"+_ka(1)+""+_thanks(2)+"」",cnvTalk("Thank you!"))
				modImp tc,giftValue(iParam4(ci)):cEmoIcon(tc)=emoHeart+extEmo*3
				if invAlly=true:goto *com_inventory
				goto *turn_end				
			}
他のアイテムと同様、ペットの場合連続渡し可能に、ペット以外のときターン経過するようにしてみた。

# [BUG79:Fixed] 媚薬を渡したとき重量再計算が行われない問題
**修正方法
command.hsp 3829行目
					modImp tc,-20:cEmoIcon(tc)=emoAngry+extEmo*3:iNum(ci)--
↓
					modImp tc,-20:cEmoIcon(tc)=emoAngry+extEmo*3:iNum(ci)--:call *calcBurdenPc

# [BUG80:Fixed] 技能一覧が主能力順にソートされていない問題
**修正方法
command.hsp 1755行目
	if spAct(cnt)!0:list(0,listMax)=cnt+headSpAct,skillUse(cnt)*1000+cnt:listMax++
↓
	if spAct(cnt)!0:list(0,listMax)=cnt+headSpAct,skillUse(cnt+headSpAct)*1000+cnt:listMax++

# [BUG81] 自己認識の技能が正しく機能していない問題
**修正方法
command.hsp 631行目
	sdata(cnt,rc)=1
↓
	sdata(cnt,r1)=1
command.hsp 639行目
		p=sdata(cnt,rc)-1
↓
		p=sdata(cnt,r1)-1

command.hsp 619行目をコメントアウトしたり、
proc.hsp 2120-2121行目に


	if cc!pc:txtNothingHappen
と挿入してもいいかもしれない







defineマクロの設定・テキストの表示を行うスクリプト。

# [BUG82] 魔力制御の対象が誤っている問題
975 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/17(木) 00:59:50.55 ID:04wseWc/ [1/2]
魔力制御の計算命令(calcmagiccontrol)に誤り。
関係が0以上同士と-1以下同士の時に魔力制御の対象になっているが、
これだと敵対(-3)vs無関心(-1)の交戦でボールやボルトを使っても相手に当たらない。
そこで条件を「0以上同士、-1同士、-2以下同士」に変更。
スウォーム攻撃の除外判定も同じ条件でいける。

**修正方法
init.hsp 3510行目
 #define global ctype sameTeam(%1,%2) ( ((cRelation(%1)>=cNeutral)&(cRelation(%2)>=cNeutral))or((cRelation(%1)<=cDislike)&(cRelation(%2)<=cDislike)) )
↓
 #define global ctype sameTeam(%1,%2) ( ((cRelation(%1)>=cNeutral)&(cRelation(%2)>=cNeutral))or((cRelation(%1)=cDislike)&(cRelation(%2)=cDislike))or((cRelation(%1)<=cHate)&(cRelation(%2)<=cHate)) )

# [BUG83:Fixed] 無効耐性を複数持つモンスターの2個目以降の耐性が機能していない問題
323 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 21:47:30.14 ID:Myv4aFO+ [3/4]
もういっちょ、やっとマクロが何なのか分かってきたんだぜ
init.hsp内のresImmマクロがうまく機能してないため二つ目三つ目の耐性が無効に
二三行目の条件をrsRes%2!0みたいにすれば多分直る。ついでにその上のresWeakも直すといいかも
BF最新版でも一応確認してきたけど神経ブレスで目玉がミンチになったから未修正っぽい
逆コンならとりあえず幾つかのif ( nerve != 0 ) の中を実行するように
なお、既存敵で複数耐性を持つのは目玉のみの模様(幻惑、神経)


# [BUG84] エラーテキストのショウルーム判定が誤っている問題
エラーテキストのところでareShowHouseとあるが
areaShowHouse(逆コンなら35)のミス
これにより意図しないときに(possibly)invalid show roomのエラーテキストが吐かれていた
過去のエラー文を漁るときは気をつけておくこと


# [BUG85:Fixed] 過去メッセージの透過を有効にしているとき、ログが一部透明化する問題
txt_conv命令内
if cfg_msgTrans@{ }
と
msg_newLine:tNew@=falseの処理順を入れ替え

さらにif cfg_msgTrans@{ }内の
gcopy selInf,496,536,x,inf_msgSpace@*4
↓
gcopy selInf,496,536,x,inf_msgSpace@*3

これでおｋ

逆コンでも同様に
if ( cfg_msgtrans ) { }
と
msg_newline
tnew = 0
を入れ替え

gcopy 3, 496, 536, x@txtfunc, inf_msgspace * 4
↓
gcopy 3, 496, 536, x@txtfunc, inf_msgspace * 3

# [BUG86] 「」付きのセリフが着色されないことがある問題
**概要
「」付きのセリフは自動的に文字色が緑になる
ただし、「」付きのセリフを黄色で表示したいときはtColFixというフラグを送っている
このフラグは「」付きの文字を表示したときと、他の文字色を指定したときしかリセットされない

「」付きでない黄色のメッセージを表示→「」付きのセリフを表示、とすると最初だけ文字色が白になる
適当なところで初期化が必要

**修正方法
init.hsp 4024行目
	tColFix=false
を挿入

3901行目・3973行目・4005行目の:else:tColFix=falseをコメントアウト

# [BUG87] エンチャントにおいて属性が意図通り決定されていない問題
属性のレア度を比較するとき参照先が間違っていて関数が機能していない
init.hsp 2846行目付近
#define global ctype skillRare(%1)sdataRef@(4,%1)
↓
#define global ctype skillRare(%1)sdataRef@(3,%1)

item_data.hsp 213行目付近
#defcfunc randomEle内
if p!1{
↓
if skillRare(p)!1{

逆コンでは13300行目付近
#defcfunc randomele 内
if ( p@m45 != 1 ) →if ( sdataref(3, p@m45) != 1 )
sdataref(4, p@m45)→sdataref(3, p@m45)　 (2ヶ所)
sdataref(4, i@m45)→sdataref(3, i@m45)

ただしこのまま修正すると大幅なバランス変更になってしまうので
encAddのところで
enc=randomEle()
↓
enc=rnd(tailResist-headResist)+headResist (2ヶ所)
と、なかったことにしてバランスを変えない方が無難かもしれない


# [BUG88] ノルンのガイドが一部ワールドマップ歩行中に表示されない問題
**概要
ガイドは継続行動中は表示されない
1時間ごとの天候変化時しかガイドの判定を行っていないので、
例えばワールドマップ歩行中に天候がエーテルの風になってもノルンは出てこない

**修正方法
init.hsp 4271行目
	#define global help(%1,%2=0) if cfg_extraHelp@:if gData@(helpHead+%1)=false:（略）
この行をコメントアウト

init.hsp 4754行目(末尾)
	#module
	#deffunc help int helpNo,int helpMode
	if cfg_extraHelp@:if gData@(helpHead+helpNo)=false:if mode@=mode_main{
		if (cActionPeriod(pc)=0)or((helpMode=2)&(cRowAct(pc)=rowActTravel)){		
			gdata@(helpHead+helpNo)=true
			gHelp@=helpNo
			gosub *elona_help@
			if helpMode=1:screenUpdate@=-1:gosub *screen_draw@
		}
	}
	return
	#global
を追加

action.hsp 714-715行目
		if gWeather=weatherHardRain	:help 11,2
		if gWeather=weatherSnow		:help 12,2
		if gWeather=weatherEther	:help 13,2
を挿入

1歩ごとに判定を入れ、ついでにマクロをdeffunc化した







# [BUG89] 運勢を維持するエンチャントが付いた装備を食べると落ちる問題
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

# [BUG90:Fixed] 生もの製の武器を食べたときのメッセージがおかしい問題
910 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/12(火) 13:20:58.67 ID:xxwKthJG
oreで軽いバグ？報告
食用ＡＦで魅力１魔力１増加の手袋食べた時の表示が、「衰えた」になっている
経験置はちゃんと増加していた
**修正方法
公式1.22でも起こるバグ
item.hsp 1193行目
			skillExp enc,cc,calcEncAttb(iEncP(cnt,ci))*100*(1+(cc!=pc)*5)
			if sync(cc):if iEncP(cnt,ci)>=0:txt lang(name(cc)+"の"+skillName(enc)+"は発達した。",name(cc)+his(cc)+" "+skillName(enc)+" develops."):else:txt lang(name(cc)+"の"+skillName(enc)+"は衰えた。",name(cc)+his(cc)+" "+skillName(enc)+" deteriorates.")
↓
			skillExp enc,cc,calcEncAttb(iEncP(cnt,ci))*100*(1+(cc!=pc)*5)
			if sync(cc):if calcEncAttb(iEncP(cnt,ci))>=0:txt lang(name(cc)+"の"+skillName(enc)+"は発達した。",name(cc)+his(cc)+" "+skillName(enc)+" develops."):else:txt lang(name(cc)+"の"+skillName(enc)+"は衰えた。",name(cc)+his(cc)+" "+skillName(enc)+" deteriorates.")


# [BUG91] 生もの製の生きている武器に料理ランク補正がかかる問題
料理ランクと生きている武器の経験値は同じ変数inv(26,)で管理されているので
生もの製の生きている武器を食べると最大で料理ランク100相当の満腹度補正がかかる
気になるなら生きている武器ビットを使って回避しておく

# [BUG92:Fixed] 食べ過ぎフラグが機能していない問題
565 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/24(日) 10:11:39.97 ID:rMmy3Wy1
食事時の体重増加も満腹度増やした後に持ってこないといけない気がするな

**概要
満腹度増やす前に満腹度の判定をしているのでmodweightに食過ぎフラグが送られない
ただし、この修正を行うとやたらとキャラクターが太るので要調整

**修正方法
item.hsp 1086行目
 	if nutrition>=3000:if (rnd(10)=0)or(cHunger(cc)>=hungerBloated):modWeight cc,rnd(3)+1,cHunger(cc)>=hungerBloated
 
	cHunger(cc)+=nutrition
↓
 	cHunger(cc)+=nutrition
	if nutrition>=3000:if (rnd(10)=0)or(cHunger(cc)>=hungerBloated):modWeight cc,rnd(3)+1,cHunger(cc)>=hungerBloated

# [BUG93] 固定AFの冒険者交換によりランダムAFが増殖する問題

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

# [BUG94] 盗賊団の頭領の落とす交易品の数がおかしい問題
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


# [BUG95:Fixed] ブルーカプセルドラッグが落ちない問題
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

# [BUG96:Fixed] 終焉の書が生成されない問題
アイテム生成処理のところで古書物の内容を決定する部分は
inv(25, ci) = rnd(rnd(limit(objlv / 2, 1, 14)) + 1)　となっているが、
これだと終焉の書が出ないため14ではなく15にする






# [BUG97] 家具の素材変化で価格計算が誤っている問題
15 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/13 12:15:20 ID:tD9Rf2t+
~*label_0265のところで素材変化の際に素材別の価格修正を元に戻す処理を行っているが、
家具もそれ以外もまとめて「価格 = 現在価格 * 100/ 素材別の価格」という処理をしているため、家具を素材変化すると価値がおかしくなる
家具の場合は「価格 = 現在価格 - 素材別の価格 * 2」という処理を行うのが正しいはず

16 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/13 12:20:21 ID:EM2awrog
あ、多分それその前に接頭語分も戻さないとだめです
「価格 = 現在価格 * 100 / (80 + 修飾子ID * 20)」の後に
「価格 = 現在価格 - 素材別の価格 * 2」でＯＫなはず

18 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/13 20:47:47 ID:8KEbhTge
追補足で
~>「価格 = 現在価格 * 100 / (80 + 修飾子ID * 20)」
コレするときは(修飾子ID != 0)ってif必要かな、多分


家具価値再計算バグ修正
　修飾子の付いている家具を素材変化すると価値がおかしくなる
　対処
　item_data.hsp 1183行目
　　originalValue=iValue(ci)*100/mtRef(1,p)で素材価値適用前の価値を
　　計算している部分を
　　・家具の場合
　　・修飾子が付いている場合
　　を加味して計算するように変更する
　　以下、例
　　if ( refType = fltFurniture ) {
　　　//　家具の場合
　　　if ( iSubName(ci) != 0 ) {
　　　　//　修飾子がある場合
　　　　originalValue = iValue(ci) * 100 / (80 + iSubName(ci) * 20)
　　　} else {
　　　　//　修飾子がない場合
　　　　originalValue = iValue(ci)
　　　}
　　　originalValue = iValue(ci) - mtRef(1, p) * 2
　　} else {
　　　//　家具以外の場合
　　　originalValue = iValue(ci) * 100 / mtRef(1, p)
　　}

# [BUG98:Fixed] 時を止めるエンチャントの*個数がおかしい問題

40:稀に時を止める
の*表記が効果値そのままで表示されてるためよほど運が良く(悪く？)ないと
~*****+で表示されてるってのかなり前に出てた気がするけどまだそのままなのな…

**修正方法
エンチャント値が4以下でないと*****+表記になっていた

item_data.hsp 445行目
	encDisp encStopTime		,4,0,lang("稀に時を止める","occasionally stops time.")							,val(1)
↓
	encDisp encStopTime		,4,0,lang("稀に時を止める","occasionally stops time.")							,val(1)/100

こうすれば*の数とターン数が一致する



# item_func.hsp

# [BUG99:Fixed] マップ内に気持ちいいことをしているキャラがいると0番のアイテムが使えない問題
112 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/01/08 20:24:13 ID:cipblfoQ
>130：以下、名無しにかわりましてVIPがお送りします[] 2011/12/31(土) 09:41:08.87 ID:osu6Od0I(1)
>昨日「そのアイテムは他の誰かが使用中だ」のバグで旅糧が食えねえよって書き込んだ者だけど、
>原因？と回避方法分かったわ。
>
>コンソールの"3"コマンドで持ち物リストを表示して、0の位置に食べ物系アイテムが入ってる場合、
>その食べ物を、マップ内に気持ち良い事をしてるキャラが居る時に食おうとすると、
>「そのアイテムは他の誰かが使用中だ」って表示されて食えない。
>
>回避するには、該当の食べ物系アイテムを持ち物リストの0の位置から動かせば良い。
>該当の食べ物を地面に置いて、インベントリにない適当な他のアイテムを拾えばおｋ

cdata(140,ユニットNo.) = 11:気持ちいいことのときは当然
cdata(142,ユニットNo.) : 継続行動使用中アイテムNoに0が入っているので0の位置に旅糧があると引っかかる
itemusingfindのあたりで11:気持ちいいことの場合を除外しておくのがいい気がする

# [BUG100] ランダムネフィアのボス生成時に中身の違うシェイドが選ばれた場合奇跡品質で生成されない
著しい問題があるわけではないので放置してもいいかも

# [BUG101] 地面にあるアイテムを鑑定して手元にスタックした時に重量の再計算が行われない問題
地面にあるアイテムを鑑定して手元にスタックした時に重量の再計算が行われないので、
item_stack内のcell_refreshのあたりで重量再計算のサブルーチンに飛ばすといいかもしれない

# [BUG102] 荷車の重量がオーバーフローする問題
荷車の重量がオーバーフローすることがある（らしい。未確認）ためinv_weightのところで
gdata(80) += inv(7, cnt) * inv(0, cnt) * (-1)　となっているのを
gdata(80) += limit(inv(7, cnt) * inv(0, cnt) * (-1), 0, 10000000)　みたいな感じでアイテム一種類あたりの重さを制限してやると良い？
何かもうちょっとスマートな対策があったら教えてください


# [BUG103] スウォーム等で同時に殺害したキャラクターのドロップ品が同じものになってしまうことがある問題
s(1) = random_title(1)　で武器の銘を代入した直後に randomize　しているが、アニメーションをオフにしている場合など
非常に短い時間でこの部分を繰り返した場合は　randomize　の時間取得の精度の関係か乱数の種がすべて同じになってしまうのが原因
randomize timeGetTime()　とすれば多分大丈夫
**修正方法
item_func.hsp 597行目
 	randomize iSubName(id)-headEgoTitleSp
	if iQuality(id)=fixGreat:s+=lang("『"," <")+random_title(1)+lang("』",">"):else:s+=lang("《"," {")+random_title(1)+lang("》","}")
	randomize
↓
	randomize iSubName(id)-headEgoTitleSp
	if iQuality(id)=fixGreat:s+=lang("『"," <")+random_title(1)+lang("』",">"):else:s+=lang("《"," {")+random_title(1)+lang("》","}")
	randomize timeGetTime()

# [BUG104] クーラーボックスやシェルターのデータが削除されないことがある問題
239 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 12:40:20.59 ID:KZcyku1m
修正方法まだ調べてないけど不具合をメモ代わりに投下

★クーラーボックスをどこかに置くなりしてなくした場合に対応する
インベントリ情報が格納されたファイルが削除されずにセーブデータに
残り続ける
内部処理的にはわが家で使用人を募集->(話しかけて在庫確定後)解雇で
在庫ファイルが消えないのと似てる

245 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 18:01:21.77 ID:zlLIltSh
シェルター設置したまま設置したMAP再生成なりするとシェルターのデータは残りっぱなしになるよ

247 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 18:46:16.77 ID:d8Qa9urR
シェルターはaction内の162～169行目(撤去時の処理)をitem_funcのitem_deleteにもコピペすればいいのかな
クーラーボックスはどこだろ

250 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 20:37:18.53 ID:KZcyku1m
~>>245
あー、マップデータ残るのはその場合だけ…かな？
燃えたり、砕けたりはしないんだっけ？、シェルター
撤去時にマップデータ削除はしてるし、ただアイテムとして存在してる分には
結びついたマップデータは存在しないはずだからとりあえずは後回しでいいな

~>>247
それ見て気付いたけどシェルター撤去時のマップデータ削除って中身気にせず
単純ファイル削除なんだよな…
つまり中にクーラーボックスがあった場合…

・セーブされないマップ(野外など)
・シェルター内(撤去時)
・街等のリニューアル有マップのリニューアル時
辺りで対処要るかな？

253 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 21:09:26.31 ID:d8Qa9urR
そういえば再生成するマップでは建設できないんだった
後は持たせて縁切りとか？

254 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/27(日) 21:35:30.85 ID:KZcyku1m
縁切りと同じようなもんだけど売り飛ばしとかもかな
これはchara_func.hsp内のdel_charaでinv掃除してるところ(iNum(cnt)=0)を
item_deleteに変えてitem_delete側で対処すれば良い気がする
んーっと…
#deffunc item_delete int a
　if (iFile(a) != 0) {
　　invfile = exeDir@ + "tmp\\" + "shop" + iFile(a) + ".s2"
　　exist invfile
　　if ( strsize != -1 ) {
　　　delete invfile
　　　fileAdd invfile, 1
　　}
　}
　memset inv@(0, a), 0, maxItem * sizeInt
　return
思いつきのてきとーだけどこんな感じ？多分
iIdでの判定もやっといたほうが確実かもー

127 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/03/17 21:25:18 ID:wVuBXJwE
・>>81のクーラーボックスの処理に付いて
item_func.hspのincludeがmodule.hspより先なので
fileAdd命令をこのまま書くと落ちる
include順を変えると別のところで問題が出るので

HSP開発wiki:ユーザー定義命令・関数の宣言と定義を分離して記述する（URL弾かれるので省略）
このページを参考にプロトタイプ宣言もどきを行って回避する

init.hspの末尾に
#module
#deffunc fileAddFake str s,int mode　;←fileAddと同じ引数の型
goto *fileAddCore@defineFileAdd　　　;@fileAddのモジュール空間名
#global

を追加し、

#module defineFileAdd　　　　　　；モジュール空間名を指定する
#deffunc fileAdd str s,int mode
~*fileAddCore　　　　　　　　　　 ；モジュール内ラベルを追加
（略）

とする
さらにitem_delete内でのfileAdd→fileAddFakeとしておくと一応動いてはいるようだ

もっと賢い処理誰か教えてください






キー入力・ターン処理・イベント処理などを行うスクリプト。
他のスクリプトはこのスクリプトに#includeする形で結合されている。
#contents

# [BUG105] 一度も初期洞窟から出ないまま這い上がったときゲーム進行不能に陥る問題
20 名無しさん＠お腹いっぱい。 sage 2011/03/18(金) 19:47:15.15 ID:hOP/Lnw6
新規ゲーム開始時、一度も自宅(洞窟)から出ないまま死亡->這い上がるとした時、
洞窟から出ようとすると「マップのロードに失敗しました」のダイアログが
表示され嵌る問題の修正

オリジナルソース
main.hspの463行目の末尾に「: gHomeLevel = 0 : gosub *setArea」を追加

逆コンパイルソース(Ver1.22)
245350行目付近に
gdata(24) = 0
gosub *label_1752
の２行を追加

休み半日費やしてやっと原因特定とか…orz

# [BUG106:Fixed] ネフィアボス討伐報酬の金貨の量が205枚固定になっている問題
404 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/01(金) 04:19:58.34 ID:tns7sz5b [3/4]
関連とゆーか調べたついでに出てきたこれも多分バグ

ネフィアボスを倒した際に足元に生成される金貨の量が想定外の値になってる

main.hsp 1758行目
flt:item_create -1,idGold,cX(pc),cY(pc),200+iNum(ci)*5
を
noStack=true:flt:item_create -1,idGold,cX(pc),cY(pc):iNum(ci)=200+iNum(ci)*5
に変更

逆根
248157行目のすぐ上に
nostack = 1
を追加
248158行目の末尾のパラメータ(200 + inv(0, ci) * 5)を0に変更
248158行目のすぐ下に
inv(0, ci) = 200 + inv(0, ci) * 5
を追加

で、多分いいんでなかろか
設定値が想定通りかは知らね

# [BUG107] すくつボスの基本レベルが適切でない問題
すくつボスの基本レベル
initlv = gdata(22) / 4
となっているが低層では周りの敵より弱くなり、深層では逆に上がりすぎてしまう
initlv = limit(gdata(22) / 4, 50, 250)
とでもしておくといいかもしれない


# [BUG108:Fixed] 勝利ウィンドウの表示がおかしい問題
288 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/28(月) 18:32:34.81 ID:0T617TrP
~*勝利*ウィンドウの表示不具合修正。
まず、void.bmpの読み込み直後に以下の処理を挿入。
~> pos 0, 0
~> gzoom windoww, windowh, 4, 0, 0, 640, 480

そしてwwに680を、whに488を、pagesizeに0をセットする記述を追加し、
以下の記述でdisplay_windowを実行。
~> display_window (windoww / 2) - (ww / 2) , (windowh / 2) - (wh / 2), ww, wh

# [BUG109] 死んでマップから消滅したはずのユニットが残留し続ける問題
地面効果による当たり判定の後に、ユニットが生存しているか否かの判定がないため、
装備品が呪われているユニットが、マップ効果(火柱や酸)でミンチになったと同時に呪いによるテレポートが発動すると、
テレポート先のユニット表示情報が更新されてしまうのが原因。

main.hsp 749行目

# [BUG110:Fixed] ゲスト冒険者の判定がおかしい問題
Re: Elona開発ファイル所有者の情報交換トピック
投稿記事by ゲスト on 土 1 10, 2015 4:17 pm

気になる処理が2つほどあったのですが、これらは意図されたものなのか分かる方いらっしゃいましたら教えてくださると助かります。

1. main.hsp 1061行目 levelExitBy==mExitNormal
　　　　これは正しくはlevelExitBy=mExitNormalと考えてよいのでしょうか？

2. main.hsp 1848行目 cArea(i)!gArea
　　　　これは正しくはif cArea(i)!gAreaと考えてよいのでしょうか？

もし既出でしたらすみません。

**概要
1の==は=と同じように解釈されているようだ
2はcArea(i)=(cArea(i)!=gArea)と同じように解釈されるので実質的にcArea(i)=1と同じ
冒険者の現在地にエリア番号1が代入されてしまう
また、一連の処理の中でif cImpression(cnt)<cImpression(i):tc=i:p++の部分もおかしい
cntではペットと冒険者の友好度を比較してしまうのでtcの間違いだろう

**修正方法
main.hsp 1844行目
	if (rnd(3))or(develop){
		p=0:tc=0
		repeat 100
		i=rnd(maxAdv)+maxFollower
		if cExist(i)=cAdv:if cBit(cHired,i)=false:cArea(i)!gArea:if cRelation(i)>=cNeutral{
			if rnd(25)<p:break
			if tc=0{
				tc=i:p++
				if cImpression(tc)<defImpHate	:if rnd(12)=0:break
				if cImpression(tc)<defImpEnemy :if rnd(4):break
				continue
				}
			if cImpression(cnt)<cImpression(i):tc=i:p++
			}
		loop
↓
	if (rnd(3))or(develop){
		p=0:tc=0
		repeat 100
		i=rnd(maxAdv)+maxFollower
		if cExist(i)=cAdv:if cBit(cHired,i)=false:if cArea(i)!gArea:if cRelation(i)>=cNeutral{
			if rnd(25)<p:break
			if tc=0{
				tc=i:p++
				if cImpression(tc)<defImpHate	:if rnd(12)=0:break
				if cImpression(tc)<defImpEnemy :if rnd(4):break
				continue
				}
			if cImpression(tc)<cImpression(i):tc=i:p++
			}
		loop

# [BUG111] マイチェアがなくても来客用の椅子の近くに椅子があると来客時にPCがそちらに移動してしまう問題
**概要
来客用の椅子があり、マイチェアがあればPCはマイチェアに、ペットは来客近くの他の椅子を探して座るような仕様になっている。

今回の修正では
来客用の椅子があればマイチェアがなくともPCとペットは近くの椅子を探して座る、となっていたのを
来客用の椅子があってマイチェアがない場合、来客は座るがPCもペットも座らないとした。

**修正方法
main.hsp 1914行目
	i=0
	repeat maxFollower+1
	if cnt=0:c=tc:else:c=cnt-1
	if cExist(c)!cAlive:continue
	if gRider!0:if c=gRider:continue
	inv_getHeader -1:p=0,6
	repeat invRange,invHead
	if iNum(cnt)=0:continue
	if iEffect(cnt)!effChair:continue
	if c=tc: if iParam1(cnt)=2:cell_swap c,-1,iX(cnt),iY(cnt):i=cnt:p=cnt:break:else:continue
	if i=0:break:else:if cnt=i:continue
	p(2)=dist(iX(cnt),iY(cnt),iX(i),iY(i)) : if p(2)<p(1):if (map(iX(cnt),iY(cnt),1)=0)or(c=0)or(c=tc):p=cnt,p(2)
	if c=0:if iParam1(cnt)=1:p=cnt:break
	loop
	if p!0:cell_swap c,-1,iX(p),iY(p)
	cDir(c)=direction(cX(c),cY(c),cX(tc),cY(tc)):if c=0:gRunDir=cDir(c)
	loop
	gosub *chat
	swbreak
↓
	i=0
	pcChair=0
	repeat maxFollower+1
	if cnt=0:c=tc:else:c=cnt-1
	if cExist(c)!cAlive:continue
	if gRider!0:if c=gRider:continue
	inv_getHeader -1:p=0,6
	repeat invRange,invHead
	if iNum(cnt)=0:continue
	if iEffect(cnt)!effChair:continue
	if c=tc: if iParam1(cnt)=2:cell_swap c,-1,iX(cnt),iY(cnt):i=cnt:p=cnt:break:else:continue	;guest
	if i=0:break:else:if cnt=i:continue
	if c=0:if iParam1(cnt)=1{	;pc
		p=cnt
		pcChair=1:break
	}else:if(pcChair){	;pets
		p(2)=dist(iX(cnt),iY(cnt),iX(i),iY(i)) 
		if p(2)<p(1):if (map(iX(cnt),iY(cnt),1)=0)or(c=0)or(c=tc):p=cnt,p(2)
	}
	loop
	if p!0:cell_swap c,-1,iX(p),iY(p)
	cDir(c)=direction(cX(c),cY(c),cX(tc),cY(tc)):if c=0:gRunDir=cDir(c)
	loop
	gosub *chat
	swbreak







# [BUG112:Fixed] レシマス低層でのモンスター生成レベルがやや高くなることがある問題
773 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/10(木) 11:13:37.54 ID:szKb1oV3 [1/2]
obvjlvって変数が見つかったんだが、記述箇所が1カ所しかないしobjlvのtypoで間違いない。
これによる影響はレシマス3層までのobjlvが5を超えることがある程度。

# [BUG113] ヴェルニースのタイル設定が誤っている問題
70 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/24 08:57:15 ID:Qa6ZmizC
~*label_1752でadataセットするときに 
ヴェルニースのところでタイプミスがあって
adata(18, p) = tstown2になってる
ヴェルニースで使用するtile_fogがちょっと変わるくらいかな？

配布ソースなら直ってるかも

71 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/24 22:49:46 ID:pbPkDdjb
逆コンソースなら
adata(18, p) = 2
が正しいってことでおｋ？

73 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/24 22:54:24 ID:CxWLbAC/
オリジナルだとtsTown?な#defineはtsTown1だけ
で、
#define tsTown1 2
で設定されてるからそれでOK
tsTown2の#defineし忘れだったとしたら猫の人に聞いてみないと分からない

# [BUG114] 冒険者が死んでアイテムを落としてもエンチャントの効果が残る問題
88 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/06/03 01:32:46 ID:sTs4VOfe
冒険者を殺して装備を奪ったときエンチャントの効果が残る問題
装備落としたときにも怪我から復帰したときにもchararefreshされていない
map_preBeginで冒険者配置してるからその辺で
r1 = rc
gosub *label_1476
しておくといいかも

# [BUG115]

addnews 4で検索して出るちょっと上
冒険者がクエスト達成して経験値得る処理なんだが
cdata(35, rc) += cdata(38, rc) * cdata(38, rc) * cdata(38, rc) * 5
これは簡単にオーバーフローするので
cdata(35, rc) += limit(cdata(38, rc), 1, 1000) * limit(cdata(38, rc), 1, 1000) * 100
にでもしておく

# [BUG116] 畑マップに入ったとき、成長判定が誤ったタイル情報で行われる問題
737 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/09(水) 00:41:15.38 ID:nRrH0tc4
~>ore_hackの人
畑の成長判定時の畑マスの判定を～って所が前から気になってて
134500ちょっと上でその条件が「マップチップの種類が４のとき」に書きかえられてるの見つけたんだけど
４だと雪マスみたいだしこれは２のままでよかったんじゃないか？
もし間違ってたらスマン。あとちょくちょくパクッててスマン

739 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/09(水) 03:46:24.33 ID:2iIfB6c5
~>>737
自分もそう思っていたのですが、畑に入った時のフンの処理がどうしてもうまく行かなくて
原因を探ったところ、畑に入った時の処理時のみ畑が４(他は全て０)になっていたんです。
その後にどのタイミングかは解りませんが２になるようです。

**概要
~*map_exitで*map_init呼ぶ

~*map_init
↓
~*map_init_main　mTileFile:mdata(2)をセット
↓
~*map_preBegin
↓
~*map_beginで*check_renew呼ぶ
　　　　　　*map_prepareTile呼ぶ
↓
~*check_renew内のrenew_minorで*item_seedGrowth呼ぶ
↓
~*map_prepareTileでmTileFileが更新されていたら(!mTileFileCurなら)
mTileFileCurをmTileFileにして*mapchip_initを呼ぶ
↓
~*mapchip_initでmTileFile=1のとき畑タイルのtRoleをtCrop:2に

つまり順番が逆なのでmdata(2)は更新されてもまだマップチップ情報が書き換わってない

# [BUG117:Fixed] 自宅のマップフィートがあるマスの上に階段を置くと移動先階層が想定外の値になる問題

map.hsp 150行目付近
"階段を降りた。"で検索して出る少し上
if mapItemFind(cX(cc),cY(cc),idDownstairs)!falseM:feat(1)=objDownstairs
↓
if mapItemFind(cX(cc),cY(cc),idDownstairs)!falseM:feat(1)=objDownstairs,0

if mapItemFind(cX(cc),cY(cc),idUpstairs)!falseM:feat(1)=objUpstairs
↓
if mapItemFind(cX(cc),cY(cc),idUpstairs)!falseM:feat(1)=objUpstairs,0

逆コンなら 130950行目付近
"階段を降りた。"で検索して出る少し上
feat(1) = 11
↓
feat(1) = 11, 0

feat(1) = 10
↓
feat(1) = 10, 0

これでおｋ

# [BUG118] 家に滞在させている仲間にも旅歩きの経験値が入ることがある問題
を発ってから　で検索して出るあたり
p++の上に
if cArea(cnt):continue　を追加

逆コンでも同様に
p++の上に
if cdata(80, cnt) {
continue
}
を追加

# [BUG119] 依頼マップでの依頼を失敗して元のマップに戻ったとき、メッセージが意図通り表示されていない問題

map.hsp 180行目付近
if mType=mTypeQuest{ }内の
rq=gQuestRef
gosub *quest_exit
この2行をコメントアウト

遡ってproc "map_exit"の数行下
msg_newLineの上に
if mType=mTypeQuest{
　rq=gQuestRef
　gosub *quest_exit
}
を追加

逆コンでは131050行目付近
rq = gdata(72)
gosub *label_2674
これらをコメントアウト

map_exitで検索して出る少し下
msg_newlineの上に
if ( mdata(6) == 7 ) {
　rq = gdata(72)
　gosub *label_2674
}
を追加

# [BUG120] ノイエルで雨が降ったり、自宅で雪が降ったりする問題
map.hsp 188行目付近
if gQuest=0:if gAreaPrev!=areaWildness:gWorldX=areaX(gArea) : gWorldY=areaY(gArea) : gosub *weather_change
↓
if gQuest=0:if (gAreaPrev!=areaWildness)or(areaType(gArea)!mTypeWorld):gWorldX=areaX(gArea) : gWorldY=areaY(gArea) : gosub *weather_change

野外から帰還を唱えるとgWorldX,gWorldYが更新されてなかった

map.hsp 205行目付近
if (mType!mTypeWorld):if (mType!mTypeLocal)or(mType=mTypeHome):if fixTransferMap=false:gWorldX=areaX(gAreaPrev) : gWorldY=areaY(gAreaPrev):else:fixTransferMap=false
↓
if (areaIcon(gAreaPrev))&(gAreaPrev!areaShowHouse):if(areaIcon(gArea)=0)or(gArea=areaShowHouse):if fixTransferMap=false:gWorldX=areaX(gAreaPrev) : gWorldY=areaY(gAreaPrev):else:fixTransferMap=false

クエストマップ・アリーナ系・ショウルームから元いたマップに戻るとgWorldX,gWorldYがクエストマップ等の座標になってしまっていた
野外以外から帰還を唱えるとgWorldX,gWorldYがgosub *weather_changeの後さらに書き換えられて帰還前のマップの座標になってしまっていた
アイコンの有無で判定するのはちょっと乱暴かもしれないがこれでどうだろうか

逆コンソースならこう
131000-131100行目付近
if ( gdata(19) != 2 ) {
↓
if ( gdata(19) != 2 & adata(0, gdata(20)) == 1 ) {

if ( mdata(6) != 1 ) {
if ( mdata(6) != 4 | mdata(6) == 5 ) {
↓
if ( adata(15, gdata(19)) != 0 & gdata(19) != 35)) {
if ( adata(15, gdata(20)) == 0 | gdata(20) == 35)) {

# [BUG121] 初期洞窟の位置に建てたユーザー物件がバージョン更新時に移動する問題
map.hsp 1820行目付近
repeat headUserArea
if (areaX(cnt)=0)or(areaY(cnt)=0)or(areaId(cnt)=0):continue
の下に
if areaIcon(cnt)=0 :continue
if areaParent(cnt)!gArea :continue
とでも追加

先に1.22でセーブデータをアップデートしちゃうとそもそも意味ないけども

# [BUG122] 地殻変動が頻繁に起き続ける問題
1.22にて、ワールドマップに出るたびに地殻変動が起きるバグ発生、サウスティリスに行ってから戻ってくると直ったけどね -- 2011-02-10 (木) 17:38:15
Ver1.22突然地殻変動の頻度が異常に多くなってなぜかランダムネフィアの数が異常に少なくなった。 -- 2010-12-07 (火) 23:25:52

92 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/07(土) 12:25:28.70 ID:VRHU9sE+
あまりよろしくないけど、マップエディタ使ってオパ像出して試してみた
既にプレイしてあるセーブ、つまり既に地殻変動が何度も起きているセーブでだが、
100回くらい使ったら、ちらほらたまに見かけはするけど、大体禿げた
150回くらい使ったらもう見かけなかった
だから、地殻変動をひたすらやったらいつかはネフィアが消えていくだろうね

ただし朗報
サウスティリスにいって戻ってくると禿げが全部元通りになる
だから開発版ならいくらでも地殻変動を起こしておそらく問題ない
テストワールドだと駄目だった

試したのは1.22だからそれ以外でも同じかはわからない
安定版だと解決策があるのかどうかもわからない

764 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/02/16(水) 22:37:05 ID:+bay/lM0
俺も気になってたんで
~>ワールドマップの円形脱毛。
これ、ちょっと調べてみた
マップ描画用のタイル変更した上でわざわざそのチップに置き換えてるから
意図的な変更だな、こりゃ
「何かがあった跡地」みたいにしたかったんじゃないか？

**概要
安定版では起こらない
チップ番号33、これがあると周りにダンジョンが作られにくいチップなのでダンジョンが減る
未クリアダンジョンの数が減ると地殻変動が必ず起こる仕様になっているので・・・

# [BUG123] マップスタート位置情報がリセットされない問題
ちょっと小耳に挟んだのですが、

レシマスの洞窟で上り階段を上がった直後、レシマスに帰還をすると、
なんと到達最下層の下り階段の目の前に帰還できるそうですよ！

冒険者 (2010-07-17 (土) 20:28:47)

裏技というか変な挙動なんで、動作を確認してバグ報告予定リストに入れてみた。 -- 2010-07-17 (土) 21:04:46
verはいくつだ -- 2010-07-17 (土) 21:41:42

すくつでもできる
map_placecharaonentranceに入力される gdata(26):初期配置種類 が階段昇ったときに 2:降り階段の位置 に上書きされている







# [BUG124] 自店でアイテムが交換されるとき、既に入っているアイテムの個数を上書きしてしまう問題
787 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/11(月) 00:54:19.99 ID:1JzBSPXT
~>>735-737
報告ありがとうございます。修正しました。多分これで大丈夫だと思います。
店の金庫のバグは公式でも起きるっぽいです。一応解決方法を下に。

ttp://www1.axfc.net/uploader/Sc/so/223518.zip&key=elona_ore_hack
・「a」キーからの罠解体時、罠を起動してしまうと中断するようにした。
　経験値も少しですが入ります。
・自店で物が交換される処理時、金庫に候補になるアイテムが既に入っていると
　場合によっては既に入っているアイテムの個数が０に上書きされてしまうバグを修正。
・何もいない所に聴診器を使うと落ちるバグを修正。

金庫バグ解決方法(逆コンパイルソース)
130274行と130275行の間に
nostack = 1
を挿入。
130280行と130281行の間に
item_stack -1, ci
を挿入。

# [BUG125] 自店で売れた焚き火のSEが残り続ける問題
Ver1.22自分の店に焚き火を置き、売れて無くなっても焚き火のSEが残りっぱなしになる。もう一度焚き火を置いて拾えばSEは消える。 -- 2010-09-17 (金) 18:50:07


# [BUG126] 雇用できる使用人が日によって完全固定されない問題
isethire(hire)のあたり

日付 + cntでrandomizeしているが例によってexrandを固定してないので店主の種類がランダムになってしまう
exrand_randomize 日付 + cntしておいて
規模を設定する前でexrand_randomize_by_timeしておく

名前が同じユニットを生成するとならchara_vanquishしているが存在状態をチェックしていないので
名前を変更せずに解雇すると再び雇えないことがある
存在状態が0じゃなければという条件を追加しておく






# [BUG127:Fixed] 高レベル階層での採取マテリアルがクズばかりになる問題
905 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/02/22(火) 15:54:53.38 ID:Xy0WFno8
&gt;&gt;900
random_material関数の中にある抽選ループに、
選ばれたマテリアルのレベル?が採取レベル(採取スポットなら現在階層レベル)未満ならループの頭へ、って記述がある。
抽選ループは最大500回繰り返されて、10回おきに採取レベルを1つ下げるんだが、
高レベル階層だと、ループを繰り返しても採取レベルが高いままになるから、
戻り値は関数の冒頭でセットされた0番(=クズ)のままになる。
おそらく不等号の向きが逆。


# [BUG190] 動物系マテリアルが手に入らない原因は、採取スポットでの採取処理ルーチンに記述抜けがあるから。

具体的には、「何かの残骸がある」と表示される採取スポットのレベルを変更(PCの解剖学レベル / 3を加算)するところで、
採取スポットの種類番号を16(動物系)にセットする記述が抜けてる。
記述を加えたら動物系マテリアルを採取できた。

919 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/02/23(水) 08:49:38.82 ID:q4VG8nEC
ttp://www1.axfc.net/uploader/Sc/so/208081.zip&key=elona_ore_hack
パス：elona_ore_hack
・高レベルのネフィアでマテリアルがクズばかりになるバグを修正。
・動物系のマテリアルが出るようにした。
・ペットの訓練費を主能力値やスキルＬＶ依存に出来るようにした。

&gt;&gt;905さんの情報を得て、マテリアル関係を修正しました。
不等号の向きを逆にしただけだと低レベルでクズばかりになってしまった為、
さらに１０回毎のＬＶ減算を加算に変更した所、解消されたように見えます。

ペットの訓練費はとりあえずスキルLv*125gpでやってみました。
デメリットもあるのでお好みで。
しかし実装してみて、ややこしい処理になっている結果を見ると
キャラLv依存になってる理由が解った気がします。


高レベルネフィア取得マテリアルバグ修正
　高レベルのネフィアなどでマテリアル採集をしても「クズ」しか採集できない
　対処
　material.hsp 14行目
　　lv--:rare--をlv++:rare++へ変更
　material.hsp 15行目
　　matLv(p)<lvをmatLv(p)>lvへ変更
　material.hsp 16行目
　　matRare(p)<rareをmatRare(p)>rareへ変更
　※マテリアルの入手バランスに影響があるので要調整？


# [BUG128] 生産スキルで作ったアイテムがスタックされない問題
137 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/16(月) 22:47:10.58 ID:CXceR+Tj
ちょいと聞きたいんだが生産スキルで作ったアイテムがスタックされないのって仕様？
宝石細工上げようと巻物を大量生産してる時に未確定（「ぼろぼろの」や「苔むした」）だとスタックするくせに名前がわかってるとスタックしないとかバグくさいんだが

154 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/17(火) 08:06:43.06 ID:GJCJUBB0
~>>137 >>145
アイテム生成直後は識別度が0で、
「？？？を製造した。」っていうメッセージを表示する時、
itemname関数を呼んでるんだけど、この関数のなかで識別度を変更する処理が行われてる。
アイテム生成処理のスタックする前に識別度を設定する処理を入れるか、
メッセージ表示後(itemnameが呼ばれた後)に「item_stack 0, ci」を追加すれば解決する。
前者は他のバグが誘発される恐れもあるし、後者が安全だと思う。






# [BUG129] PCのスポットライトが死亡後も下1/3だけ残る問題
17 名無しさん＠お腹いっぱい。 sage 2011/03/18(金) 15:24:57.79 ID:+1MGsrf8
PCのスポットライトが死亡後も下1/3だけ残る問題。

場所はcell_draw命令内。
スポットライトの描画は下側1/3と上側2/3に分けて行われるんだが、
前者に「PCが存在しているとき」という条件が付けられていない。

# [BUG130] F11のキャラダンプ機能でHspError 23が発生する問題
145 名前：異形の森の名も無き使者[sage] 投稿日：2011/05/14(土) 14:23:32 ID:Xqv0Dngg
安定版でF11のキャラダンプ機能を使用すると、下記のようなエラーが出て強制終了し、生成されません。
対処法わかる方が居ましたら教えてください。
HspError 23 WinError 0 Ver 1160 Mode 0
efId 0 efP 0 Area 15/1
ci 0#200 ti 0#200 cc 0#0 tc 0#0 rc 101#77
3. Dump:Init ct:0
2. Dump:1 ct:0
1. Dump:1-2 ct:0
0. Dump:1-3 ct:0
**修正方法
module.hsp 2294行目
 m=""+strmid(s,0,len)
↓
 m=""+strmid(m,0,len)
**参考リンク
[[HSP3のFAQ:エラーメッセージの意味と対処法が分からない>http://quasiquote.org/hspwiki/HSP3%E3%81%AEFAQ%3a%E3%82%A8%E3%83%A9%E3%83%BC%E3%83%A1%E3%83%83%E3%82%BB%E3%83%BC%E3%82%B8%E3%81%AE%E6%84%8F%E5%91%B3%E3%81%A8%E5%AF%BE%E5%87%A6%E6%B3%95%E3%81%8C%E5%88%86%E3%81%8B%E3%82%89%E3%81%AA%E3%81%84#H-zupint]]


# [BUG131] サイズが小さいマップでボール系魔法を唱えると落ちることがある問題
119 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/02/05 21:53:09 ID:n1JrLP9C
ボール系魔法のアニメ描画ルーチンが、マップの大きさをチェックしてない。
縦横どちらかの大きさが画面より小さいマップ(特に盗賊の隠れ家)では、
アニメの描画座標がマップの範囲外に出てエラーになる可能性がある。

120 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/02/10 00:49:36 ID:Ga6UgjJn
fov_los関数がマップの大きさをチェックしてなくて、範囲外の座標を与えられるとエラーになる。
~>>119のバグもこれが原因で引き起こされてる。

# [BUG132] マップフィート情報がオーバーフローする問題
cell_featset命令の第6パラメータに215以上の値(例: 地雷敷設者のユニット番号)を指定すると、
マップフィート情報の値がオーバーフローする。
chipm配列変数を参照する箇所でError 7が発生する原因。

144 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/08/15 18:46:19 ID:EElK3lDJ
overhaulの高レベルネフィアでHspError7で落ちしてしまうので
逆コンのやり方調べて原因を探ったが
公式版でもおきそうなのでここに書いてみる

cell_featsetの5番目の引数がダンジョンの階層で変動するようだが
feat@m80(2)へ代入するときにlimitで制限かけないとオーバーフローする可能性がある

# [BUG133] 乗馬されているペットが他のキャラを押しのけたと表示される問題
cell_swap命令内
最初のreturnをreturn false
最後のreturnをreturn true
としておいて

"を押しのけた。"の行の最初にif stat=true :を追加

逆コンなら
false→0
true→1
と読み替えてくれればいい

# [BUG134] 来客用の椅子やマイチェアが壁で埋まっていても来客イベントでそこに座ってしまう問題
module.hsp cell_swap命令
通行可能かをチェックしていない
リリィ売り飛ばし・ギルドの番人移動でも同様のことが起こるはず








# [BUG135] チュートリアルでの採掘補正が残り続ける問題
46 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/25 08:26:08 ID:KJTQvXIm
採掘のチュートリアルの話を聞いた後、わが家で一度も掘らずにいると
他のマップで採掘が1ターンで終わってしまうバグ修正。

proc.hsp 1065行目 (1040行目からの*dig内)
if (f=true)or(flagTutorial=2){
を
if (f=true)or&#40;(flagTutorial=2)&(gArea=areaHome)){
に変更。
あまりにも対症療法的でかっこ悪いけど、一応動作は確認した。
スマートな修正方法は腕の良い方にお任せする。

こういう感じだった。
if (普通の採掘完了) or (flagTutorial=2)
壁壊したり、音鳴らしたり、なんか色々やってる
if (flagTutorial=2)&(マップがわが家)
呪い偽金塊を生成
flagTutorial=3
else
普通のアイテム生成判定
以下略

# [BUG136] 冒険者とペットの判定が一部おかしい問題
50 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/29 12:37:03 ID:7ECFtcfk
maxFollowerって<と>=で判定だよな？所々そうじゃなかったのでとりあえず
~>maxFollowe となってるのがai,chara_func,(hsptmp),main,procにそれぞれいくつか
~<=maxFollower となってるのがproc.hspに一つだけ見つかった
どのような不具合があったかは未確認

あと所々"の閉じ忘れとかあるけど見たところ問題無いっぽい？

# [BUG137] 吟遊詩人が演奏を開始したときプレイヤーの累計おひねりアイテム数が初期化される問題
320 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 18:56:40.21 ID:Myv4aFO+ [2/4]
もしかしてperformTipsってプレイヤー以外でも初期化されてる？
精々吟遊詩人に割り込まれた時おひねりアイテムが貰いやすくなる程度だけど

321 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 19:41:56.19 ID:0hn58pRB [3/3]
"の演奏をはじめた。"のメッセージ表示時点で無差別に初期化してるね
まさしく
~>精々吟遊詩人に割り込まれた時おひねりアイテムが貰いやすくなる程度だけど
が起きる
"演奏を終えた。"等のメッセージ表示時はプレイヤー以外のチェックしてるから
バグですな

# [BUG138:Fixed] 演奏依頼で成功値が正しく計算されない問題
>177 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2012/01/23(月) 20:07:28.99 ID:aAhbOsrX
>演奏依頼のときだけやたら経験値が入るの気になってたんだけど
>
>p = rnd(聴衆レベル + 1) + 1として
>rnd(演奏スキル + 1) > rnd(聴衆レベル * 2 + 1) なら
>パーティ中の場合、聴衆がPCペット冒険者でなければ友好度 += rnd(3) してcalcpartyscoreを行う
>1/2の確率で成功値 += p
>1/4の確率で成功値 -= p
>
>ってなってるんだけどcalcpartyscore内でpがクエストポイントに上書きされるから
>演奏依頼時の成功値の変動が想定外の値になってると思うんだがバグだよねこれ

よくある変数被り
calcpartyscore内のpをptpなどの被らないものにしておく

# [BUG139] 演奏での楽器の効果が機能しないことがある問題
おひねりアイテムが生成されるとciが上書きされる
おひねり金の計算・グールドのピアノ判定・ストラディバリウス判定・成功値計算の4箇所で
ci→cItemUsing(cc)とするといいかも
*井戸で見つけた金貨の枚数が元の枚数を上書きする問題
403 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/04/01(金) 03:49:31.46 ID:tns7sz5b [2/4]
ん、バグやね

proc.hsp 1411行目
item_createの後でiNum(ci)を変更している部分をitem_createへの引数にする
( : iNum(ci)=を,に置き換えればおけ)

逆根
162688行目を削除
162688行目にあったrnd(sdata(159, cc) / 2 * 50 + 100) + 1を
162687行目末尾のパラメータ0と置き換え

でいいはず

# [BUG140] 対象がテレポート妨害装備をしていると使用者のスリの指が不発する問題
55 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/10 06:38:42 ID:zXhhPTta
対象がテレポート妨害装備してるとスリの指が不発するのってバグかな？
使用者の方を条件にすべきなんかね
逆コンパイルソースの163900行目あたり

57 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/11 02:58:30 ID:nKwftskk
if ( efid == 635 ) {
（略）
}
をまるごと
if ( efid == 619 ) {
}
の直前に持ってきて

if ( tc == cc ) {
を
if ( encfind(cc, 22) != (-1) ) {
に、

if ( efid == 619 ) {
を
if ( efid == 619 | efid == 635 ) {
にそれぞれ書き換え
これで動いてる気がする

# [BUG141:Fixed] スリの指の成功判定が誤っている問題
スリの指の判定がどうもおかしい
rnd(対象の感覚) > rnd(対象の器用 * 4)
が条件の一つになっているが
rnd(対象の感覚) > rnd(使用者の器用 * 4)
ではないだろうか？

# [BUG142] 乗馬されているペットが接近を発動すると増えていく問題
628 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/28(木) 06:57:14.70 ID:SkKmJBTh
乗馬ペットに接近持ちの投擲武器持たせて発動させるとバグるんだがどうにかならない？
動かない乗馬ペットが増える

629 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/28(木) 07:28:54.70 ID:Kh1lQqjk
空間歪曲発動もマズそうな気がする

乗馬してるペットが対象なら終了ってなってる部分を
接近ならテレポート先は対象の座標でテレポートするのは自身って書いてる部分の下に持ってくれば？
ちゃんと動くかは知らない

# [BUG143] 弱体化の手が不発する条件がおかしい問題
あと163750行目あたりの
i = sorg(10 + p, tc) - cdata(240 + p, tc)
を
i = sorg(10 + p, tc) + cdata(240 + p, tc)
に書き換え
これで弱体化の手がちゃんと動く気がする

# [BUG144:Fixed] 睡眠時に魔力・魅力の潜在が上昇しない問題
523 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/04 11:48:01.98 ID:zyKOmCEX
調べてみたらVersion 1.16fix1から魔力・魅力が対象外になってんね
理由はわかんね
"まあまあの目覚めだ。"で検索して20行ほど下のmodgrowthの引数のrnd(6)を
rnd(8)にすればVersion 1.16開発版以前と同じ仕様になる
*睡眠経験値がオーバーフローする問題
152 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/17(火) 06:40:47.44 ID:RUgFtL0h
睡眠時の成長率計算もバグってるね・・・wiki見てて気付いたわ
後半は1%成長が当然だとばかり

睡眠経験値*寝具補正/100　

この部分で/100より前にオーバーフローしちゃってるから、
↓みたいに変更すれば問題無い

睡眠経験値100万以上の場合　睡眠経験値/100*寝具補正
そうでない場合　睡眠経験値*寝具補正/100

あとは睡眠経験値自体をMax10億に制限すれば完璧だが、これはちょっと面倒

153 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/17(火) 07:01:48.06 ID:7WmqKcOq
睡眠経験値入るの2箇所だしそこでlimitじゃだめかな？

# [BUG145] 店番のいない店で寝ると地面のアイテムがすべて非表示になる問題
101 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/08/04 23:48:11 ID:pQtyOggO
店番のいない店で寝ると地面のアイテムがすべて非表示になる。

これは睡眠処理ルーチンの末尾で、
「現在地のマップオブジェクト識別番号が102:店なら、店のマップ描画情報をリフレッシュ」
するようにしたら直った。

if ( adata(16, gdata(20)) == 102 ) {
gosub *label_1726
}


# [BUG146] グローバルマップで空腹時に毎ターン持ち物から旅糧を探す処理が入る問題
64 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/16 10:31:52 ID:Uq9LvXAN
グローバルマップで空腹だと1歩ごとに持ち物から旅糧探すのなんとかならんかな
新たな変数に旅糧持ちフラグセットしてグローバルマップに入ったときリセットとかでいけそう？

65 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/16 22:22:56 ID:3vMN1Sr5
毎ターン判定してるのを1マスごとにするだけでも気にならなくなったよ

66 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/18 05:17:53 ID:aphD6IuY
ああなるほど毎ターン呼び出されてるのかこれ
荒天のときの処理も弄った方がいいんだろうけど自信ないからちゃんとした人に任せる

# [BUG147] ガロクの槌を使用キャンセルしたときメッセージがおかしい問題
67 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/19 22:26:05 ID:4iY30nFb
ガロクの槌でキャンセルすると槌が消費されずに
"そのアイテムに改良の余地はない。"って表示されるのバグじゃないかな？

逆コンソース166626行目
f = stat　の下に
equip = inv(18, ci)
if ( f == 1 ) { 　を入れて

166638行目の
equip = inv(18, ci)をコメントアウト

166738-166745行目
else {
（略）
}
をコピーして

166656行目
tcol@txtfunc = 255, 255, 255　の下にペースト

これで素材槌なんかと似たような感じにはなる、ただしキャンセルでも消費される
のあ猫はどうしたかったんだろうか

68 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/20 00:17:30 ID:iK3cod6Z
逆コンソース166626行目
f = stat　の上に
if ( stat == 0 ) {
　goto *label_2186
}
を入れるとキャンセル時は「何も表示せず、消費もされない」になる
逆コンベースだとメッセージ表示とか面倒なんでこれでいい気もする


# [BUG148:Fixed] ガロクの槌で生成した奇跡品に素材品質補正が適用されない問題
品質を奇跡にする前に素材品質補正(*label_0265)しているので
槌使用前の品質で各種補正が計算されてしまう
順番を入れ替えておく


# [BUG149:Fixed] 収穫依頼の作物を収穫中にペットがお金を拾うと個数が上書きされる問題
76 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/26 06:44:03 ID:e4D9YpXI
逆コンソース161124行目
gosub *label_2192の上に
in = inv(0, ci)を挿入で治ってる気がする

収穫行動中にペットがお金拾うとinが上書きされちゃうのが問題かな

# [BUG150] 召喚時に無限ループに陥ることがある問題
80 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/30 23:34:27 ID:C1F0Ua96
召喚系スキルのルーチンで、キャラクタ生成後、
「妹召喚以外は、スキル発動者と同じキャラが生成されたら、そのキャラをvanquishして、カウンタを増やさずループ続行」
という記述があるんだが、これはキャラクタ生成に失敗した時に無限ループになる可能性がある。
上記の処理を「キャラクタ生成に成功したとき」だけ実行するようにすれば回避出来るはず。

# [BUG151] ペットが設置した地雷が敵に当たらない問題
156 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/05/18(水) 07:01:47.16 ID:xRy6NrcG
地雷の設置者がPCじゃなく、踏んだのがPCでもペットでなければ無効
みたいな処理があるんだがこれペットが設置した地雷が敵に当たらない気がする
何か見過ごしてるかもしれん

# [BUG152:Fixed] バックパックが満杯で窃盗に成功しなかった場合調達依頼品フラグが消える問題
窃盗の際にバックパックの空きを確認する前に　ibitmod 12, ci, 0　しているためバックパックがいっぱいで失敗した際に
対象のアイテムが相手の手元に残ったままにもかかわらず調達依頼品フラグがオフになってしまう
ibitmod 12, ci, 0　をバックパックの空きを確認する処理の後に移動させれば問題ない

# [BUG153] NPCが渡されたアイテムを無限に使用し続けることがある問題
129 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/04/01 22:46:42 ID:q2af02np
・無限使用バグ
>662 名前：以下、名無しにかわりましてVIPがお送りします[sage] 投稿日：2012/03/27(火) 20:42:35.33 ID:jaa0ZzTm0
>速度が合えばNPCにお酒なりなんなり上げて(必要なら毒薬など受け取ってくれないものを選択してテンポずらす)飲まれる前に窃盗すると、
>NPCが～を飲んだってでたあとに～を盗んだってでる。
>こうするともういっかい窃盗画面開くなりして相手のアイテム欄をのぞくまで
>盗んだ～をひたすら飲み続けるみたい。

巻物でも可
個数がマイナスになっても使用し続けるので非常にまずい

とりあえず
~*ai_itemのところで
if iNum(ci)=0
↓
if iNum(ci)<=0
としておく

こうしておいても盗むと同時に1つはカラ使用されてしまいリサイクルできてしまうので
盗むのあたりでcAiItem:cdata(12,)は盗めないようにしておくといいかも
ちょっと根本的な理由がよく分からないので要調査

>>129の無限使用バグについて
if cActionPeriod(cc)>0{ }内では個数チェックが入っているが
盗む最終ターンに個数チェックがされていないのが問題のようだ
if cActionPeriod(cc)>0{ }の下のif gRowAct=rowActSteal{ }内で個数<=0チェックしておく

# [BUG154] 事前に対象を指定するタイプの魔法を混乱時に使ったとき対象が使用者自身になってしまう問題
混乱しながらも～のあたり
PCは混乱していても正常に対象に当たるし、ボルトやボールなんかではPC以外でも効果が正常に発動するのでバグではないか
gosub *label_1513（読書なんかと同じラベル）の前後で
tcbk = tc と tc = tcbk を書き加えてみた


# [BUG155:Fixed] 錬金術で誤字がある問題
錬金術のあたり
obvisou→obvious

# [BUG156] 連続魔法の2発目以降のスペルパワーが半減していく問題
141 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/08/01 13:53:58 ID:Lj+mRFVw
連続魔法が思ったより強くない原因。

連続魔法(rapidmagic)はefp, dice1, dice2, bonusの値がそれぞれ元の半分 + 1で計算されるけど、
1ループごとにefpの復元をしていないせいで、連射数に応じてefpが半減していく。
例えばefpが100の場合、3連射なら51→26→14で計91になる。

142 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/08/01 17:53:05 ID:n8CDDnET
本当だ、よく見てるな

でもこれ以降矢系魔法でefp使わないんだよね
直前のcalcskill命令でefpからele,elep,dice1,dice2,bonus計算してるから
ここはefpじゃなくelep（属性強度）を半分にしたかったんじゃないかと推測するんだがどうだろうか


# [BUG157] マニの分解術のメッセージがおかしい問題
**修正方法
proc.hsp 1830行目
	case skHand
	if cCastStyle(cc)!0{
		if sync(cc):if cc=pc:txt lang(name(cc)+"は"+skillName(efId)+"の"+_cast(cCastStyle(cc)),name(cc)+" cast "+skillName(efId)+"."):txtMore:else:txt lang(name(cc)+"は"+_cast(cCastStyle(cc)),name(cc)+""+_cast(cCastStyle(cc))):txtMore
		}else{
		if efId=actDrainBlood{
			if sync(cc):（省略）
 
			}else{
			if sync(cc):（省略）
			}
		}
 
	if efId=actDisassemble{
		txt lang("「余分な機能は削除してしまえ」",cnvTalk("Delete."))
		cHP(tc)=cMHP(tc)/12+1
		swbreak
		}
↓
	case skHand
	if cCastStyle(cc)!0{
		if sync(cc):if cc=pc:txt lang(name(cc)+"は"+skillName(efId)+"の"+_cast(cCastStyle(cc)),name(cc)+" cast "+skillName(efId)+"."):txtMore:else:txt lang(name(cc)+"は"+_cast(cCastStyle(cc)),name(cc)+""+_cast(cCastStyle(cc))):txtMore
	}else{
		if efId=actDrainBlood{
			if sync(cc):（省略）
		}else:if efId=actDisassemble{
			if sync(cc):txt lang("「余分な機能は削除してしまえ」",cnvTalk("Delete."))   ;　←こちらに移動
		}else{
			if sync(cc):（省略）
		}
	}
 
	if efId=actDisassemble{
 ;		txt lang("「余分な機能は削除してしまえ」",cnvTalk("Delete."))　←コメントアウト
		cHP(tc)=cMHP(tc)/12+1
		swbreak
	}

# [BUG158] 朦朧の眼差しでメッセージが表示されない問題
**修正方法
proc.hsp 3381行目
	if efId=actGazeDim{
		if sync(tc):txt lang(name(cc)+"は"+name(tc)+"を睨み付けた。",name(cc)+" gaze"+_s(cc)+" "+name(tc)+".")
	}
を挿入

# [BUG159] 壁を掘って鉱石を見つけたとき、ペットがすぐに拾うとスタックされない問題
**概要
itemName関数が呼ばれないので鑑定度が変化しない
**修正方法
proc.hsp 1091-1092行目
				item_checkKnown ci	
を挿入









# [BUG160] カジノの描画が重なり続ける問題
2 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/03/11 16:40:04 ID:xtyfRa5W
302 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2010/05/22(土) 21:49:59 ID:oOaICTAR [2/2]
あ、>301はVer1.22ね

んで…
Ver1.19
105410:　if ( var_499 == 9 ) {
105411:　　gosub *label_1410
105412:　}
Ver1.22
115279:　if ( var_500 == 9 ) {
xxxxxx://　あれ？gosubは？
115280:　}
そしてgosub先
Ver1.19
105318:　return
105319:*label_1410
105320:　gmode 0
105321:　pos 0, 0
Ver1.22
115189:　return
xxxxxx://　………ラベル自体無ぇ…orz
115190:　gmode 0
115191:　pos 0, 0

上記を修正すればカジノの描画は直る…んだが、なんでこんなんなるんだ？
報告しようにもどう表現して報告すればいいのかさっぱり分からん

**修正方法
screen.hsp 116行目
 *screen_draw
	screenDrawHack=1
	gmode 2
	redraw 0
	if mode=mode_txtAdv{
	;	gosub *screen_txtAdv ;←ここのコメントアウトを復帰する
		}else{
		sxFix=0:syFix=0:gosub *screen_setPos
		gosub *LoS:gosub *los_draw
		}

# [BUG161] 光源の届く距離が南北と東西で1マス違う問題
555 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/05(土) 20:19:45.40 ID:OR64Hwmg
光源の届く距離が南北と東西で1マス違うのを何とかしようとしてるんだが、
その過程で、cdata(28,ユニット番号)がキャラクタの視界(直径)なのを突き止めた。
これを例えば7にすると、光源の範囲内でも距離4マス以上の座標は視界範囲外になって、
画面上では見えていても、ターゲットを指定しようとすると「その場所は見えない」と拒否される。
逆に15より増やすと、光源の外をターゲットに指定することも可能。
但しターゲットがキャラクタだと効果はなくて、地面はOKになる。

あと、盗賊団のencounterlvが0(名声値1000未満)だと、頭領の経験レベルがデフォルト(12)になる。
頭領を生成する前にencounterlvを1以上にしないといけない。

803 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/10(木) 22:38:44.22 ID:szKb1oV3 [2/2]
光源の範囲がおかしい問題(>>555)の修正が完了した。

まずは158830行目付近のfovmap作成ルーチン。
公式1.22ではy = 15回とx = 15 + 4回の入れ子ループで、
dist(x * 10 / 12, y, 15 / 2, 15 / 2) < 15 / 2の座標にフラグを立ててfovmapを作ってるが、
これを
y = 17回, x = 17回で、
dist(x, y, 17 / 2, 17 / 2) <= 15 / 2の座標にフラグを立てるように変更。

上記修正に合わせて、x方向のフラグが変わる座標をスキャンするループも17 * 17回に。
明るくなり始めるx座標がfovlist(0, y)に、暗くなり始めるx座標がfovlist(1, y)にセットされる。

必要な要素数はfovlistが2, 17、fovmapが17, 17。

次は117450行目付近にある光源の中心を修正。
sy(2) = cdata(2, 0) - 15 / 2, cdata(2, 0) + 15 / 2, 15 / 2 - cdata(2, 0)
sx(3) = cdata(1, 0) - 15 / 2 - 2
↓
sy(2) = cdata(2, 0) - 17 / 2, cdata(2, 0) + 17 / 2, 17 / 2 - cdata(2, 0)
sx(3) = cdata(1, 0) - 17 / 2

最後はwindowhが768を超えられるように修正。これをやらないと光源の範囲が画面に収まらない。


光源範囲修正
　光源の届く距離が南北と東西で1マス違う
　対処
　init.hsp 67行目
　　maxFovに設定する値を15から17へ変更
　screen.hsp 1003行目
　　sx(3)=cX(pc)-maxFov/2-2をsx(3)=cX(pc)-maxFov/2へ変更
　system.hsp 1621行目
　　repeat maxFov+4をrepeat maxFovへ変更
　system.hsp 1623行目
　　dist(x*10/12,y,maxFov/2,maxFov/2)<maxFov/2を
　　dist(x,y,maxFov/2,maxFov/2)<((maxFov-2)/2)へ変更
　system.hsp 1630行目
　　repeat maxFov+4をrepeat maxFovへ変更
　ついでにウィンドウ高さの768制限を解除(変更)
　screen.hsp 17行目
　　２つの768を適当な任意の値へ変更
*遠隔弾が縦方向にずれる問題
screen.hsp 666行目
 aX=(cX(cc)-scX)*tileS : aY=(cY(cc)-scY)*tileS-12

1.22逆コンパイルソース 116400行付近
 ay = (cdata(2, cc) - scy) * inf_tiles - 12
↓
 ay = (cdata(2, cc) - scy) * inf_tiles + inf_screeny + 8

# [BUG162] ミニマップを明るくする範囲が広すぎる問題
ミニマップの画像を明るくする処理の範囲指定で
gfini raderw * mdata(0), raderh * mdata(1)　というのがあるが、
これだとマップが大きい場合範囲が広がりすぎて他の画像にまでかかってしまい一部の表示がおかしくなる
gfini 130, 90　くらいの定数にしても特に問題はないはず

*PCが狂乱になったとき落ちる問題
screen.hsp 302行目あたり
_conAngryhHeavy(2)→_conAngry(1)
逆コンも同様でおｋ(115600行目付近)

# [BUG163:Fixed] 壁破壊アニメが表示されない問題
147 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：13/06/01 22:44:08 ID:44yNj6en
壁破壊アニメが表示されない問題:
「壁を掘り終えた」と表示する直前で、
アニメ再生ルーチンに渡すマップ座標値として、変数refxとrefyの値をそれぞれxとyに代入しているが、
画面上の再生位置を求める式では、sxとsyが参照されてしまってる。

壁掘りを完了する辺りの、
x = refx : y = refy
を
anix = refx : aniy = refy
に、
アニメ番号14の表示を処理する辺りの、
ax = (sx - scx) * inf_tiles + inf_screenx : ay = (sy - scy) * inf_tiles + inf_screeny
を
ax = (anix - scx) * inf_tiles + inf_screenx : ay = (aniy - scy) * inf_tiles + inf_screeny
にすればOK。
要はマップ座標値がアニメ再生ルーチンで正しく参照されればいいので、変数名はanix/aniy以外でも構わない。

# [BUG164] オートターン中のバフアイコンがちらつく問題
118 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/02/05 03:29:18 ID:n1JrLP9C
オートターン中の半透明部分(右下の祝福/呪いアイコン)のちらつき。
原因はHUDの二重描画。

"AUTO TURN"の文字とアニメーションを表示するサブルーチンの序盤で、
セル描画ルーチンへのgosubは条件
( msgtemp != "" | (cdata(140, 0) == 7 & rowactre == 0 & fishanime == 0) )
を満たした時だけ実行されるが、HUD描画ルーチンへのgosubは無条件で実行されてる。

HUD描画ルーチンへのgosubも条件を満たした時だけ実行されるようにすればちらつきは消える。

screen.hsp 379行目

# [BUG165] 主能力が4桁に達していると画面下部の表示がおかしくなる問題
904 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/03/14(月) 11:20:59.64 ID:oymalPF3
画面最下部、4桁に達している主能力の1の位にゴミが出る問題の修正
115370行目付近
gcopy 3, 0, 440, 24, 16
↓
gcopy 3, 0, 440, 28, 16

ついでに、そのすぐ上にあるsxの初期値を-2すると見た目のバランスが取れるはず。


画面下部のステータス表示部にゴミが残る問題修正
　画面最下部、4桁に達している主能力の1の位にゴミが出る
　対処
　screen.hsp 176行目
　　sx=inf_raderW+cnt*47+168をsx=inf_raderW+cnt*47+168-2に変更
　screen.hsp 179行目
　　gcopy selInf,0,440,24,16をgcopy selInf,0,440,28,16に変更

# [BUG166] 状態異常表示テキストがリフレッシュされない問題
559 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/05(火) 15:06:57.08 ID:9lnwzDDI
~>>558
無改造の1.22でも、重荷(というか状態表示)が、狭いマップで画面サイズを大きくしてる等でマップ外の部分に出てる時に、変化した表示が消えずに残る場合がある。

普通は
要睡眠
重荷
↓
重荷
(要睡眠が消えて重荷の表示が一つ上へ)

となるが
要睡眠
重荷
↓
重荷(要睡眠が消えたので上へ)
重荷(表示が残ってしまっている)

こんな感じ。マップ外は表示リフレッシュしてないとかそういうのじゃないかと思ってるが……。

560 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/05(火) 15:23:36.08 ID:W0Jhy4nx
~>>559
なるほど　1.22だと確認されてた現象だったのか
1.16→改造版と移行してたから分からなかったのね
ヴェルニースの盗賊アジトで良く見られたから、やっぱりそれっぽいなぁ　すまぬすまぬ



# [BUG168] 口調設定bitを消去する対象が間違っている問題
.ショウルーム内に配置されるキャラの特定のbitを消す処理内で
配置キャラではなく現在対象となっているキャラの口調設定bitが消えてしまう。
これにより、そのキャラが口調ファイルを読み込んでくれなくなる。
口調設定したペットをターゲティングした直後、
ハウスドームからショウルームに入ると簡単に再現できる。

**修正方法
譲渡ソースコードのsystem.hsp 1023行目
cBitMod cMsgFile,tc,false
↓
cBitMod cMsgFile,rc,false


# [BUG169] CNPCのテキストが正しく読み込まれない問題
79 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/30 22:20:32 ID:C1F0Ua96
CNPCの%txtDialog,ENが反映されない問題。

.npcファイルに埋め込まれたCNPCの定義テキストからカスタム口調をバッファに読み込む時に、
末尾の"%endTxt"が抜け落ちてしまう。
これが原因で、customtalkで%txtDialog,ENの内容を切り出す際、次の"%"を検出できず切り出せない。
%txtDialog,ENに限らず、%endTxtの直前に書かれた%txtであれば影響を受ける。


逆根156973行目付近
txtbuff = strmid(txtbuff, p, instr(txtbuff, 0, "%endTxt") - p)
↓
txtbuff = strmid(txtbuff, p, instr(txtbuff, 0, "%endTxt") - p + 7)

# [BUG170] CNPCにすくつ補正が付かない問題
~*set_userNpcにて
if initLv!0～の行の下に
if voidLv!0 : cLevel(rc)=voidLv*(100+cLevel(rc)*2)/100　を追加

逆コンなら*label_2104
cdata(13, rc) = -1の行の上に
if ( voidlv != 0 ) {
　cdata(38, rc) = voidlv * (100 + cdata(38, rc) * 2) / 100
}

データベース内のところからまるっとコピー
敢えてこの処理抜いてるのには何か問題があったのかもしれないが
試した感じ大丈夫な気がするので様子見

# [BUG171] 遺伝子引き継ぎ時の所持金やプラチナ等のボーナスが固定になっている問題
**概要
遺伝子データを読み込んでいるとき、
後の処理で所持金・スキルを参照するため一時スロット(nc:56)に退避しているが
参照する前に誤って消してしまっていた

**修正方法
system.hsp 251-252行目
	if cnt=nc:continue
を挿入

system.hsp 212行目
	del_chara nc
を挿入

# [BUG172] 引っ越しの際に使用人が消滅する問題
家を建て替えるときの処理でfmode = 17でファイルの読み込みをする部分の
exist file + "cdata_" + mid + ".s2"　のfileは恐らくfolderの間違い
ここをfolderに直すと引っ越しの際に滞在者も一緒に引っ越されるけど、
小城の場合、旧滞在者 + 小城に最初からいる滞在者で引っ越すたびに増え続けるので注意

	


# [BUG174] *map_init_mainで指定された音楽が再生されない問題
~>>129の内容は差し戻しておいてくれると助かるます

if cfg_music=false : returnの下に
if music=0 : if mMusic!0 : music=mMusicを書き加え
if music=0{ }内のif mMusic!0 :music=mMusicはコメントアウト
これで基本的には問題がないように思える

個人的には
if (music=0)or(areaType(gArea)=mTypeWorld)の後者の条件の方を切り取ってif music=0{ }内にぶち込んだり
if music=0{ }内にif gArea=areaVernis : music=mcTown1　
と書いておいてヴェルニースのBGMがディスクで書き換わったままにならないようにしたが好みの範疇だと思う

またmMusic:mdata(13)の設定が優先されるようになるので
map_init_mainの方でmMusicの設定をしておくとよい

~>>49のようにゼーム打倒後のBGMを変えたいなら
レシマス最深層で検索して出てくるあたりで
mMusic=mcLastBoss
↓
if npcMemory(0,2)=0:mMusic=mcLastBoss:else:mMusic=mcChaos
のように変更するといいかも

三魔石の試練のボスはすくつで先に倒すことができるので
もし打倒後BGM変えたいならnpcMemoryじゃなくイベントフラグを判定に使った方がいいかも
クルイツゥア倒してもコルゴンが生きてるとBGM変えるのは不自然だし竜窟も別の方法が必要だが
レシマス最深層と違って固定マップなので死亡状態残しておいて判定に使う等いくつか方法はあると思う

またディスク使用時に"再生した。"となっているが"を再生した。"と助詞を入れておくと良い

sound.hsp

# [BUG175:Fixed] Some races has wrong body parts

### Cause

The database of races is wrong.

```
// Correct
body_parts = "頭|首|体|背|手|手|指|指|腕|腰|足|"
// Wrong
body_parts = "首|体|手|手|指|指指|" // Missing
body_parts = "首|手|手|指|指|腕||" // Duplicate
body_parts = "頭|体|背|手|手|腰|足|足" // Missing
```


# [BUG176:Fixed] カジノで連勝するほどエーテル抗体の取得率が下がる問題
カジノ景品おまけのエーテル抗体の取得率修正
　カジノ景品のおまけで貰えるエーテル抗体の取得率が連勝数が４の時が最大で以降
　連勝するごとに下がっていく
　対処
　Noa氏への問い合わせの結果、「連勝すればするほど取得率が上がるように」が意図との
　ことだったので
　txtadv.hsp 737行目
　　if rnd(200)>(winRow*5+5)をif rnd(200)<(winRow*5+5)へ変更
　※エーテル抗体の取得難度が上がると思われるため要調整？

# [BUG177:Fixed] リングコマンドの表示位置がおかしい問題
ついでに逆コンソースで申し訳ないがzでのコマンド位置修正
240200行辺り(*label_2699) ty = 345 → ty = windowh - 255

**修正方法
help.hsp 85行目
 tx=50:ty=345
↓
 tx=50:ty=windowH-255

# [BUG178:Fixed] If your piety is maximum, you cannot receive a gift

First, grow your Faith skill to 15. Second, offer favors to your god until this message is shown: "Your God becomes indifferent to your gift". Since your "Faith" skill is 15, you hear the special message from your god like "N-No! Cut it! I-I don't love you. Stupid!". However, you are not ready to receive a gift.



# [BUG179] 捧げ物のエフェクトがPC以外に表示される問題
**修正方法
god.hsp 376行目
	call anime,(animeId=aniOffer)
↓
	call anime,(animeId=aniOffer,tc=pc)

# [BUG180] 護衛依頼の報酬が正しく計算されていない問題
**修正方法
quest.hsp 168行目
		p=qMap(qParam1(rq))
↓
		p=qParam1(rq)

# [BUG181] Literacy skill increases by a mutation even if you do not have the skill

The mutation "Your brain is mechanized." incrase your Literacy skill regardless of whether you have Literacy skill or not.

# [BUG182] 護衛依頼失敗時に護衛対象がマップ上に残り続けることがある問題
**概要
詳細な再現手順と現象については http://www.nicovideo.jp/watch/sm32556762 の 7:00頃を参照
動画はoomExであるが、v1.22でも発生することを確認済み
鼓舞などによって護衛依頼失敗時の大ダメージ(999,999)を耐えさせることで護衛対象者が生き残った場合、
扱いとしては対象者が死んだことになり依頼も失敗するが、画面上には残り続け、さらに話しかけるといった動作も行うことができる。
これ以外の簡単な再現方法として、ソースコードを書き換えてdmghp関数に渡すダメージ量を減らす、護衛対象のHPを999,999よりも大きくする、dmghpを呼び出さないようにする、といった方法がある。
**原因
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
**修正方法
この問題はmap(X, Y, 1)を参照する箇所において参照先のキャラクタのcdata(0, X)がゼロでないかどうかを確認するという方法でも修正可能だが、
(*)の箇所で同時にmap(X, Y, 1)もゼロクリアしておく方が無難と考えられる。すなわち、
 cdata(0, tc) = 0
 cell_removechara cdata(1, tc), cdata(2, tc) ; 追加
**関連する潜在的なバグ
この問題はキャラクタを強制的に殺す方法としてcdata(0, X) = 0を用いていることである。これだけではマップ上から消し去れないため、
関数を新たに定義して、cdata(0, X)のクリアとmap(X, Y, 1)のクリアを両方行わせるべきである。
なお、chara_vanquishがほぼ同様の動作をするがそれで良いかは未確認。
この件のように「必ず死ぬと思われる処理」の後に「cdata(0, X)のクリア」を行なっている箇所は他にリリーを
殺す処理がある。リリーを何らかの方法でダメージ(9,999)に耐えさせると同様の現象が発生することを確認している。






vim: ft=markdown
