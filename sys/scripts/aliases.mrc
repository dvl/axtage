;;
;; a.Xtage! - Advanced.Xtage
;; by: dvl <contato@xdvl.info>
;;

;; aliases

alias f2 {
  if ($status == connected) || ($status == connecting) { disconnect | halt }
  if ($status == disconnected) { server }
}

alias f3 { 
  if ($scid(0) == 1) && ($scid(1).status == disconnected) { aconn }
}

alias dummy { return }

;; dlls

alias mdx {
  if ($isid) { 
    if (!$1) { return $shortfn($mircdirsys\dll\mdx.dll) }
    if ($1) { return $shortfn($mircdirsys\dll\ $+ $1 $+ .mdx) }
  }
  if (!$isid) { dll $shortfn($mircdirsys\dll\mdx.dll) $1- }
}
alias mdx.init {
  mdx SetMircVersion $version
  mdx MarkDialog $dname
}

alias sys {
  if ($isid) { return $shortfn($mircdirsys $+ \ $+ $1) }
  if (!$isid) { run $shortfn($mircdirsys) }
}

;; dcx

alias dcx {
  if ($isid) returnex $dll($shortfn($mircdirsys\dll\dcx.dll),$1,$2-)
  else dll " $+ $shortfn($mircdirsys\dll\dcx.dll) $+ " $1 $2-
}

alias xdid {
  if ($isid) returnex $dcx(_xdid, $1 $2 $prop $3-)
  dcx xdid $2 $3 $1 $4-
}

alias xdialog {
  if ($isid) returnex $dcx(_xdialog, $1 $prop $2-)
  dcx xdialog $2 $1 $3-
}

alias xpop {
  if ($isid) returnex $dcx(_xpop, $1 $prop $2-)
  dcx xpop $2 $1 $3-
}

alias xpopup {
  if ($isid) returnex $dcx(_xpopup, $1 $prop $2-)
  dcx xpopup $2 $1 $3-
}

alias xmenubar {
  if ($isid) returnex $dcx(_xmenubar, $prop $1-)
  dcx xmenubar $1-
}

alias mpopup { dcx mpopup $1 $2 }

alias xdock {
  if ($isid) returnex $dcx(_xdock, $1 $prop $2-)
  dcx xdock $1-
}

alias xtray {
  if ($isid) returnex $dcx(TrayIcon, $1 $prop $2-)
  dcx TrayIcon $1-
}

alias xstatusbar {
  !if ($isid) returnex $dcx(_xstatusbar, mIRC $prop $1-)
  dcx xstatusbar $1-
}

alias xtreebar {
  !if ($isid) returnex $dcx(_xtreebar, mIRC $prop $1-)
  dcx xtreebar $1-
}

alias dcxml dcx dcxml $1-

alias tab {
  var %i = 1, %tab
  while (%i <= $0) {
    if ($eval($+($,%i),2) != $null) {
      %tab = $instok(%tab,$eval($+($,%i),2),$calc($numtok(%tab,9) + 1),9)
    }
    inc %i
  }
  return %tab
}

;; dcx end

alias fish { 
  if ($isid) { return $shortfn($mircdirfish_10.dll) }
  if (!$isid) { fishx }
}

alias fish_inject { 
  if ($isid) { return $shortfn($mircdirfish_inject.dll) }
  else { dll $shortfn($mircdirfish_inject.dll) $1- }
}

alias blow_ini { 
  if ($isid) { return $shortfn($mircdirsys\db\blow.ini) }
}

alias icon { return $1 $+ , $+ $sys $+ icons\ $+ %iconpack $+ .icl }

alias getram  { 
  if (!$IsWine) { 
    var %moo.rammax = $mooi(rammax) 
    var %moo.ramuse = $mooi(ramuse) 
    return $moos($1) $+($round($calc(%moo.rammax - %moo.ramuse),0),/,%moo.rammax,MB) $+($chr(40),$round($calc((%moo.rammax - %moo.ramuse) / %moo.rammax * 100),2),%,$chr(41))
  }
  else { return Unavaliable }
}

alias id { nickserv identify $1- }
alias cs { chanserv $1- }
alias ns { nickserv $1- }
alias ms { memoserv $1- }
alias os { operserv $1- }
alias bs { botserv $1- }
alias hs { msg hostserv $1- }

alias info {
  if (!$1) { raw -q info }
  elseif ($left($1,1) == $chr(35)) { chanserv info $1 }
  else { nickserv info $1 } 
}

alias im { chanserv invite $iif($1,$1,$active) | .timer 1 1 !join $iif($1,$1,$active) }
alias um { chanserv unban $iif($1,$1,$active) }

alias f9 { echo -a $m pedido de 03@01op no # enviado ao chanserv | cs op # $me }
alias f10 { echo -a $m pedido de 03@01deop no # enviado ao chanserv | cs deop # $me }
alias f11 { echo -a $m pedido de 03+01voice no # enviado ao chanserv | cs voice # $me }
alias f12 { echo -a $m pedido de 03+01devoice no # enviado ao chanserv | cs devoice  # $me }
alias w { whois $1- }
alias chat { dcc chat $1 }
alias send { dcc send $1 }
alias away { 
  if ($away) { 
    scon -a raw -q away 
    ;scon -a ame back; $awaymsg duration; $gmt($awaytime,HH:nn:ss) 
  }
  else { 
    scon -a raw -q away : $iif(!$1-,n/a,$1-) 
    ;scon -a ame away; $iif(!$1-,n/a,$1-) 
  } 
}
alias back {
  if ($away) { 
    scon -a raw -q away 
    ;scon -a ame back; $awaymsg duration; $gmt($awaytime,HH:nn:ss) 
  }
}
alias info {
  if (!$1) { raw -q info | halt }
  if ($left($1,1) == $chr(35)) { chanserv info $1- }
  else { nickserv info $1- }
}
alias m { return 1—03›01 }
alias logo { return 3» 01a03.01Xtage03!01 }
alias ver { return 1.17 }
alias vercomp { return beta }
alias j { join $1- }
alias join { !join #$1 $2 }
alias p { join $1- }
alias part { !part #$1 }
alias s { server $1- }
alias quit { !quit 01 $+ $1- $logo }
alias k { inc %kick | kick # $1 $iif($2,$2-,$read($shortfn($mircdirsys\db\kicks.txt))) 3(01n03:01 %kick $+ 3) } 
alias op { mode # +ooo $1 $2 $3 }
alias deop { mode # -ooo $1 $2 $3 }
alias deop2 { mode # +v $1 | mode # -o $1 }
alias halfop { mode # +hhh $1 $2 $3 }
alias dehalfop { mode # -hhh $1 $2 $3 }
alias voice { mode # +vvv $1 $2 $3 }
alias devoice { mode # -vvv $1 $2 $3 }
alias kb { inc %kick | ban $1 2 | kick # $1 $iif($2,$2-,$read($shortfn($mircdirsys\db\kicks.txt))) 3(01banned n03:01 %kick $+ 3) }
alias b { ban $1 4 }

alias sendkeys {
  var %object = sendkeys $+ $ticks
  .comopen %object WScript.Shell
  if ($com(%object)) { .comclose %object $com(%object,SendKeys,3,bstr,$1-) }
}

alias mopt { sendkeys $+($chr(37),o) }

alias changeday {
  var %i = $scon(0)
  while (%i) {
    scid $scon(%i)
    var %w = $window(*,0)
    while (%w) {
      var %t = ""
      if ($istok(channel query chat,$window(*,%w).type,32)) { %t = $window(*,%w) }
      elseif ($window(*,%w).type == status) { %t = -s }
      if (%t) { echo %t $m Novo dia se iniciando03:01 $dia $+ 03,01 $asctime(d) de $mes de $asctime(yyyy) $+ 03. }
      dec %w
    }
    dec %i
  }
  .timerdcre 1 300 .timerdc -io 00:00 1 0 changeday
}

alias mes { return $replace($iif($1,$1,$date(m)),10,Outubro,11,Novembro,12,Dezembro,1,Janeiro,2,Fevereiro,3,Março,4,Abril,5,Maio,6,Junho,7,Julho,8,Agosto,9,Setembro) }
alias dia { return $replace($iif($1,$1,$date(ddd)),sun,Domingo,mon,Segunda,tue,Terça-Feira,wed,Quarta-Feira,thu,Quinta-Feira,fri,Sexta-Feira,sat,Sábado) }

alias tip {
  ;; /tip -ntdipaw [name] [title] [delay] [icone] [iconpos] [alias] [wid] <texto>
  var %par = $1-,%name = mIRC,%title = Aviso,%delay,%iconfn,%iconpos,%alias,%wid
  if ($left($1,1) = -) {
    %par = $2-
    if (n isin $1) { %name = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (t isin $1) { %title = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (d isin $1) { %delay = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (i isin $1) { %iconfn = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (p isin $1) { %iconpos = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (a isin $1) { %alias = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
    if (w isin $1) { %wid = $gettok(%par,1,32) | %par = $gettok(%par,2-,32) }
  }
  if (!$tip(%name,%title,%par,%delay,%iconfn,%iconpos,%alias,%wid)) echo erro
}

alias IsWine {
  .comopen winetest WbemScripting.SWbemLocator
  if ($com(winetest)) { .comclose winetest }
  return $comerr
}

alias urlcolor {
  var %input = $1-
  .echo -q $regsub(%input,/((?:ftp:\/\/|https?:\/\/|www2?\.)[^<>\.\s]+(?:\.[^<>\.\s]+)+(?:\/[^<>\.\s]+)*)/g,2\1,%input)
  .echo -q $regsub(%input,/(irc:\/\/[^<>\.\s]+(?:\.[^/<>\.\s]+)+(?:\/[^/<>\.\s]*)?\/?(?![^\s\x2c\.]))/g,2\1,%input)
  .echo -q $regsub(%input,/(aim:goim\?screenname=[^\s&]+(?:&message=[^\s&=]+)?)/g,2\1,%input)
  return %input
}

alias smile {
  return $regsubex($1-,/(\s|^)([:=x;>])([DXPG{*BO$#&}T(~|)S@\]\/\[]+)(\s|$)/g,$+(\01,$chr(3),%cor.olho,$chr(44),%cor.fundo,\02,$chr(3),%cor.boca,\03,%cor.suf,$chr(15),\04))
}
