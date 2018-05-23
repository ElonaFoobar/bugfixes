# main.hsp


## 一度も初期洞窟から出ないまま這い上がったときゲーム進行不能に陥る問題
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

## ネフィアボス討伐報酬の金貨の量が205枚固定になっている問題
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

## すくつボスの基本レベルが適切でない問題
すくつボスの基本レベル
initlv = gdata(22) / 4
となっているが低層では周りの敵より弱くなり、深層では逆に上がりすぎてしまう
initlv = limit(gdata(22) / 4, 50, 250)
とでもしておくといいかもしれない

## 勝利ウィンドウの表示がおかしい問題
288 名前：名無しさん＠お腹いっぱい。　[sage]　投稿日：2011/03/28(月) 18:32:34.81 ID:0T617TrP
~*勝利*ウィンドウの表示不具合修正。
まず、void.bmpの読み込み直後に以下の処理を挿入。
~> pos 0, 0
~> gzoom windoww, windowh, 4, 0, 0, 640, 480

そしてwwに680を、whに488を、pagesizeに0をセットする記述を追加し、
以下の記述でdisplay_windowを実行。
~> display_window (windoww / 2) - (ww / 2) , (windowh / 2) - (wh / 2), ww, wh

## 死んでマップから消滅したはずのユニットが残留し続ける問題
地面効果による当たり判定の後に、ユニットが生存しているか否かの判定がないため、
装備品が呪われているユニットが、マップ効果(火柱や酸)でミンチになったと同時に呪いによるテレポートが発動すると、
テレポート先のユニット表示情報が更新されてしまうのが原因。

main.hsp 749行目

## ゲスト冒険者の判定がおかしい問題
Re: Elona開発ファイル所有者の情報交換トピック
投稿記事by ゲスト on 土 1 10, 2015 4:17 pm

気になる処理が2つほどあったのですが、これらは意図されたものなのか分かる方いらっしゃいましたら教えてくださると助かります。

1. main.hsp 1061行目 levelExitBy==mExitNormal
　　　　これは正しくはlevelExitBy=mExitNormalと考えてよいのでしょうか？

2. main.hsp 1848行目 cArea(i)!gArea
　　　　これは正しくはif cArea(i)!gAreaと考えてよいのでしょうか？

もし既出でしたらすみません。


1の==は=と同じように解釈されているようだ
2はcArea(i)=(cArea(i)!=gArea)と同じように解釈されるので実質的にcArea(i)=1と同じ
冒険者の現在地にエリア番号1が代入されてしまう
また、一連の処理の中でif cImpression(cnt)<cImpression(i):tc=i:p++の部分もおかしい
cntではペットと冒険者の友好度を比較してしまうのでtcの間違いだろう


main.hsp 1844行目
  if (rnd(3))or(develop){
    p=0:tc=0
    repeat 100
    i=rnd(maxAdv)+maxFollower
    if cExist(i)=cAdv:if cBit(cHired,i)=false:cArea(i)!gArea:if cRelation(i)>=cNeutral{
      if rnd(25)<p:break
      if tc=0{
        tc=i:p++
        if cImpression(tc)<defImpHate :if rnd(12)=0:break
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
        if cImpression(tc)<defImpHate :if rnd(12)=0:break
        if cImpression(tc)<defImpEnemy :if rnd(4):break
        continue
        }
      if cImpression(tc)<cImpression(i):tc=i:p++
      }
    loop

## マイチェアがなくても来客用の椅子の近くに椅子があると来客時にPCがそちらに移動してしまう問題

来客用の椅子があり、マイチェアがあればPCはマイチェアに、ペットは来客近くの他の椅子を探して座るような仕様になっている。

今回の修正では
来客用の椅子があればマイチェアがなくともPCとペットは近くの椅子を探して座る、となっていたのを
来客用の椅子があってマイチェアがない場合、来客は座るがPCもペットも座らないとした。


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
  if c=tc: if iParam1(cnt)=2:cell_swap c,-1,iX(cnt),iY(cnt):i=cnt:p=cnt:break:else:continue ;guest
  if i=0:break:else:if cnt=i:continue
  if c=0:if iParam1(cnt)=1{ ;pc
    p=cnt
    pcChair=1:break
  }else:if(pcChair){  ;pets
    p(2)=dist(iX(cnt),iY(cnt),iX(i),iY(i)) 
    if p(2)<p(1):if (map(iX(cnt),iY(cnt),1)=0)or(c=0)or(c=tc):p=cnt,p(2)
  }
  loop
  if p!0:cell_swap c,-1,iX(p),iY(p)
  cDir(c)=direction(cX(c),cY(c),cX(tc),cY(tc)):if c=0:gRunDir=cDir(c)
  loop
  gosub *chat
  swbreak

