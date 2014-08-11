# Huboco

<a href="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/icon.png">
  <img src="/../master/icon.png" width="200px" height="auto">
</a>
<br>

Huboco(ひゅぼ子)は、Hubot製のチャットボットです。
<br>
研究室のチャットルームでの利用を目的に、研究のお手伝いができるよう開発中です。

## Install

Ubuntu 12.04での簡単な導入説明。
<br>
一部でRubyを使っているので、Rubyもインストールします。

    $ sudo add-apt-repository ppa:chris-lea/node.js
    $ sudo apt-get update
    $ sudo apt-get install nodejs redis-server ruby
    $ sudo gem install bundler --no-ri --no-rdoc
    $ sudo npm install -g hubot coffee-script
    $ git clone git://github.com/hico-horiuchi/huboco.git
    $ cd huboco
    $ bundle install
    $ cp bin/huboco.sample bin/huboco
    $ bin/huboco

## Adapter

以下を参考に、Adapterに応じて<tt>bin/huboco</tt>に設定を追加して下さい。

- Typetalk
  - [Typetalkでhubotを使う手順 | QUARTET TechBlog](http://tech.quartetcom.co.jp/2014/06/07/338)
- HipChat
  - [Hubotをインストール、hipchatと連携し、foreverでデーモン化(CentOS6.4) - コンユウメモ)](http://konyu.hatenablog.com/entry/2014/05/13/214812)

## Commands

<table>
  <thead></thead>
  <tbody>
    <tr>
      <td><tt>ping.coffee</tt></td>
      <td><tt>ping [ip_address]:[port]</tt></td>
      <td>サーバにpingする (<tt>cli/ping.rb</tt>)</td>
    </tr>
    <tr>
      <td rowspan="4"><tt>huboco.coffee</tt></td>
      <td><tt>hello</tt></td>
      <td>時間に応じた挨拶をする</td>
    </tr>
    <tr>
      <td><tt>version</tt></td>
      <td>Hubotのバージョンを返す</td>
    </tr>
    <tr>
      <td><tt>date</tt></td>
      <td>日付と時間を返す</td>
    </tr>
    <tr>
      <td><tt>time</tt></td>
      <td>時間を返す</td>
    </tr>
    <tr>
      <td><tt>help.coffee</tt></td>
      <td><tt>help</tt></td>
      <td>コマンドの一覧を返す</td>
    </tr>
    <tr>
      <td rowspan="3"><tt>anime.coffee</tt></td>
      <td><tt>anime</tt></td>
      <td>今期放送中のアニメの一覧を返す</td>
    </tr>
    <tr>
      <td><tt>anime today</tt></td>
      <td>今日放送のアニメの一覧を返す</td>
    </tr>
    <tr>
      <td><tt>anime search [title]</tt></td>
      <td>今期のアニメをタイトルで検索する</td>
    </tr>
    <tr>
      <td rowspan="2"><tt>member.coffee</tt></td>
      <td><tt>member</tt></td>
      <td>Typetalkのトピックメンバー全員を返す</td>
    </tr>
    <tr>
      <td><tt>who</tt></td>
      <td>ランダムに1人選び、お願いリプライを送る</td>
    </tr>
  </tbody>
</table>

## URLS

<table>
  <thead></thead>
  <tbody>
    <tr>
      <td rowspan="2"><tt>httpd.coffee</tt></td>
      <td><tt>GET /huboco/info</tt></td>
      <td>Hubocoの紹介ページを表示</td>
    </tr>
    <tr>
      <td><tt>POST /hubot/ping</tt></td>
      <td>PONG</td>
    </tr>
    <tr>
      <td><tt>gitlab.coffee</tt></td>
      <td><tt>POST /gitlab/hook</tt></td>
      <td>GitLabからのWebHookを通知</td>
    </tr>
    <tr>
      <td><tt>github.coffee</tt></td>
      <td><tt>POST /github/hook</tt></td>
      <td>GitHubからのWebHookを通知</td>
    </tr>
    <tr>
      <td rowspan="2"><tt>invite.coffee</tt></td>
      <td><tt>GET /typetalk/form</tt></td>
      <td>Typetalkのトピックの招待フォームを表示</td>
    </tr>
    <tr>
      <td><tt>POST /typetalk/invite</tt></td>
      <td>Typetalkのトピックにメンバーを招待</td>
    </tr>
 </tbody>
</table>

## SpecialThanks

- 「[情報共有ツールの情報共有 | JANOG34 Meeting](http://www.janog.gr.jp/meeting/janog34/program/itool.html)」への参加をキッカケに開発を開始しました。
- アイコンは「[In Spirited We Love Icon Se by Raindropmemory](http://raindropmemory.deviantart.com/art/In-Spirited-We-Love-Icon-Set-Repost-304014435)」を使っています。
