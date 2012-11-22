# -*- coding: utf-8 -*-
require 'irc-socket'

server, port, nick, user = ARGV

irc=IRCSocket.new( server, port )
irc.connect
if irc.connected?
  irc.pass "hoge" # NICK/USER の前に PASS が必須。サーバーに PASS 設定がなくても、適当な文字列を送信しないと認証されない。
  irc.nick nick
  irc.user user, 0, "*", "Mr.${user}" # ユーザー名、ホスト名、サーバー名、リアルネームの順
  irc.join "#hoge" # チャンネル #hoge へ入室
  while line=irc.read
    irc.pong server if line.split[0] == "PING"
    puts line if line.split[1] == "PRIVMSG"
  end
end
