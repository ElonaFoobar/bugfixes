# chara_func.hsp


## オパートス信仰のダメージ軽減が機能していない問題
368 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2010/09/20(月) 17:04:09 ID:OBB40phw [1/2]
`#deffunc dmghp`を見てて気が付いたんだけど
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
    if trait(traitGodEarth)!0 :damage--
    if cGod(pc)=godEarth    :damage=damage*90/100
  }
こうするとオパートスの甲殻の説明通り物理ダメージだけ軽減するようになる
お好みで

## 魔法属性攻撃が2重に軽減されている問題
968 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/14(木) 02:23:34.50 ID:K3QUA9zw
dmghp見てたけど
属性耐性による軽減処理で無属性魔法のダメージが二重に軽減されてる
解析ページの言葉を借りるなら魔法属性魔法攻撃になってる
どっちか削った方が良い気がする


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
    }else:if r<resistImmune {
      dmg=dmg*100/(r*50+50)
    }else{  ;r>=resistImmune
      dmg=0 
    }
    if ele!=rsResMagic {
      dmg=dmg*100/(sResMagic(tc)/2+50)
    }
  }

## 対象が濡れているとき、火属性に対し属性無効ビットが機能しない問題

ダメージ対象が濡れている場合、火炎ダメージを/3したあと無属性ダメージに変更しているため、
死亡メッセージが無属性のものになったり、
ベルなどの属性無効(cResEle)ビット持ちにダメージが通ってしまう


chara_func.hsp 1458行目
  if cWet(tc)>0{
    if (ele=rsResFire)or(dmgSource=dmgFromFire):dmg=dmg/3:ele=0
    if ele=rsResLightning :dmg=dmg*3/2
    }
↓
  if cWet(tc)>0{
    if (ele=rsResFire)or(dmgSource=dmgFromFire):dmg=dmg/3 ;:ele=0 ←コメントアウト
    if ele=rsResLightning :dmg=dmg*3/2
    }

chara_func.hsp 1460行目
    if (ele=rsResFire)or(dmgSource=dmgFromFire): item_fire tc,-1
↓
    if (ele=rsResFire)or(dmgSource=dmgFromFire) :if cWet(tc)=0 :item_fire tc,-1


## PC死亡時に画面から消滅するタイミングがおかしい問題
978 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/17(木) 01:56:28.65 ID:04wseWc/ [2/2]
PC死亡時に画面から消滅するタイミングをNPCと同じにする方法。

animeblood→存在状態を変更の順で処理しているのを、
存在状態を変更→PCの時だけcell_draw→animebloodの順に変えるだけ。

## ぺットが視界の外で出現した敵に向かっていく問題
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


## PC以外が敵を倒したときも信仰している神のセリフが表示されることがある問題
dmgHpの末尾で
if cc=pc :
↓
if dmgSource=pc :

逆コンなら
if ( cc@m141 == 0 ) {
↓
if ( prm_855 == 0) {


## 反撃ダメージが原因で死んだとき、死亡メッセージの表示がおかしい問題
143 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/08/13 01:31:25 ID:otxWzItQ
dmghp命令内で、変数ccを参照している箇所があるが、ここは引数3を参照すべきではないだろうか。
cc参照のままだと、棘ダメージが原因でPCが死んだ時に、「PCに殺された」とbone.txtに記載されてしまう。

## ネフィアボス勝利イベントが多重に起こる問題
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

## マップ内のキャラクター数が正しく計算されない問題
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

## 援軍でダンジョンクリーナーが仲間になる問題
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

## 騎乗時の速度計算の際、騎乗側と被騎乗側双方において過剰部位による速度修正が参照されていない問題
refreshSpeed命令

## 変化したキャラクターの元の関係・初期位置が保存されない問題

変化したとき、現在の関係は引き継ぐが元の関係は引き継がない
また、初期位置も引き継がない

chara_func.hsp 349行目
  if mode=1:x=cx(tc):y=cy(tc)
  p1=cRelation(tc):p2=cAiAggro(tc):p3=cExist(tc):hp=cHP(tc)
↓
  if mode=1{  ;変化
    x=cx(tc):y=cy(tc)
    xorg=cXorg(tc):yorg=cYorg(tc)
    p1=cRelation(tc)
    p2=cAiAggro(tc)
    p3=cOrgRelation(tc)
    p4=cTarget(tc)
    hp=cHP(tc)
  ; p3=cExist(tc) ←コメントアウト
  }
chara_func.hsp 387行目
  if mode=1{
    cExist(tc)=cAlive:cx(tc)=x:cy(tc)=y:cRelation(tc)=p1:cAiAggro(tc)=p2:cHP(tc)=hp:cExist(tc)=p3
    map@(cX(tc),cY(tc),1)=tc+1
    }else{
↓
  if mode=1{    ;変化
    cExist(tc)=cAlive
    cx(tc)=x:cy(tc)=y
    cXorg(tc)=xorg:cYorg(tc)=yorg
    cRelation(tc)=p1
    cAiAggro(tc)=p2
    cOrgRelation(tc)=p3
    cTarget(tc)=p4
    cHP(tc)=hp
  ; cExist(tc)=p3 ←コメントアウト
    map@(cX(tc),cY(tc),1)=tc+1
  }else{
if mode=1{ }に入れたほうが良さそうな部分は入れ、
cExist(,)を保存している部分はコメントアウトした

## 既に盲目の場合、盲目ターン数が加算されない問題
943 : 名無しさん＠お腹いっぱい。 : 2011/04/13(水) 05:06:18.23 ID:CgKKoLoA
逆コンパイルソース111587行目
cbind@con(prm_818) += p@con / 3 + 1
これ他で出てこない関数だけど
cdata(253, prm_818) += p@con / 3 + 1
の間違いかな？
既に盲目の場合盲目ターンが増えてない気がする

944 : 名無しさん＠お腹いっぱい。 : 2011/04/13(水) 05:22:51.98 ID:et2PZpfz
正規ソース見ないと分からんけどcblindの誤字かね


## 体重が身長によって決まる上限に達していると痩せられない問題
体重が上限に達してると痩せられない問題は、modweight命令(対象キャラ、変動量、フラグ)中の条件分岐、
「フラグが0なら～」の箇所に「かつ、変動量が0を超えているとき」を加えることで修正される。
これが欠けているために、変動量が負の値でも「対象の体重が上限を超えているなら処理終了」になってしまう。

ダイエットバグ修正
　体重が上限に達してると痩せられない
　対処
　chara_func.hsp 1866行目
　　if mode=0をif &#40;(mode=0)&(a>0))に変更

## 維持の付いている生もの装備を食べると、メッセージの後にあなたと表示される問題

chara_func.hsp 576行目
  if sync(tc):txtMore:txt lang(name(tc)+buffTxt@(0,buff),name(tc)+" "+buffTxt@(0,buff)+_s(tc)+buffTxt@(1,buff))
↓
  if buffType(buff)!buffFood:if sync(tc):txtMore:txt lang(name(tc)+buffTxt@(0,buff),name(tc)+" "+buffTxt@(0,buff)+_s(tc)+buffTxt@(1,buff))

## relationBetween関数の記述に誤りがある問題

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

