# Huboco

<a href="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/icon.png">
  <img src="/../master/icon.png" width="200px" height="auto">
</a>
<br>

Huboco(ひゅぼ子)は、Hubot製のチャットボットです。
<br>
研究室のチャットルームでの利用を目的に、研究のお手伝いができるよう開発中です。
<br>
以下、簡単な機能紹介。(実装順)

## Commands

- <tt>scripts/ping.coffee</tt>
  - <tt>ping [ip_address]:[port]</tt>：サーバにpingする。(<tt>cli/ping.rb</tt>)
- <tt>scripts/huboco.coffee</tt>
  - <tt>hello</tt>：時間に応じた挨拶をする。
  - <tt>version</tt>：Hubotのバージョンを返す。
  - <tt>date</tt>：日付と時間を返す。
  - <tt>time</tt>：時間を返す。
- <tt>scripts/help.coffee</tt>
  - <tt>help</tt>：コマンドの一覧を返す。
- <tt>scripts/anime.coffee</tt>
  - <tt>anime</tt>：今期放送中のアニメの一覧を返す。
  - <tt>anime today</tt>：今日放送のアニメの一覧を返す。
  - <tt>anime search [title]</tt>：今期のアニメをタイトルで検索する。
- <tt>scripts/member.coffee</tt>
  - <tt>member</tt>：Typetalkのトピックメンバー全員を返す。
  - <tt>who</tt>：メンバーの中からランダムに1人選び、お願いリプライを送る。

## URLS

- <tt>scripts/httpd.coffee</tt>
  - <tt>GET /huboco/info</tt>：Hubocoの紹介ページを表示。
  - <tt>POST /huboco/ping</tt>：PONG。

## SpecialThanks

- 「[情報共有ツールの情報共有 | JANOG34 Meeting](http://www.janog.gr.jp/meeting/janog34/program/itool.html)」への参加をキッカケに開発を開始しました。
- アイコンは「[In Spirited We Love Icon Se by Raindropmemory](http://raindropmemory.deviantart.com/art/In-Spirited-We-Love-Icon-Set-Repost-304014435)」を使っています。
