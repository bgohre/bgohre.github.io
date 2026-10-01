<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="robots" content="noindex"/>
        <title><xsl:value-of select="rss/channel/title"/> | RSS feed</title>
        <link rel="stylesheet" href="../style.css?v=20261001"/>
        <style>
          button.btn { cursor: pointer; font-size: inherit; line-height: inherit; }
          .feed-hero { padding: 3rem 0 2rem; }
          .feed-note { background: var(--surface); border: 1px solid var(--line); border-left: 4px solid var(--lavender);
            border-radius: var(--radius); padding: 1.25rem 1.4rem; max-width: 44rem; margin-top: 1.5rem; }
          .feed-note p { margin: 0 0 .9rem; }
          .feed-url { display: flex; flex-wrap: wrap; gap: .6rem; align-items: center; }
          .feed-url code { font-size: .88rem; background: var(--tint); color: var(--plum); padding: .5rem .75rem;
            border-radius: 10px; word-break: break-all; flex: 1 1 18rem; }
          .copied { font-size: .9rem; color: var(--green); min-height: 1.2em; margin: .5rem 0 0; }
          .episode { background: var(--surface); border: 1px solid var(--line); border-top: 4px solid var(--plum);
            border-radius: var(--radius); box-shadow: var(--shadow); padding: 1.5rem 1.6rem 1.3rem; max-width: 44rem; margin-bottom: 1.25rem; }
          .episode h3 { font-family: var(--display); font-size: 1.6rem; line-height: 1.2; color: var(--plum); margin: 0 0 .4rem; }
          .episode .ep-meta { font-family: var(--sans); font-size: .88rem; color: var(--muted); margin: 0 0 .8rem; }
          .episode p { margin: 0 0 1rem; }
          .episode audio { width: 100%; }
          @media (max-width: 760px) { .feed-hero { padding: 2rem 0 1.5rem; } .episode { padding: 1.2rem 1.1rem 1.1rem; } }
        </style>
      </head>
      <body>
        <header class="site-header">
          <div class="wrap">
            <a class="wordmark" href="../index.html"><span class="dot" aria-hidden="true"></span>Barbara Gohre</a>
            <nav aria-label="Site"><ul class="nav">
              <li><a href="../index.html">Home</a></li>
              <li><a href="../writing.html">Writing</a></li>
              <li><a href="./" aria-current="page">Podcast</a></li>
              <li><a href="../about.html">About</a></li>
              <li><a href="../speaking.html">Speaking</a></li>
              <li><a href="../books.html">Books</a></li>
            </ul></nav>
          </div>
        </header>

        <main>
          <section class="feed-hero">
            <div class="wrap">
              <a class="back" href="./">&#8592; Back to the podcast</a>
              <p class="eyebrow" style="margin-top:1rem">RSS feed</p>
              <h1><xsl:value-of select="rss/channel/title"/></h1>
              <p class="lede"><xsl:value-of select="rss/channel/description"/></p>

              <div class="feed-note">
                <p><strong>This is the podcast's feed.</strong> To follow the show, copy this link and paste it into your podcast app. Look for an option like "Add show by URL" or "Follow a show by RSS feed."</p>
                <div class="feed-url">
                  <code id="feedurl">https://behindgme.com/coast-to-coast-gme/feed.xml</code>
                  <button class="btn" type="button" id="copybtn">Copy link</button>
                </div>
                <p class="copied" id="copied" aria-live="polite"></p>
              </div>
            </div>
          </section>

          <section class="section" style="padding-top:0">
            <div class="wrap">
              <div class="section-head"><div><h2>Episodes</h2></div></div>
              <xsl:for-each select="rss/channel/item">
                <article class="episode">
                  <h3><xsl:value-of select="title"/></h3>
                  <p class="ep-meta">
                    <xsl:value-of select="substring(pubDate, 6, 11)"/>
                    <xsl:if test="itunes:duration"> &#183; <xsl:value-of select="itunes:duration"/></xsl:if>
                  </p>
                  <p><xsl:value-of select="description"/></p>
                  <audio controls="controls" preload="none">
                    <xsl:attribute name="src"><xsl:value-of select="enclosure/@url"/></xsl:attribute>
                  </audio>
                </article>
              </xsl:for-each>
            </div>
          </section>
        </main>

        <footer class="site-footer">
          <div class="wrap">
            <div>
              <p class="connect">Let&#8217;s connect</p>
              <p>The views shared here are my own and don't represent my employer or any organization I'm affiliated with.</p>
            </div>
            <ul class="foot-links">
              <li><a href="https://www.linkedin.com/in/barbara-g-16479b71">LinkedIn</a></li>
              <li><a href="https://orcid.org/0009-0004-1730-8789">ORCID</a></li>
              <li><a href="https://fulgme.org">FULGME</a></li>
            </ul>
          </div>
        </footer>

        <script>
          document.getElementById('copybtn').addEventListener('click', function () {
            var url = document.getElementById('feedurl').textContent;
            var msg = document.getElementById('copied');
            function done() { msg.textContent = 'Copied. Paste it into your podcast app.'; }
            if (navigator.clipboard) {
              navigator.clipboard.writeText(url).then(done, function () { msg.textContent = 'Select the link above and copy it.'; });
            } else { msg.textContent = 'Select the link above and copy it.'; }
          });
        </script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
