# command.hsp


## [x] 乗馬時の武器重量判定が誤って表示される問題

~*show_weaponStatラベル(*label_2049)
"装備中の"+itemName(cw)+"は乗馬中に扱うには重過ぎる。"を含むif文がすぐ上のrepeat-loop文より外にあるため、
素手の場合repeat-loop文の中でcwが書き換わらず、誤ったアイテムで重量判定が行われてメッセージが出ることがある
例えば起動直後に乗馬しながら適当な武器を外して素手にした場合0番のアイテムを参照して重量判定が行われる
特に実害のないバグなので放っておいても問題はないが、repeat-loop文の中に入れてしまってもいいかもしれない

ピアニストで開始→ヴェルニースで適当なペットを仲間にする→装備を全て外し、アイテムを全て置く
→グランドピアノ、武器の順に拾う→武器を装備→乗馬→elonaを終了
→elona起動→武器を外す→装備中のグランドピアノは乗馬中に扱うには重過ぎる。とメッセージが表示される


command.hsp 3205行目
  if cc=pc:if gRider!0{
    if iWeight(cw)>=def2HandWeight : txt lang("装備中の"+itemName(cw)+"は乗馬中に扱うには重過ぎる。",itemName(cw)+" is too heavy to use when riding.")
    }
  return
1.22逆コンパイル　152500行目付近

## [x] lキー(周囲を見る)でのターゲット選択キー表示がずれる問題
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

## [x] 願ったアイテムの生成数が想定外の値になっている問題
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

追記:
影響範囲
  1 -> 2-3 エーテル抗体
  1 -> 2   *素材変化*
  2 -> 1   宝の地図


## [x] F11キーによるキャラクター情報がうまく出力されない問題
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

追記: F11は実装していないため無視

## [x] F11のキャラ情報出力で狂気度が0固定になっている問題

command.hsp 4588行目
  s(3)="狂気度    : 0"
↓
  s(3)="狂気度    : "+cSAN(pc)

## [x] ムーンゲートによるランダムゲート機能が無効化されている問題
69 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：11/04/23 19:41:13 ID:pQkMm0iG
微妙に感じていた違和感が解消できたので投下

現象：ムーンゲートによるランダムゲート機能が無効化されている
対策：command.hspの79行目にある" : goto *pc_turn"を削除
※譲渡されたソースでのみ発生すると思われる

追記: 譲渡ソースのみのため無関係

## [x] 召喚石でのレベル表示がおかしい問題
召喚石を使った際のCNPC一覧のレベル表示は
mes "" + userdata(2, i)　となっているが、
これだと該当ショウルームに存在する以外のCNPCが読み込まれている場合、違うCNPCのレベルを表示してしまうことがあるため
CNPCの名前をlistn(0, listmax)に代入する処理のあたりでCNPCのレベルも適当な変数（list(1, listmax)とか）に代入してそれを表示すると良い

追記: 今現在召喚石は無効化している

## [x] NPCに宝の地図等を渡すと何度も読み続ける問題
ペット以外に渡したとき宝の地図・物件の権利書系は何度も読み続けてしまう
if ( inv(3, ci) == 16 | inv(3, ci) == 245 )
のあたりで除外条件を増やして対処する

command.hsp 3801行目

## [x] ペットのフィートの表示がおかしい問題
PCがエーテル製の装備をしているとペットの「特徴と体質」にも「彼（彼女）のエーテル病の進行は早い」と表示されてしまう
if ( gdata(800) != 0 ) {　の前に　if ( tc == 0 ) {　を入れると良い

PCがフィートを取得可能な状態だとペットの「特徴と体質」にも「取得できるフィート」と表示されてしまう
検索して一番最初の　if ( gdata(93) > 0 ) {　の前に　if ( tc == 0 ) {　を入れると良い

## [x] 装備していないアイテムのエンチャントが特徴と体質に表示されることがある問題
装備によって付与される特徴がまったく関係ないキャラクターの「特徴と体質」にも表示されてしまうことがある
上記の　if ( gdata(800) != 0 ) {　のちょっと下辺りの　repeat 30, 100　で装備品のエンチャントをチェックしているが、
if ( cdata(cnt, tc) \ 10000 != 0 ) {　の下で無条件でciのエンチャントをチェックしているため
if ( cdata(cnt, tc) \ 10000 != 0 ) {　を満たさずciに代入されなかった場合、直前のciがそのまま使われることになるのが原因
if ( cdata(cnt, tc) \ 10000 != 0 ) {　のブロックに　repeat 15　のループも突っ込めば大丈夫なはず

## [x] 攻撃倍率が100以上のときに小数点より下が表示されない問題
calcAttackDmg(1)で検索して出る少し下あたり
strmid(s(2),0,3+(int(s(2))>=10))
↓
strmid(s(2),0,3+(int(s(2))>=10)+(int(s(2))>=100))
これでおｋ

## [x] 錬金術・調合・ガロクの槌で大事なもの指定が無視されている問題
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
#define ifnodrop(%1)～の行を
#define global ifnodrop(%1)～として
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

追記: ガロク槌はだいじなもの指定を無視するようにした(omake互換)。錬金術の杖/調合はだいじなもの指定を参照する

## [x] 掲示板から依頼主の元に飛んで足元の罠で死んだ場合も依頼が受けられる問題
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

## [x] NPCのインベントリを見たとき、(利腕)の表示が実際と食い違う問題
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


## [x] アイテム最大数を超えてアイテムを置ける問題
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


アイテム最大数を超えても400個までなら家具を置ける
アイテム最大数を1個超えて任意のアイテムを置ける
前者は仕様、後者は不等号のミスである可能性が高い

command.hsp 3669行目
      if mMaxInv!0:if inv_sum(-1)>mMaxInv : if iType(ci)!fltFurniture:txt lang("これ以上は置けない。","You can't drop items any more."):snd seFail1:goto *com_inventory_loop
↓
      if mMaxInv!0:if inv_sum(-1)>=mMaxInv : if iType(ci)!fltFurniture:txt lang("これ以上は置けない。","You can't drop items any more."):snd seFail1:goto *com_inventory_loop


## [ ] スペル表示画面に無意味な数値が表示されている問題
170 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：2011/04/19(火) 01:42:29.15 ID:QS55o+CL
v画面で見る鑑定・解呪・清浄なる光・全浄化のパワーには
calcskillで計算されたbonusが使われてるけど実際の判定には元のスペルパワーしか使われてない

v画面で見るホーリーヴェイルのパワー・c画面で見るホーリーヴェイル系のパワーには
calcbuffで計算された値が使われてるけどこれも実際の判定に使われてない気がする


契約のbonus値は判定に使われているので問題ない
それ以外を非表示にしてしまうとよい

command.hsp 2226行目

## [x] ポピーからアイテムを受け取れたり、ブリーダーなどに指定できる問題

command.hsp 461行目
  if allyCtrl!1:if cBit(cBodyguard,cnt)=true:continue
↓
  if allyCtrl!1:if (cBit(cBodyguard,cnt)=true)or(cBit(cGuardTemp,cnt)=true):continue

command.hsp 1834行目
    if tc<maxFollower :if cBit(cBodyguard,tc)=false: goto *com_allyInventory
↓
    if tc<maxFollower :if cBit(cBodyguard,tc)=false:if cBit(cGuardTemp,tc)=false : goto *com_allyInventory

## [ ] ペットにおみやげを渡したときの挙動がおかしい問題

ペットにおみやげを渡す→xキーで再現する。

ペットインベントリの状態が初期化されない。
また、ペットのときに連続渡しが出来なかったり、ペット以外に渡したときにターンが経過しない。

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


## [x] 媚薬を渡したとき重量再計算が行われない問題

command.hsp 3829行目
          modImp tc,-20:cEmoIcon(tc)=emoAngry+extEmo*3:iNum(ci)--
↓
          modImp tc,-20:cEmoIcon(tc)=emoAngry+extEmo*3:iNum(ci)--:call *calcBurdenPc
## [x] 技能一覧が主能力順にソートされていない問題

command.hsp 1755行目
  if spAct(cnt)!0:list(0,listMax)=cnt+headSpAct,skillUse(cnt)*1000+cnt:listMax++
↓
  if spAct(cnt)!0:list(0,listMax)=cnt+headSpAct,skillUse(cnt+headSpAct)*1000+cnt:listMax++

## [ ] 自己認識の技能が正しく機能していない問題

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

