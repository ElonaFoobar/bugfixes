# sound.hsp


## [ ] `*map_init_main`で指定された音楽が再生されない問題
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

