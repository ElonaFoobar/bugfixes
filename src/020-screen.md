# screen.hsp


## [x] カジノの描画が重なり続ける問題
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


screen.hsp 116行目
 *screen_draw
  screenDrawHack=1
  gmode 2
  redraw 0
  if mode=mode_txtAdv{
  ; gosub *screen_txtAdv ;←ここのコメントアウトを復帰する
    }else{
    sxFix=0:syFix=0:gosub *screen_setPos
    gosub *LoS:gosub *los_draw
    }

## [x] 光源の届く距離が南北と東西で1マス違う問題
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

## [x] 遠隔弾が縦方向にずれる問題
screen.hsp 666行目
 aX=(cX(cc)-scX)*tileS : aY=(cY(cc)-scY)*tileS-12

1.22逆コンパイルソース 116400行付近
 ay = (cdata(2, cc) - scy) * inf_tiles - 12
↓
 ay = (cdata(2, cc) - scy) * inf_tiles + inf_screeny + 8

## [ ] ミニマップを明るくする範囲が広すぎる問題
ミニマップの画像を明るくする処理の範囲指定で
gfini raderw * mdata(0), raderh * mdata(1)　というのがあるが、
これだとマップが大きい場合範囲が広がりすぎて他の画像にまでかかってしまい一部の表示がおかしくなる
gfini 130, 90　くらいの定数にしても特に問題はないはず

## [x] PCが狂乱になったとき落ちる問題
screen.hsp 302行目あたり
_conAngryhHeavy(2)→_conAngry(1)
逆コンも同様でおｋ(115600行目付近)

## [x] 壁破壊アニメが表示されない問題
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

## [x] オートターン中のバフアイコンがちらつく問題
118 名前：名無しさん＠お腹いっぱい。[sage] 投稿日：12/02/05 03:29:18 ID:n1JrLP9C
オートターン中の半透明部分(右下の祝福/呪いアイコン)のちらつき。
原因はHUDの二重描画。

"AUTO TURN"の文字とアニメーションを表示するサブルーチンの序盤で、
セル描画ルーチンへのgosubは条件
( msgtemp != "" | (cdata(140, 0) == 7 & rowactre == 0 & fishanime == 0) )
を満たした時だけ実行されるが、HUD描画ルーチンへのgosubは無条件で実行されてる。

HUD描画ルーチンへのgosubも条件を満たした時だけ実行されるようにすればちらつきは消える。

screen.hsp 379行目

## [x] 主能力が4桁に達していると画面下部の表示がおかしくなる問題
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

## [ ] 状態異常表示テキストがリフレッシュされない問題
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

## [x] アニメ表示の条件分岐がおかしい問題
アニメ表示部の修正
　アニメ表示が意図されたように表示されていない
　対処
　screen.hsp 927行目
　ifの条件に関わらずpreparePicItem 17が実行されている
　Noa氏への問い合わせの結果、「記憶が定かではないが多分記述ミス」とのことことだったので
　else後のpreparePicItemのパラメータを17から18に変更
　※item.bmpを見て「多分18かな？」と判断したので正しい値かどうかは不明

//anisandに分岐する場合ってあったっけ

