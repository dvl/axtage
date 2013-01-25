;;
;; a.Xtage! - Advanced.Xtage
;; by: dvl <contato@xdvl.info>
;;

;; statusbar

alias statusbar {
  if ($xstatusbar().visible) { xstatusbar -A 0 | .timersbar* off | halt }
  xstatusbar -A 1 notheme
  xstatusbar -l 25% 15% 24% 27% -1
  xstatusbar -y
  xstatusbar -w + $replace($icon(14),$chr(44),$chr(32))
  xstatusbar -w + $replace($icon(15),$chr(44),$chr(32))
  xstatusbar -w + $replace($icon(5),$chr(44),$chr(32))
  xstatusbar -w + $replace($icon(10),$chr(44),$chr(32))
  xstatusbar -w + $replace($icon(21),$chr(44),$chr(32))
  sb.cells | sb.cells.ram
  .timersbar -io 0 1 sb.cells
  .timersbar.ram -io 0 300 sb.cells.ram
  .timersbar.lag -io 0 30 lag
}

alias sb.cells {
  xstatusbar -t 1 + 1 Server: $iif($server,$scid($activecid).server,Desconectado) (lag: %lag $+ ms)  
  xstatusbar -t 2 + 2 Nick: $scid($activecid).me $chr(91) $+ $scid($activecid).usermode - f. $+ $replace($readini($blow_ini,FiSH,process_outgoing),1,on,0,off) $+ / $+ $replace($readini($blow_ini,FiSH,process_incoming),1,on,0,off) $+ ]
  xstatusbar -t 3 + 3 System: $duration($Uptime(system,3),3) mIRC: $duration($Uptime(mirc,3),3) Server: $duration($Uptime(server,3),3)
  xstatusbar -t 4 + 4 Clipboard: $chr(91) $+ $cb(0) $+ l/ $+ $bytes($cb(0).len,b).suf $+ ] - $cbc
}

alias sb.cells.ram { xstatusbar -t 5 + 5 Ram: $getram }

alias cbc {
  var %c = 1
  while (%c <= $iif($cb(0) > 5,5,$cb(0))) {
    var %cc %cc $+ $cb(%c) $+ \n
    inc %c
  }
  return %cc
}

alias lag { 
  if ($status == connected) { .ctcp $me lag $ticks }
  else { set %lag 0 }
}

ctcp ^*:lag: {
  haltdef
  if ($nick == $me) { set %lag $calc($ticks - $2) | halt }
}

;; toolbar

alias tb {
  toolbar -c
  toolbar -az2n6k0 btn0 "Conectar/Desconectar" $mircdirsys\icons\Defaut.icl /tbcon
  toolbar -az2s sep0
  var %t = 1
  .fopen tb $mircdirsys\db\tb.txt
  while (!$feof(tb)) {
    tokenize 44 $fread(tb)
    if ($1 != $null) { 
      if ($1 == -) { toolbar -az2sx sep $+ %t }
      else {
        toolbar -az2n $+ $4 btn $+ %t $qt($1) $qt($mircdirsys\icons\Defaut.icl) $qt(/ $+ $replace($2,",')) $iif($3 != 0,$qt($3))
      }
    }
    inc %t
  }
  .fclose tb
  conbtn
}

alias tbcon { 
  if ($status == connected) || ($status == connecting) { disconnect | conbtn | halt }
  if ($status == disconnected) { server | conbtn | halt } 
}

on ^*:logon:*: { conbtn }
on *:connectfail: { conbtn }
on *:disconnect: { conbtn }
on *:active:*: { if ($cid != $lactivecid) { conbtn } }

alias conbtn {
  if ($status != disconnected) { toolbar -k1pn9 btn0 $qt($mircdirsys\icons\Defaut.icl) }
  else { toolbar -k0pn6 btn0 $qt($mircdirsys\icons\Defaut.icl) }
}
