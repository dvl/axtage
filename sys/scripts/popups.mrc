;;
;; a.Xtage! - Advanced.Xtage
;; by: dvl <contato@xdvl.info>
;;

menu status { 
  Conectar:server $$input(Servidor:,129,Conectar,irc.cdzforever.net) 
  -
  Ver log:logview $mklogfn(status)
  -
}

menu nicklist {
  Whois:whois $1
  -
  Controle
  .Dar Op:op $1
  .Tirar Op:deop $1
  .-
  .Dar Halfop:halfop $1
  .Tirar Halfop:dehalfop $1
  .-
  .Dar Voice:voice $1
  .Tirar Voice:devoice $1
  .-
  .Tirar Op e dar Voice:deop2 $1
  -
  Kick/Ban
  .Kick
  ..Kick Randomico:k $1
  ..Kick Motivo:k $1 $$?="Motivo"
  .KickBan
  ..KickBan Randomico:kb $1
  ..KickBan Motivo:kb $1 $$?="Motivo"
  .-
  .Ban:ban # $1 4
  -
  CTCP
  .Version:ctcp $1 VERSION
  .Time:ctcp $1 TIME
  .Finger:ctcp $1 FINGER
  .Ping:ctcp $1 PING
  .-
  .Outro:ctcp $1 $$?="CTCP"
  DCC
  .Chat:dcc chat $1
  .Send:dcc send $1
  -
  Notify
  .Adicionar:notify $1
  .Deletar:notify -r $1
  Ignore
  .Adicionar:ignore $1
  .Deletar:ignore -r $1
  -
  Chanserv
  .Controle
  ..Op
  ...Dar Op:cs op # $1
  ...Tirar Op:cs deop # $1
  ..Voice 
  ...Dar Voice:cs voice # $1
  ...Tirar Voice:cs devoice # $1
  .-
  .Access
  ..Adicionar:cs access # add $1 $$?="Level"
  ..Deletar:cs access # del $1
  .Akick
  ..Adicionar:cs akick # add $1 $?="Motivo (Opcional)"
  Nickserv
  .Info:ns info $1
  .Ghost:ns ghost $1 $$?="Senha"
  .Regain:ns regain $1 $$?="Senha"
  Memoserv
  .Send:ms send $1 $$?="Mensagem"
  -
}

menu menubar {
  Opções
  .Auto Join:autojoin
  .Auto Identify:autoid
  .Auto Connect:autoconn
  .-
  .Bracket e Timestamp:bes
  .Pasta de Canais:chan
  Exibir
  .$iif($xstatusbar().visible,$style(1),$style(0)) Statusbar:statusbar
  .$iif($toolbar,$style(1),$style(0)) Toolbar:.toolbar $iif($toolbar,off,on)
  -
  Escrita
  .Auto Cor:autocor
  .Nick Comp:ncomp
  .Emotion:emotion
  Editar
  .Quits:run $shortfn($mircdirsys\db\quits.txt)
  -
  Away
  .$iif(!$away,$style(0),$style(2)) Entrar:away $?"Motivo: $crlf Exemplo: Jogando"
  .$iif($away,$style(0),$style(2)) Voltar:away
  -  
  Pastas
  .Logs:run $mircdirsys\logs
  .Download:run $getdir
  .Pasta do Script:run $mircdir
  -
}

menu query {
  Whois:whois $1
  -
  CTCP
  .Version:ctcp $1 VERSION
  .Time:ctcp $1 TIME
  .Finger:ctcp $1 FINGER
  .Ping:ctcp $1 PING
  .-
  .Outro:ctcp $1 $$?="CTCP"
  DCC
  .Chat:dcc chat $1
  .Send:dcc send $1
  -
  Notify
  .Adicionar:notify $1
  .Deletar:notify -r $1
  Ignore
  .Adicionar:ignore $1
  .Deletar:ignore -r $1
  -
  Nickserv
  .Info:ns info $1
  .Ghost:ns ghost $1 $$?="Senha"
  .Release:ns release $1  $$?="Senha"
  Memoserv
  .Send:ms send $1 $$?="Mensagem"
  -
  Ver log:logview $mklogfn($1)
  -
}

menu channel { 
  Who:who $chan
  -
  Chanserv
  .Informações:cs info $chan
  .Registrar:cs register $chan $$?="Senha" $$?="Descrição"
  .Identify:cs identify $chan $$?="Senha"
  -
  Ver log:logview $mklogfn($chan)
  -
}
