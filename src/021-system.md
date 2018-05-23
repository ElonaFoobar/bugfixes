# system.hsp


## [ ] 口調設定bitを消去する対象が間違っている問題
.ショウルーム内に配置されるキャラの特定のbitを消す処理内で
配置キャラではなく現在対象となっているキャラの口調設定bitが消えてしまう。
これにより、そのキャラが口調ファイルを読み込んでくれなくなる。
口調設定したペットをターゲティングした直後、
ハウスドームからショウルームに入ると簡単に再現できる。


譲渡ソースコードのsystem.hsp 1023行目
cBitMod cMsgFile,tc,false
↓
cBitMod cMsgFile,rc,false


## [ ] CNPCのテキストが正しく読み込まれない問題
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

## [ ] CNPCにすくつ補正が付かない問題
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

## [ ] 遺伝子引き継ぎ時の所持金やプラチナ等のボーナスが固定になっている問題

遺伝子データを読み込んでいるとき、
後の処理で所持金・スキルを参照するため一時スロット(nc:56)に退避しているが
参照する前に誤って消してしまっていた


system.hsp 251-252行目
  if cnt=nc:continue
を挿入

system.hsp 212行目
  del_chara nc
を挿入

## [ ] 引っ越しの際に使用人が消滅する問題
家を建て替えるときの処理でfmode = 17でファイルの読み込みをする部分の
exist file + "cdata_" + mid + ".s2"　のfileは恐らくfolderの間違い
ここをfolderに直すと引っ越しの際に滞在者も一緒に引っ越されるけど、
小城の場合、旧滞在者 + 小城に最初からいる滞在者で引っ越すたびに増え続けるので注意

## [ ] 入力フォームを呼び出すとFailed to get WINDOW IDと表示される問題

願いや個数などの入力フォームを呼び出す部分
改造版でウィンドウタイトルを変更していると表示されることがある


system.hsp 1683行目
    aplsel _Title+" ver "+_Version  :if stat=1:dialog "Failed to get WINDOW ID",1:clrobj 1:cfg_msg_box=0:goto *prompt_word
↓
    aplsel _Title:if stat=1:dialog "Failed to get WINDOW ID",1:clrobj 1:cfg_msg_box=0:goto *prompt_word

aplsel命令は前方一致でウィンドウ名を探すので、こんな風にするだけでもエラー回避は出来る。

    windowTitle=""
    sendmsg hwnd, $D, 64, varptr(windowTitle)
    aplsel windowTitle:if stat=1:dialog "Failed to get WINDOW ID",1:clrobj 1:cfg_msg_box=0:goto *prompt_word

こう変更してウィンドウのタイトルを取得する手もある。

## [ ] 水の波紋をオフにしているとタイトルの文字がにじむ問題

while-wendでウィンドウの再描画を行っていないので
文字のアンチエイリアスが有効の場合、文字だけ描画が重なり続けてしまう
波紋オフのときもwater.hpiの命令を用いて再描画しておく


system.hsp 1422行目
  if cfg_titleEffect:if water_debug=0:water_getimage:water_debug=1
  gsel selInf :pos 960,96:picload exeDir+"graphic\\deco_title.bmp",1
  gsel selScr :gmode 0:pos 0,0:gcopy selBuf,0,0,windowW,windowH:gmode 2
  
  while
  numlock_off 
  redraw 0
  tx+=(rnd(10)+2)*p(1):ty+=(rnd(10)+2)*p(2)
  if rnd(10)=0:tx=rnd(800):ty=rnd(600):p(1)=rnd(9)-4,rnd(9)-4
  f=false :if (tx>40)&(tx<500)&(ty>100)&(ty<450):f=true
  if f=false :if rnd(10)=0:f=2
  if f=false :water_setripple tx, ty, rnd(300), rnd(4)
  if cfg_titleEffect:water_calc :water_draw
↓
  if water_debug=0:water_getimage:water_debug=1
  ;gsel selInf :pos 960,96:picload exeDir+"graphic\\deco_title.bmp",1 ;使用されていないのでコメントアウト
  gsel selScr :gmode 0:pos 0,0:gcopy selBuf,0,0,windowW,windowH:gmode 2
  
  while
  numlock_off 
  redraw 0
  if cfg_titleEffect{
    tx+=(rnd(10)+2)*p(1):ty+=(rnd(10)+2)*p(2)
    if rnd(10)=0:tx=rnd(800):ty=rnd(600):p(1)=rnd(9)-4,rnd(9)-4
    f=false :if (tx>40)&(tx<500)&(ty>100)&(ty<450):f=true
    if f=false :if rnd(10)=0:f=2
    if f=false :water_setripple tx, ty, rnd(300), rnd(4)
    water_calc
  }else{
    water_refresh
  }
  water_draw

