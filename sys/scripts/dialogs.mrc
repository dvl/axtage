;;
;; a.Xtage! - Advanced.Xtage
;; by: dvl <contato@xdvl.info>
;;

;; dialogs

dialog autojoin {
  title "a.X - Auto Join"
  size -1 -1 135 121
  option dbu
  box "Auto Join", 1, 1 2 133 80
  box "", 2, 1 80 133 40
  edit "", 3, 27 86 57 10
  text "Canal:", 4, 4 88 19 8
  edit "", 5, 27 96 57 10
  text "Rede:", 6, 4 98 19 8
  edit "", 7, 27 106 57 10
  text "Senha:", 8, 4 108 19 8
  check "Ativar Auto-Join", 9, 86 107 45 10
  list 10, 86 84 46 30, size
  list 12, 3 9 128 72, size
}

alias autojoin {
  if ($dialog(autojoin)) { dialog -v autojoin }
  else { dialog -m autojoin autojoin }
}

on *:dialog:autojoin:init:0: {
  mdx.init
  mdx SetFont 1 11 800 Tahoma
  mdx SetFont 2,3,4,5,6,7,8,9,10,12 11 250 Tahoma
  mdx SetControlMDX 10 toolbar list flat nodivider wrap arows > $mdx(bars)
  mdx SetBorderStyle 10 none
  did -i autojoin 10 1 bmpsize 16 16
  did -i autojoin 10 1 setimage icon small $icon(3)
  did -i autojoin 10 1 setimage icon small $icon(9)
  did -i autojoin 10 1 setimage icon small $icon(11)
  did -a autojoin 10 +W 90 1 Adicionar 
  did -a autojoin 10 +W 90 2 Deletar 
  ;did -a autojoin 10 +W 90 3 Fechar
  mdx SetControlMDX 12 ListView report rowselect single flat > $mdx(views)
  did -i autojoin 12 1 headerdims 117 118
  did -i autojoin 12 1 headertext Canal $chr(9) Rede
  mdx SetDialog autojoin icon
  aj.list
  if (%autojoin == 1) { did -c autojoin 9 }
}

on *:dialog:autojoin:sclick:*: {
  if ($did == 10) { 
    if ($did(autojoin,10).sel == 2) { aj.add }
    if ($did(autojoin,10).sel == 3) { .write -dl $+ $calc($did(autojoin,12).sel - 1) $shortfn($mircdirsys\db\autojoin.txt) | aj.list }
    if ($did(autojoin,10).sel == 4) { dialog -x autojoin }
  }
  if ($did == 9) { 
    set %autojoin $did(autojoin,9).state
  }
}

alias aj.add {
  if ($did(autojoin,3) == $null) || ($did(autojoin,5) == $null) { var %erro $input(Preecha todos os campos necessarios,wo,Auto-Join) | halt }
  write $shortfn($mircdirsys\db\autojoin.txt) $did(autojoin,3) $did(autojoin,5) $iif($did(autojoin,7) == $null,*NE-NHU-MA*,$did(autojoin,7))
  did -r autojoin 3,5,7
  filter -ffct 1 255 $shortfn($mircdirsys\db\autojoin.txt) $shortfn($mircdirsys\db\autojoin.txt)
  aj.list
}

alias aj.list {
  did -r autojoin 12
  var %x 1 
  while (%x <= $lines($shortfn($mircdirsys\db\autojoin.txt))) { 
    did -a autojoin 12 $gettok($read($shortfn($mircdirsys\db\autojoin.txt),%x),1,32) $chr(9) $gettok($read($shortfn($mircdirsys\db\autojoin.txt),%x),2,32)
    inc %x 
  }
}

on *:notice:*senha*aceita*:*: { if ($nick == NickServ) && (%autojoin == 1) { autoj } }
on *:notice:*you*are*now*recognized*:*: { if ($nick == NickServ) && (%autojoin == 1) { autoj } }
on *:notice:*reconhecido*automaticamente*:*: { if ($nick == NickServ) && (%autojoin == 1) { autoj } }

alias autoj { 
  var %x 1
  while (%x <= $lines($shortfn($mircdirsys\db\autojoin.txt))) { 
    set %y $read($shortfn($mircdirsys\db\autojoin.txt),%x) 
    if ($gettok(%y,2,32) == $network) { !join -n $gettok(%y,1,32) $gettok(%y,3,32) }
    inc %x 
  }
  unset %y
}

;; AID

dialog autoid {
  title "a.X - Auto Identify"
  size -1 -1 135 121
  option dbu
  box "Auto Identify", 1, 1 2 133 80
  box "", 2, 1 80 133 40
  edit "", 3, 27 86 57 10
  text "Nick:", 4, 4 88 19 8
  edit "", 5, 27 96 57 10
  text "Rede:", 6, 4 98 19 8
  edit "", 7, 27 106 57 10
  text "Senha:", 8, 4 108 19 8
  check "Ativar Auto-ID", 9, 86 107 45 10
  list 10, 86 84 46 30, size
  list 12, 3 9 128 72, size
}

alias autoid {
  if ($dialog(autoid)) { dialog -v autoid }
  else { dialog -m autoid autoid }
}

on *:dialog:autoid:init:0: {
  mdx.init
  mdx SetFont 1 11 800 Tahoma
  mdx SetFont 2,3,4,5,6,7,8,9,10,12 11 250 Tahoma
  mdx SetControlMDX 10 toolbar list flat nodivider wrap arows > $mdx(bars)
  mdx SetBorderStyle 10 none
  did -i autoid 10 1 bmpsize 16 16
  did -i autoid 10 1 setimage icon small $icon(3)
  did -i autoid 10 1 setimage icon small $icon(9)
  did -i autoid 10 1 setimage icon small $icon(11)
  did -a autoid 10 +W 90 1 Adicionar 
  did -a autoid 10 +W 90 2 Deletar 
  ;did -a autoid 10 +W 90 3 Fechar
  mdx SetControlMDX 12 ListView report rowselect single flat > $mdx(views)
  did -i autoid 12 1 headerdims 117 118
  did -i autoid 12 1 headertext Nick $chr(9) Rede
  mdx SetDialog autoid icon
  ai.list
  if (%autoid == 1) { did -c autoid 9 }
}

on *:dialog:autoid:sclick:*: {
  if ($did == 10) {
    if ($did(autoid,10).sel == 2) { ai.add }
    if ($did(autoid,10).sel == 3) { .write -dl $+ $calc($did(autoid,12).sel - 1) $shortfn($mircdirsys\db\autoid.txt) | ai.list }
    if ($did(autoid,10).sel == 4) { dialog -x autoid }
  }
  if ($did == 9) { 
    set %autoid $did(autoid,9).state
  }
}

alias ai.add {
  if ($did(autoid,3) == $null) || ($did(autoid,5) == $null) || ($did(autoid,7) == $null) { var %erro $input(Preecha todos os campos necessarios,wo,Auto-Identify) | halt }
  write $shortfn($mircdirsys\db\autoid.txt) $did(autoid,3) $did(autoid,5) $did(autoid,7)
  did -r autoid 3,5,7
  filter -ffct 1 255 $shortfn($mircdirsys\db\autoid.txt) $shortfn($mircdirsys\db\autoid.txt)
  ai.list
}

alias ai.list {
  did -r autoid 12
  var %x 1 
  while (%x <= $lines($shortfn($mircdirsys\db\autoid.txt))) { 
    did -a autoid 12 $gettok($read($shortfn($mircdirsys\db\autoid.txt),%x),1,32) $chr(9) $gettok($read($shortfn($mircdirsys\db\autoid.txt),%x),2,32)
    inc %x 
  }
}

on *:notice:*/*nickserv*identify*:*: { if ($nick == NickServ) && (%autoid == 1) { autoide } }

alias autoide { 
  var %pw = $read($mircdirsys\db\autoid.txt,s,$me $network)
  if (!%pw) { var %pw = $read($mircdirsys\db\autoid.txt,s,$me $chr(42)) }
  if (%pw) { nickserv identify %pw }
}

;ACONN

dialog autoconn {
  title "a.X - Auto-Connect"
  size -1 -1 170 132
  option dbu
  box "Auto-Connect", 1, 1 2 168 80
  box "", 2, 1 80 168 51
  edit "", 3, 27 86 57 10
  text "Servidor:", 4, 4 88 19 8
  edit "", 5, 109 86 57 10
  text "Nick:", 6, 86 88 19 8
  edit "6667", 7, 27 96 57 10
  text "Porta:", 8, 4 98 19 8
  list 10, 86 117 80 12, size
  list 12, 3 9 164 72, size
  text "Alt.nick:", 13, 86 98 19 8
  edit "", 14, 109 96 57 10
  text "E-Mail:", 15, 86 108 19 8
  edit "", 16, 109 106 57 10
  text "Nome:", 17, 4 108 19 8
  edit "", 18, 27 106 57 10
  check "Ativar Auto-Connect", 9, 6 118 60 10, flat
}

alias autoconn {
  if ($dialog(autoconn)) { dialog -v autoconn }
  else { dialog -m autoconn autoconn }
}

on *:dialog:autoconn:init:0: {
  mdx.init
  mdx SetFont 1 11 800 Tahoma
  mdx SetFont 2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18 11 250 Tahoma
  mdx SetControlMDX 10 toolbar list flat nodivider wrap arows > $mdx(bars)
  mdx SetBorderStyle 10 none
  did -i autoconn 10 1 bmpsize 16 16
  did -i autoconn 10 1 setimage icon small $icon(3)
  did -i autoconn 10 1 setimage icon small $icon(9)
  did -i autoconn 10 1 setimage icon small $icon(11)
  did -a autoconn 10 +W 80 1 Adicionar 
  did -a autoconn 10 +W 80 2 Deletar 
  ;did -a autoconn 10 +W 90 3 Fechar
  mdx SetControlMDX 12 ListView report rowselect single flat > $mdx(views)
  did -i autoconn 12 1 headerdims 100 55 50 50 70 70 
  did -i autoconn 12 1 headertext Servidor $chr(9) Porta $chr(9) Nick $chr(9) Anick $chr(9) E-Mail $chr(9) Nome
  mdx SetDialog autoconn icon
  ac.list
  did -a autoconn 5 $nick
  did -a autoconn 14 $anick
  did -a autoconn 16 $emailaddr
  did -a autoconn 18 $fullname
  if (%autoconn == 1) { did -c autoconn 9 }
}

on *:dialog:autoconn:sclick:*: {
  if ($did == 10) { 
    if ($did(autoconn,10).sel == 2) { ac.add }
    if ($did(autoconn,10).sel == 3) { .write -dl $+ $calc($did(autoconn,12).sel - 1) $shortfn($mircdirsys\db\autoconn.txt) | ac.list }
    if ($did(autoconn,10).sel == 4) { dialog -x autoconn }
  } 
  if ($did == 9) { 
    set %autoconn $did(autoconn,9).state
  }
}

alias ac.add {
  if ($did(autoconn,3) == $null) || ($did(autoconn,5) == $null) || ($did(autoconn,7) == $null) || ($did(autoconn,14) == $null) || ($did(autoconn,16) == $null) || ($did(autoconn,18) == $null) { var %erro $input(Preecha todos os campos necessarios,wo,Auto-Connect) | halt }
  if ($did(autoconn,7) !isnum) { var %erro $input(A Porta deve ser um valor númerico $+ $chr(44) caso não saiba a porta deixe 6667 pois é o padrão de quase todos os servidores,wo,Auto-Connect) | halt }
  write $shortfn($mircdirsys\db\autoconn.txt) $+($did(autoconn,3),;,$did(autoconn,7),;,$did(autoconn,5),;,$did(autoconn,14),;,$did(autoconn,16),;,$did(autoconn,18))
  did -r autoconn 3
  filter -ffct 1 255 $shortfn($mircdirsys\db\autoconn.txt) $shortfn($mircdirsys\db\autoconn.txt)
  ac.list
}

alias ac.list {
  did -r autoconn 12
  var %x 1 
  while (%x <= $lines($shortfn($mircdirsys\db\autoconn.txt))) { 
    tokenize 59 $read($shortfn($mircdirsys\db\autoconn.txt),%x) 
    did -a autoconn 12 $1 $chr(9) $2 $chr(9) $3 $chr(9) $4 $chr(9) $5 $chr(9) $6
    inc %x 
  }
}

alias aconn { 
  if ($lines($shortfn($mircdirsys\db\autoconn.txt)) == 0) { halt }
  echo -s $m 01Auto-connect ativado3,1 conectando aos servidores3...
  var %x 1
  while (%x <= $lines($shortfn($mircdirsys\db\autoconn.txt))) { 
    tokenize 59 $read($shortfn($mircdirsys\db\autoconn.txt),%x) 
    server $iif(%x > 1,-mz) $+($1,:,$2) -i $3 $4 $5 $6
    inc %x 
  }
}

;; notify

dialog not {
  title "a.X - Notify List"
  size -1 -1 135 110
  option dbu
  box "Notify List", 1, 1 2 133 80
  box "", 2, 1 80 133 29
  edit "", 3, 27 86 57 10
  text "Nick:", 4, 4 88 19 8
  edit "", 5, 27 96 57 10
  text "Nota:", 6, 4 98 19 8
  list 10, 86 84 46 23, size
  list 12, 3 9 128 72, size
}


alias not {
  if ($dialog(not)) { dialog -v not }
  else { dialog -m not not }
}

on *:dialog:not:init:0: {
  mdx.init
  mdx SetFont 1 11 800 Tahoma
  mdx SetFont 2,3,4,5,6,10,12 11 250 Tahoma
  mdx SetControlMDX 10 toolbar list flat nodivider wrap arows > $mdx(bars)
  mdx SetBorderStyle 10 none
  did -i not 10 1 bmpsize 16 16
  did -i not 10 1 setimage icon small $icon(3)
  did -i not 10 1 setimage icon small $icon(9)
  did -a not 10 +W 90 1 Adicionar 
  did -a not 10 +W 90 2 Deletar 
  mdx SetControlMDX 12 ListView report rowselect single flat > $mdx(views)
  did -i not 12 1 headerdims 110 120
  did -i not 12 1 headertext Nick $chr(9) Nota
  mdx SetDialog not icon
  not.list2
}

on *:dialog:not:sclick:10: {
  if ($did(not,10).sel == 2) { not.add }
  if ($did(not,10).sel == 3) { .notify -r $gettok($did(not,12).seltext,6,32) | not.list2 }
  if ($did(not,10).sel == 4) { dialog -x not }
}

alias not.list2 {
  did -r not 12
  var %x 1 
  while (%x <= $notify(0)) { 
    did -a not 12 $notify(%x) $chr(9) $iif($notify(%x).note,$notify(%x).note,n/a)
    inc %x 
  }
}

alias not.add {
  if ($did(not,3) == $null) { var %erro $input(Preecha todos os campos necessarios,wo,Notify List) | halt }
  .notify $did(not,3) $did(not,5)
  not.list2
  did -r not 3,5
}

;; bracket e timestamp

dialog bes {
  title "a.X - Bracket e Timestamp"
  size -1 -1 83 91
  option dbu
  box "Bracket", 1, 0 1 83 45
  edit %bracket , 2, 2 8 78 10,autohs
  list 3, 2 19 78 24, size
  box "Timestamp", 4, 0 46 83 45
  edit %timestamp , 5, 2 53 78 10,autohs
  list 6, 2 64 78 24, size
}

alias tstamp {
  if ($dialog(bes)) { dialog -v bes }
  else { dialog -m bes bes }
}

on *:dialog:bes:init:0: { 
  mdx.init
  mdx SetFont 1,4 11 800 Tahoma
  mdx SetFont 2,3,5,6 11 250 Tahoma
  mdx SetControlMDX 3,6 ListView headerdrag report noheader rowselect single infotip > $mdx(views)
  did -i bes 3 1 headerdims 50 90
  did -i bes 6 1 headerdims 30 90
  did -i bes 3,6 1 headertext Tag 	+r Descrição
  did -a bes 3 *nick $chr(9) $+ nick de quem falo
  did -a bes 3 *modo $chr(9) $+ modo do nick no canal
  did -a bes 6 *HH $chr(9) $+ hora (24hrs)
  did -a bes 6 *hh $chr(9) $+ hora (12hrs)
  did -a bes 6 *nn $chr(9) $+ minuto
  did -a bes 6 *ss $chr(9) $+ segundo
  did -a bes 6 *tt $chr(9) $+ am/pm
  mdx SetDialog bes icon
}

on *:dialog:bes:edit:*: {
  if ($did == 2) { set %bracket $did(bes,2).text }
  if ($did == 5) { set %timestamp $did(bes,5).text }
}

;; autocor

dialog autocor {
  title "a.X - Auto Cor"
  size -1 -1 136 70
  option dbu
  box "Auto Cor", 1, 0 1 136 69
  text "Cor do Texto:", 2, 3 9 39 8
  text "Cor de Fundo:", 3, 3 21 39 8
  combo 4, 43 8 38 51, size drop
  combo 5, 43 20 38 51, size drop
  edit "", 6, 42 32 38 10, autohs
  text "Prefixo:", 7, 3 33 25 8
  edit "", 8, 42 43 38 10, autohs
  text "Sulfixo:", 9, 3 44 25 8
  check "Ligado", 10, 83 8 50 10, push
  check "Negrito", 11, 83 20 50 10, push
  check "Sublinhado", 12, 83 32 50 10, push
  check "Prefixo e Sulfixo", 13, 83 44 50 10, push
  button "@autocor", 14, 3 57 130 10
}

on *:dialog:autocor:init:0: {
  mdx.init
  mdx SetFont 1,2,3,4,5,6,7,8,9,10,11,12,13,14 11 250 Tahoma
  mdx SetFont 1 11 800 Tahoma
  mdx SetControlMDX 14 window > $mdx(dialog)
  window -ph @autocor 1 1 300 30
  did -a autocor 14 grab $window(@autocor).hwnd @autocor
  if (%ac == on) { did -c autocor 10 }
  if (%ac == off) { did -b autocor 1,4,5,6,8,11,12,13 }
  if (%ac.bold == on) { did -c autocor 11 }
  if (%ac.und == on) { did -c autocor 12 }
  if (%ac.ps == on) { did -c autocor 13 }
  if (%ac.ps == off) { did -b autocor 6,8 }
  did -ra autocor 8 %ac.sul
  did -ra autocor 6 %ac.pre
  mdx SetBorderStyle 10,11,12,13 staticedge
  dll $shortfn($mircdirsys\dll\colorcombo.dll) COMBO autocor 4
  dll $shortfn($mircdirsys\dll\colorcombo.dll) COMBO autocor 5
  did -c autocor 4 $calc(%ac.c1 + 2)
  did -c autocor 5 $calc(%ac.c2 + 2)
  mdx SetDialog autocor icon
  ac.prev
}

alias autocor {
  if ($dialog(autocor)) { dialog -v autocor }
  else { dialog -m autocor autocor }
}

alias ac.prev {   
  clear @autocor
  drawtext -p @autocor 1 tahoma 11 1 2 15(03@01 $+ $mnick $+ 15) $ac(Exemplo!)
}

on *:dialog:autocor:sclick:*: {
  if ($did == 4) { 
    set %ac.c1 $calc($did(autocor,4).sel - 2) 
    if (%ac.c1 == -1) { set %ac.c1 01 }
    if ($len(%ac.c1) == 1) { set %ac.c1 0 $+ %ac.c1 }
  }
  if ($did == 5) { 
    set %ac.c2 $calc($did(autocor,5).sel - 2) 
    if (%ac.c2 == -1) { set %ac.c2 01 }
    if ($len(%ac.c2) == 1) { set %ac.c2 0 $+ %ac.c2 }
  }
  if ($did == 10) {
    if ($did(autocor,10).state == 0) { set %ac off | did -b autocor 4,5,11,12,13 }
    if ($did(autocor,10).state == 1) { set %ac on |  did -e autocor 4,5,11,12,13 }
  }
  if ($did == 11) {
    if ($did(autocor,11).state == 0) { set %ac.bold off }
    if ($did(autocor,11).state == 1) { set %ac.bold on }
  }
  if ($did == 12) {
    if ($did(autocor,12).state == 0) { set %ac.und off }
    if ($did(autocor,12).state == 1) { set %ac.und on }
  }
  if ($did == 13) {
    if ($did(autocor,13).state == 0) { set %ac.ps off | did -b autocor 6,8 }
    if ($did(autocor,13).state == 1) { set %ac.ps on |  did -e autocor 6,8 }
  }
  ac.prev
}
on *:dialog:autocor:edit:*: {
  if ($did == 6) { set %ac.pre $did(autocor,6) }
  if ($did == 8) { set %ac.sul $did(autocor,8) }
  ac.prev
}

alias ac {
  if (%ac == off) { return $1- }
  else { return $iif(%ac.ps == on,$replace(%ac.pre,<num>,%ac.cont,<len>,$len($1)) $+ ) $+ $iif(%ac.bold == on,) $+ $iif(%ac.und == on,) $+ $+(,%ac.c1,$iif(%ac.c2 != 00,$chr(44)),$iif(%ac.c2 != 00,%ac.c2)) $+ $1 $+  $+ $iif(%ac.ps == on,$replace(%ac.sul,<num>,%ac.cont,<len>,$len($1))) }
}

;; emotion

dialog emo {
  title "a.X - Emotions"
  size -1 -1 69 55
  option dbu
  box "Emotion", 1, 0 0 69 55, disable
  button "Oi! Tudo bem :D", 2, 2 42 65 10
  text "Boca:", 3, 2 9 25 8
  combo 4, 28 6 39 50, size drop
  combo 5, 28 18 39 50, size drop
  text "Olho:", 6, 2 20 25 8
  text "Fundo:", 7, 2 31 25 8
  combo 8, 28 30 39 50, size drop
}

on *:dialog:emo:init:0: {
  mdx.init
  mdx SetFont 1,2,3,4,5,6,7,8 11 250 Tahoma
  mdx SetFont 1 11 800 Tahoma
  mdx SetControlMDX 2 window > $mdx(dialog)
  window -ph @emo 1 1 300 30
  did -a emo 2 grab $window(@emo).hwnd @emo
  dll $shortfn($mircdirsys\dll\colorcombo.dll) COMBO emo 4
  dll $shortfn($mircdirsys\dll\colorcombo.dll) COMBO emo 5
  dll $shortfn($mircdirsys\dll\colorcombo.dll) COMBO emo 8
  did -c emo 4 $calc(%cor.boca + 2)
  did -c emo 5 $calc(%cor.olho + 2)
  did -c emo 8 $calc(%cor.fundo + 2)
  emo.prev
  mdx SetDialog $dname icon
}

alias emo.prev {
  clear @emo
  drawtext -p @emo 1 tahoma 11 1 2 15(03@01 $+ $mnick $+ 15) Oi! $smile(:D)
}

alias emotion {
  if ($dialog(emo)) { dialog -v emo }
  else { dialog -m emo emo }
}

on *:dialog:emo:sclick:4,5,8: {
  set %cor.boca $calc($did(emo,4).sel - 2)
  set %cor.olho $calc($did(emo,5).sel - 2)
  set %cor.fundo $calc($did(emo,8).sel - 2)
  if (%cor.boca == -1) { set %cor.boca 00 }
  if (%cor.olho == -1) { set %cor.boca 00 }
  if (%cor.fundo == -1) { set %cor.boca 00 }
  if ($len(%cor.boca) == 1) { set %cor.boca 0 $+ %cor.boca }
  if ($len(%cor.olho) == 1) { set %cor.olho 0 $+ %cor.olho }
  if ($len(%cor.fundo) == 1) { set %cor.fundo 0 $+ %cor.fundo }
  emo.prev
}

;; nc

alias nc { return $replace(%nickc,<mode>,$1,<nick>,$2) }

dialog nc {
  title "a.X - Nick Completation"
  size -1 -1 81 43
  option dbu
  box "Nick Completation", 1, 0 0 81 43, disable
  text "Formato:", 2, 2 8 25 8
  edit "", 3, 28 7 50 10, autohs
  text "Tags:", 4, 2 17 25 8
  combo 5, 29 17 49 50, size drop
  button "@nc", 6, 2 30 76 10
}

alias ncomp {
  if ($dialog(nc)) { dialog -v nc }
  else { dialog -m nc nc }
}

on *:dialog:nc:init:0: { 
  mdx.init
  mdx SetFont 1,2,3,4,5,6 11 250 tahoma
  mdx SetFont 1 11 800 tahoma
  mdx SetControlMDX 6 window > $mdx(dialog)
  did -a nc 5 <nick>
  did -a nc 5 <mode>
  did -c nc 5 1
  did -ar nc 3 %nickc
  window -ph @nc 1 1 300 30
  did -a nc 6 grab $window(@nc).hwnd @nc
  nc.prev 
  mdx SetDialog nc icon
}

alias nc.prev {   
  clear @nc
  drawtext -p @nc 1 tahoma 11 1 2 15(03@01 $+ $mnick $+ 15) $nc(@,$anick) oi!
}

on *:dialog:nc:edit:3: { set %nickc $did(nc,3) | nc.prev }

dialog pc {
  title "a.X - Painel de Controle"
  size -1 -1 170 109
  option dbu
  list 1, 1 1 168 107, size
}

alias pc {
  if ($dialog(pc)) { dialog -v pc }
  else { dialog -m pc pc }
}

on *:dialog:pc:*:*: { 
  if $devent == init {
    mdx.init
    mdx SetFont 1 11 250 Tahoma
    mdx SetControlMDX 1 ListView report rowselect single flat > $mdx(views)
    did -i $dname 1 1 headerdims 60 253
    did -i $dname 1 1 headertext Comando $chr(9) Descrição
    mdx SetDialog $dname icon
    .fopen pc $mircdirsys\db\pc.txt
    while (!$feof(pc)) {
      tokenize 44 $fread(pc)
      if ($1) did -a $dname 1 / $+ $1 $chr(9) $2
    }
    .fclose pc
  }
  if $devent == dclick && $did == 1 {
    $gettok($did($dname,1).seltext,6,32)
  }
}

dialog update {
  title "a.X - Update"
  size -1 -1 168 59
  option dbu
  edit "", 1, 0 2 167 39, read multi return vsbar
  box "", 2, -62 -36 234 80
  button "Ok", 3, 91 46 37 12, default ok
  button "Cancelar", 4, 130 46 37 12, cancel
}

on *:dialog:update:*:*: { 
  if $devent == init { 
    mdx.init
    did -ra $dname 1 $+(Uma nova versão do script está disponivel,$chr(44),$chr(32),deseja visitar a página de download?,$crlf,$crlf,Sua versão: $ver,$crlf,Versão atual: %new)
  }
  if $devent == sclick && $did == 3 { url http://xdvl.info/axtage/ } 
}
