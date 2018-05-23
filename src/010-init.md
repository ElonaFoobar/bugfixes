# init.hsp


## [ ] 魔力制御の対象が誤っている問題
975 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/17(木) 00:59:50.55 ID:04wseWc/ [1/2]
魔力制御の計算命令(calcmagiccontrol)に誤り。
関係が0以上同士と-1以下同士の時に魔力制御の対象になっているが、
これだと敵対(-3)vs無関心(-1)の交戦でボールやボルトを使っても相手に当たらない。
そこで条件を「0以上同士、-1同士、-2以下同士」に変更。
スウォーム攻撃の除外判定も同じ条件でいける。


init.hsp 3510行目
 #define global ctype sameTeam(%1,%2) ( ((cRelation(%1)>=cNeutral)&(cRelation(%2)>=cNeutral))or((cRelation(%1)<=cDislike)&(cRelation(%2)<=cDislike)) )
↓
 #define global ctype sameTeam(%1,%2) ( ((cRelation(%1)>=cNeutral)&(cRelation(%2)>=cNeutral))or((cRelation(%1)=cDislike)&(cRelation(%2)=cDislike))or((cRelation(%1)<=cHate)&(cRelation(%2)<=cHate)) )

## [x] 無効耐性を複数持つモンスターの2個目以降の耐性が機能していない問題
323 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 21:47:30.14 ID:Myv4aFO+ [3/4]
もういっちょ、やっとマクロが何なのか分かってきたんだぜ
init.hsp内のresImmマクロがうまく機能してないため二つ目三つ目の耐性が無効に
二三行目の条件をrsRes%2!0みたいにすれば多分直る。ついでにその上のresWeakも直すといいかも
BF最新版でも一応確認してきたけど神経ブレスで目玉がミンチになったから未修正っぽい
逆コンならとりあえず幾つかのif ( nerve != 0 ) の中を実行するように
なお、既存敵で複数耐性を持つのは目玉のみの模様(幻惑、神経)

金ベルの魔法耐性消失は*calcInitialSkill(逆コン*label_1511)だってのが判った
Lv1除外の理由ってプレイヤーの耐性初期化以外ぐらいしか思いつかないんだけど他に何かあるのかな

327 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/29(火) 23:34:39.15 ID:Myv4aFO+ [4/4]
うん、不具合って事で俺の中で結論が出た。cLevel(r1)=1をr1=pcに変更で特に問題もないっぽい(逆コンならr1==0)
cnpcで半端な耐性が無効化されたりするのも多分不具合、既存敵の耐性がMAXか弱点かしかないからそれを基準にした判定しかしてないため
となると失耐性で下がったペットの耐性が元に戻せないのもやっぱり一種の不具合かな
こっちはスマートな対処法見つかったら書く

転載再upは別に構わないけどバグバグしいのは消した方がいいと思う。あと今はまだ非公式改造版だって書いとくといいかも

## [ ] エラーテキストのショウルーム判定が誤っている問題
エラーテキストのところでareShowHouseとあるが
areaShowHouse(逆コンなら35)のミス
これにより意図しないときに(possibly)invalid show roomのエラーテキストが吐かれていた
過去のエラー文を漁るときは気をつけておくこと

## [x] 過去メッセージの透過を有効にしているとき、ログが一部透明化する問題
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

## [ ] 「」付きのセリフが着色されないことがある問題

「」付きのセリフは自動的に文字色が緑になる
ただし、「」付きのセリフを黄色で表示したいときはtColFixというフラグを送っている
このフラグは「」付きの文字を表示したときと、他の文字色を指定したときしかリセットされない

「」付きでない黄色のメッセージを表示→「」付きのセリフを表示、とすると最初だけ文字色が白になる
適当なところで初期化が必要


init.hsp 4024行目
  tColFix=false
を挿入

3901行目・3973行目・4005行目の:else:tColFix=falseをコメントアウト

## [ ] エンチャントにおいて属性が意図通り決定されていない問題
属性のレア度を比較するとき参照先が間違っていて関数が機能していない
init.hsp 2846行目付近
`#define global ctype skillRare(%1)sdataRef@(4,%1)`
↓
`#define global ctype skillRare(%1)sdataRef@(3,%1)`

item_data.hsp 213行目付近
`#defcfunc randomEle内`
if p!1{
↓
if skillRare(p)!1{

逆コンでは13300行目付近
#`defcfunc randomele 内`
if ( p@m45 != 1 ) →if ( sdataref(3, p@m45) != 1 )
sdataref(4, p@m45)→sdataref(3, p@m45)　 (2ヶ所)
sdataref(4, i@m45)→sdataref(3, i@m45)

ただしこのまま修正すると大幅なバランス変更になってしまうので
encAddのところで
enc=randomEle()
↓
enc=rnd(tailResist-headResist)+headResist (2ヶ所)
と、なかったことにしてバランスを変えない方が無難かもしれない

## [ ] ノルンのガイドが一部ワールドマップ歩行中に表示されない問題

ガイドは継続行動中は表示されない
1時間ごとの天候変化時しかガイドの判定を行っていないので、
例えばワールドマップ歩行中に天候がエーテルの風になってもノルンは出てこない


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
    if gWeather=weatherHardRain :help 11,2
    if gWeather=weatherSnow   :help 12,2
    if gWeather=weatherEther  :help 13,2
を挿入

1歩ごとに判定を入れ、ついでにマクロをdeffunc化した

