;;
;; a.Xtage! - Advanced.Xtage
;; by: dvl <contato@xdvl.info>
;;

;; eventos e raws

on *:start: {
  var %tks $ticks
  if ($version < 7) { echo -s 04- Erro: Você precisa usar o mIRC 7 ou superior para esse script funcionar corretamente. | halt }
  set %lag 0
  .timestamp -ef $remove(%timestamp,*)
  if (%toolbar == on) { tb }
  if (%statusbar == on) { statusbar }
  .timer 1 0 .window -x "Status Window"
  .timerdc -io 0:00 1 0 changeday
  ;dcx WindowProps $window(-2).hwnd +t a.Xtage!
  ;dcx WindowProps $window(-2).hwnd +i 2 $remove($icon,$chr(44))
  if (!$IsWine) { 
    set %blow_ini $blow_ini | set %fish_dll $fish
    fish_inject _callMe
    dll $fish FiSH_SetIniPath $blow_ini
    clear
  }
  if ($IsWine) && ($script(fish_10.mrc)) { .unload -rs $script(fish_10.mrc) }
  echo -s $logo v $+ $ver
  echo -s 03- 01carregado em03 $calc(($ticks - %tks)/1000) 01segs03.
  echo -s 03- 01Último servidor03:01 $gettok($readini($mircini,mirc,host),2,58) $+ 03,01 aperte 03F201 para se conectar a ele03.
  if (%autoconn == 1) { aconn }
  if (%autoconn == 0) && ($lines($mircdirsys\db\autoconn.txt) > 0) { echo -s 03- 01Auto-connect desligado03,01 aperte 03F301 para se conectar aos servidores configurados03. }
}

on ^*:join:#: {
  haltdef
  if ($nick == $me) {
    echo -t # $m 01entrando no03; $replace($chan,$chr(35),03 $+ $chr(35) $+ 01) 
  }
  else {
    echo -t # $m 01entrou03:01 $nick 15(01 $+ $replace($address,.,03.01,@,03@01) $+ 15)
    if ($ial($address($nick,2),0) > 1) { echo -t # $m 01clones03:01 $clones($nick) 15(01 $+ $ial($address($nick,2),0) 15=01 $replace($address($nick,2),.,03.01,@,03@01) $+ 15) }
  }
}

alias j.status { echo -t $1 $m status03: 03@01Ops03(01 $+ $nick($1,0,o) $+ 03) 03+01Voices03(01 $+ $nick($1,0,v) $+ 03) 01Normal03(01 $+ $nick($1,0,r) $+ 03) 01Total03(01 $+ $nick($1,0) $+ 03) }

alias clones {
  var %x 1
  while ($ial($address($1,2),%x).nick) { 
    var %clones %clones $v1
    inc %x 
  }
  var %y 1
  while (%y <= $numtok(%clones,32)) {
    var %clones2 %clones2 $+ $iif(%y != 1,03 $+ $iif(%y == $numtok(%clones,32),$chr(32) $+ 01e,$chr(44)) $+ 01) $gettok(%clones,%y,32)
    inc %y
  }
  return %clones2
}

on ^*:part:#: { 
  haltdef
  if ($nick == $me) {  echo -t # $m você saiu do $replace($chan,$chr(35),03 $+ $chr(35) $+ 01) }
  else { echo -t # $m saiu03:01 $nick 15(01 $+ $replace($address,.,03.01,@,03@01) $+ 15) }
}

on ^*:notify: {
  haltdef 
  echo -st $m está no irc03:01 $nick 15(01 $+ $replace($address,.,03.01,@,03@01) $+ 15) 15(01nota3;01 $iif($notify($nick).note,$notify($nick).note,n/a) $+ 15)
}

on ^*:unotify: {
  haltdef
  echo -st $m saiu do irc03:01 $nick 15(01 $+ $replace($address,.,03.01,@,03@01) $+ 15) 15(01nota3;01 $iif($notify($nick).note,$notify($nick).note,n/a) $+ 15)
}

on ^*:NICK: {
  if ($nick == $me) { echo -st $m você mudou o nick para03:01 $newnick }
  var %nicker 0
  :porra
  inc %nicker 1
  if ($chan(%nicker) == $null) { unset %nicker | halt }
  if ($nick == $me) { echo -t $chan(%nicker) $m nick03:01 $nick mudou o nick para03:01 $newnick | goto porra }
  if ($newnick ison $chan(%nicker)) { echo -t $chan(%nicker) $m nick03:01 $nick mudou o nick para03:01 $newnick | goto porra }
  else { goto porra }
}

on ^*:rawmode:#: { haltdef | echo -t # $m $nick 01definiu o modo03:01 $replace($1-,+,03+01,-,03-01,@,03@01) }
on ^*:usermode: { haltdef | echo -ts $m você definiu o modo03:01 $replace($1-,+,03+01,-,03-01) }
on ^*:snotice:*: { haltdef | echo -ts 15(03!01 $+ $replace($nick,.,03.01) $+ 15)01 $iif($1 == ***,$replace($1-,***,$m $+ $chr(32)),$1-) }

on ^*:quit: { 
  haltdef 
  var %x 1 
  while (%x <= $comchan($nick,0)) { echo -t $comchan($nick,%x) $m quit03:01 $nick 15(01 $+ $1- $+ 15) | inc %x } 
}

on ^*:topic:*: { echo -t $chan $m $nick mudou o tópico para03:01 $1- | halt }

on ^*:notice:*:*: {
  haltdef
  if ($right($nick,4) == serv) { echo -st 15(03@01 $+ $nick $+ 15)01 $1- | halt }
  var %x 1
  if ($comchan($nick,0)) {
    while (%x <= $comchan($nick,0)) {
      echo -t $comchan($nick,%x) 15(01notice15/01 $+ $nick $+ $iif($chan,15:01 $+ $chan) $+ 15)01 $1- 
      inc %x 
    } 
  }
  if ($query($nick)) { echo -t $nick 15(01notice15/01 $+ $nick $+ $iif($chan,15:01 $+ $chan) $+ 15)01 $1-  }
  echo -st 15(01notice15/01 $+ $nick $+ $iif($chan,15:01 $+ $chan) $+ 15)01 $1- 
}

on *:input:*: {
  if ($left($1,1) === $readini($mircini,text,commandchar)) && (!$ctrlenter) && (!$inpaste) { return }

  inc %ac.cont
  inc %ac.len $len($1-)
  if ($regex($1-,/(lo+l)/g) >= 1) { inc %ac.lol $regml(0) }

  if (%mark_outgoing == [On]) && ($readini($blow_ini,FiSH,process_outgoing) == 1) { var %tmp1 $readini($blow_ini,FiSH,mark_encrypted_out) }

  if ($right($1,1) isin %ativadores) && ($target == #) && ($remove($1,$right($1,1)) ison $chan) {
    var %xnick $remove($1,$right($1,1))
    var %msg = $nc($remove($nick(#,%xnick).pnick,%xnick),%xnick) $+  $ac($urlcolor($smile($2-)))
  }
  else { var %msg = $ac($smile($urlcolor($smile($1-)))) }

  if (c isin $chan($active).mode) || ($ctrlenter) || ($left($1,1) isin .!@) || ($inpaste) { var %msg = $strip($1-) }

  echo -t $target $replace(%bracket,*modo,$remove($nick(#,$me).pnick,$me),*nick,$me) $+  %msg %tmp1
  if ($window($target).type != status) { .msg $target %msg } 
  halt
}

on ^*:text:*:#: { 
  haltdef
  if ($me isin $strip($1-)) { 
    if (!$away) { .beep 1 1 | .flash }
    if ($away) {
      if (!$window(@log)) { window -e @log }
      aline @log $timestamp $m  $+ $nick chamou você no $replace($chan,$chr(35),03#01) 15(01 $+ $1- $+ 15)
    }
    if ($active != $chan) && ($active != @log) { echo -at $m  $+ $nick chamou você no $replace($chan,$chr(35),03#01) 15(01 $+ $1- $+ 15) } 
    if (%tooltip == on) && (!$away) && ($nick != SaintSeiya) { 
      if ($active != $iif($chan,$chan,$nick)) || (!$appactive) { tip $nick chamou você no $chan ( $+ $1- $+ ) }
    }
    window -g2 $chan
  }
  echo -t # $replace(%bracket,*modo,$remove($nick(#,$nick).pnick,$nick),*nick,$nick) 01 $+ $1-
}

on ^*:text:*:?: {
  haltdef
  if ($me isin $strip($1-)) { .beep 1 1 | .flash }
  echo -t $nick $replace(%bracket,*modo,$remove($nick(#,$nick).pnick,$nick),*nick,$nick) 01 $+ $1-
}

on ^*:chat:*: {
  haltdef 
  echo -t =$nick $replace(%bracket,*modo,$remove($nick(#,$nick).pnick,$nick),*nick,$nick) 01 $+ $1-
}

on ^*:invite:*: { haltdef | echo -st $m Invite03:01 você foi convidado para entrar no $replace($chan,$chr(35),03 $+ $chr(35) $+ 01) por03:01 $nick }

on ^*:kick:#:{
  if ($knick == $me) { 
    echo -t $chan $m você foi kickado do $replace($chan,$chr(35),03 $+ $chr(35) $+ 01) 01por03:01 $nick 15(01 $+ $1- $+ 15)
    echo -st $m você foi kickado do $replace($chan,$chr(35),03 $+ $chr(35) $+ 01) 01por03:01 $nick 15(01 $+ $1- $+ 15)
    halt
  }
  else { echo -t $chan $m $nick kickou03:01 $knick 15(01 $+ $1- $+ 15) | halt }
}

ctcp ^*:*: {
  if ($1 == VERSION) { haltdef | .ctcpreply $nick VERSION a.Xtage! $ver - by: dvl }
}

on *:connect: { 
  echo -st $m conectado ao servidor03:01 $server com o nick03:01 $nick
  conbtn
  if (%last.check != $date(ddmm)) { check | set %last.check $date(ddmm) }
}

;; raws

raw *:*: { 
  ;; echo -a $1- 15(01Raw nº03:01 $numeric $+ 15) | halt
  if ($numeric == 311) {
    echo -at $m Whois de03:01 $2
    echo -at 01 Nome03:01 $6- 
    echo -at 01 Host03:01 $3 $+ 03@01 $+ $replace($4,.,03.01)
    set %whois.on on
    halt
  }
  if ($numeric == 319) { echo -at 01 Canais03:01 $replace($3-,@,03@01,+,03+01) | halt }
  if ($numeric == 312) { echo -at 01 Servidor03: $replace($3,.,03.01) 15(01 $+ $4- $+ 15) | halt }
  if ($numeric == 313) { set %whois.extra %whois.extra 01IRCop 15(01 $+ $lower($5-) $+ 15)03; | halt }
  if ($numeric == 317) { echo -at 01 Idle03:01 $duration($3) | echo -at 01 Conectou03:01 $asctime($4, dd/mm/yyyy) 03@01 $asctime($4, hh:nn:ss) | halt }
  if ($numeric == 318)  {
    if ($ial($address($2,2),0) > 1) { echo -at 01 Clones03:01 $clones($2) 15(01 $+ $ial($address($2,2),0) 15=01 $replace($address($2,2),.,03.01,@,03@01) $+ 15) }
    if (%whois.extra) { echo -at 01 Outros03:01 %whois.extra }
    echo -at $m Fim do whois | unset %whois.*
    halt
  }
  if ($numeric == 381) { echo -st $m Agora você é um IRCop03! | halt }
  if ($numeric == 301) {
    if (%whois.on == on) { echo -at 01 Away03:01 $3- | halt }
    halt 
  }
  if ($numeric == 307) { set %whois.extra %whois.extra 01 Registrado03; | halt }
  if ($numeric == 332) { echo -t $2 $m Tópico03:01 $3- | halt }
  if ($numeric == 333) { echo -t $2 $m Por03:01 $3 01Em03:01 $asctime($4,dd/mm/yyyy) 03@01 $asctime($4,HH:nn:ss) | halt }
  if ($numeric == 471) || ($numeric == 473) || ($numeric == 475) { echo -st $m impossivel entrar no03:01 $replace($2,$chr(35),03 $+ $chr(35) $+ 01) $replace($6,$chr(40),15 $+ $chr(40) $+ ,$chr(41),15 $+ $chr(41) $+ ,+,03+01) | halt }
  if ($numeric == 404) { echo -st $m Impossivel enviar mensagens para o03:01 $replace($2,$chr(35),03 $+ $chr(35) $+ ) $replace($7-,$chr(40),15 $+ $chr(40) $+ 01,$chr(41),15 $+ $chr(41) $+ ,$chr(44),03 $+ $chr(44) $+ 01) | halt }
  if ($numeric == 405) { echo -st $m Impossivel entrar no03:01 $replace($2,$chr(35),03 $+ $chr(35) $+ 01) 15(01você já está em $chan(0) 01canais15) | halt }
  if ($numeric == 437) { echo -st $m Impossivel mudar de nick enquanto banido ou moderado no canal $replace($2,$chr(35),03 $+ $chr(35) $+ 01) | halt }
  if ($numeric == 472) { echo -st $m Modo 03+01u desconhecido | halt }
  if ($numeric == 501) { echo -st $m Modo desconhecido | halt }
  if ($numeric == 308) || ($numeric == 378) { echo -at 01 IP03:01 $gettok($6,2,64) 15(01 $+ $7 $+ 15) | halt }
  if ($numeric == 338) { echo -at 01 IP03:01 $gettok($5,2,64) 15(01 $+ $remove($6,[,]) $+ 15) | halt }
  if ($numeric == 616) { echo -at 01 IP03:01 $5 15(01 $+ $6 $+ 15) | halt }
  if ($numeric == 671) || ($numeric == 275) { set %whois.extra %whois.extra 01SSL03; | halt }
  if ($numeric == 379) { echo -at 01 Modos03:01 $replace($6,+,03+01) | halt } ;; unrealircd
  if ($numeric == 310) { 
    if ($network == Rizon) { echo -at 01 Modos03:01 $replace($6,+,03+01) }
    else { set %whois.extra %whois.extra 01 Helper03; }
    halt 
  }
  if ($numeric == 320) { set %whois.extra %whois.extra 01 VIP03; | halt }
  if ($numeric == 330) { echo -at 01 Logado como03:01 $3 | halt } ;; inspircd
  if ($numeric == 366) { .timerjoinself -m 1 1 j.status $2 | halt }
  if ($numeric == 433) { echo -st $m erro03:01 o nick $2 já esta em uso03! | ;;ghost $2 | halt }
  if ($numeric == 314) { echo -at 01  $+ $2 esteve conectado com o host $3 $+ 03@01 $+ $4 15(01 $+ $6- $+ 15) | halt }
  if ($numeric == 369) { halt }
  if ($numeric == 305) { echo -st $m Você não está mais away03! | halt } 
  if ($numeric == 306) { echo -st $m Você agora está away03! | halt }
  if ($numeric == 421) { echo -st $m Comando / $+ $lower($2) $+  invalido ou inexistente03! | halt }
  if ($numeric == 251) || ($numeric == 265) { linesep | echo -st $m $regsubex($iif($network == rizon,$4-,$2-),/([0-9]+)/g,\1)  | halt }
  if ($numeric == 252) || ($numeric == 253) || ($numeric == 254) || ($numeric == 255) { echo -st $m $regsubex($2-,/([0-9]+)/g,\1) | halt }
  if ($numeric == 266) { echo -st $m $regsubex($iif($network == rizon,$4-,$2-),/([0-9]+)/g,\1) | linesep | halt }
  if ($numeric == 401) { echo -st $m Nick não encontrado03;01 $2 | halt }
  if ($numeric == 615) { echo -at 01 Modos03:01 $replace($6,+,03+01) | halt }
}

;; dns

on *:dns: {
  if ($dns(0)) {
    var %n $dns(0)
    while (%n > 0) { 
      echo -s $m $dns(%n) 03-15>01 $iif($gettok($dns(%n),1,46) isnum, $dns(%n).addr, $dns(%n).ip) 
      if ($iptype($dns(%n).ip) == ipv4) { $ip2($dns(%n).ip) }
      dec %n 
    }
  }
  else { echo -s $m impossivel resolver o host03:01 $address }
  linesep
}

alias dns { linesep | .dns $1- | echo -s $m Resolvendo DNS03:01 $1 }

alias sw { sockwrite -nt $sockname $1- }

alias -l ip2 {
  var %x = $+(ip2.,$rand(10000,99999))
  while ($sock(%x)) %x = $+(ip2.,$rand(10000,99999))
  sockopen %x ipinfodb.com 80
  sockmark %x $1
}

alias ip2l { $ip2($1) }

on *:sockopen:ip2.*: {
  sw GET $+(http://ipinfodb.com/ip_query.php?ip=,$sock($sockname).mark) HTTP/1.1
  sw Host: ipinfodb.com
  sw User-Agent: mIRC $version [a.Xtage!]
  sw
}

on *:sockread:ip2.*: {
  if ($sockerr) { echo -s $m Erro ao obter a localização do IP | halt }
  sockread %xml
  while ($sockbr != 0) { 
    if ($regex(%xml,<Ip>(.*)<\/Ip>)) { var %ip2.ip $regml(1) } 
    if ($regex(%xml,<CountryName>(.*)<\/CountryName>)) { var %ip2.pais $regml(1) } 
    if ($regex(%xml,<CountryCode>(.*)<\/CountryCode>)) { var %ip2.cc $regml(1) } 
    if ($regex(%xml,<RegionName>(.*)<\/RegionName>)) && ($regml(1)) { var %ip2.reg $regml(1) }
    if ($regex(%xml,<City>(.*)<\/City>)) && ($regml(1)) { var %ip2.city $regml(1) } 
    sockread %xml
  }
  echo -s $m IP03:01 %ip2.ip
  echo -s $m Pais03:01 %ip2.pais 15(01 $+ %ip2.cc $+ 15)
  echo -s $m Cidade03:01 $iif(%ip2.city,%ip2.city,Deconhecida) $+ $iif(%ip2.reg && %ip2.reg != %ip2.city,$+($chr(44),$chr(32),%ip2.reg))
  linesep
}

;; update

alias check {
  var %x = $+(check.,$rand(10000,99999))
  while ($sock(%x)) %x = $+(check.,$rand(10000,99999))
  sockopen %x xdvl.info 80
}

on *:sockopen:check.*:  { 
  sw GET /axtage/version.xml HTTP/1.1
  sw Host: xdvl.info
  sw User-Agent: a.Xtage! $ver
  sw
} 

on *:sockread:check.*: { 
  if ($sockerr) { halt }
  sockread %check
  if ($regex(%check,<version>(.*)<\/version>) && ($regml(1) > $ver)) { 
    set -u10 %new $regml(1)
    dialog -m update update
  }
}
