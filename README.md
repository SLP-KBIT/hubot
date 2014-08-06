# Huboco

<a href="https://raw.githubusercontent.com/hico-horiuchi/huboco/master/icon.png">
  <img src="/../master/icon.png" width="200px" height="auto">
</a>
<br>

Huboco(ひゅぼ子)は、Hubot製のチャットボットです。
<br>
研究室のチャットルームでの利用を目的に、研究のお手伝いができるよう開発中です。

## Install

Herokuでの簡単な導入説明。

    $ heroku create --stack cedar huboco
    $ heroku addons:add redistogo:nano
    $ heroku config:set HEROKU_URL=http://huboco.herokuapp.com/
    $ heroku config:set HUBOT_TYPETALK_CLIENT_ID=""
    $ heroku config:set HUBOT_TYPETALK_CLIENT_SECRET=""
    $ heroku config:set HUBOT_TYPETALK_ROOMS=""
    $ heroku config:set HUBOT_TYPETALK_API_RATE=100
    $ git push heroku heroku

## Commands

<table>
  <thead></thead>
  <tbody>
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
      <td><tt>POST /huboco/ping</tt></td>
      <td>PONG</td>
    </tr>
    <tr>
      <td><tt>gitlab.coffee</tt></td>
      <td><tt>POST /gitlab/hook</tt></td>
      <td>GitLabからのWebHookを通知</td>
    </tr>
 </tbody>
</table>

## SpecialThanks

- 「[情報共有ツールの情報共有 | JANOG34 Meeting](http://www.janog.gr.jp/meeting/janog34/program/itool.html)」への参加をキッカケに開発を開始しました。
- アイコンは「[In Spirited We Love Icon Se by Raindropmemory](http://raindropmemory.deviantart.com/art/In-Spirited-We-Love-Icon-Set-Repost-304014435)」を使っています。
