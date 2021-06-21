<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" >

    <xsl:output method="html" indent="yes" />

    <xsl:variable name="style">
      <link rel="stylesheet" type="text/css" href="./stile.css" />
      <link rel="icon" type="image/x-icon"  href="./img/icona.ico" />
    </xsl:variable>

    <xsl:variable name="title">
      <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title" />
    </xsl:variable>

    <xsl:template match="/">
      <html>
        <head>
          <title> <xsl:copy-of select="$title"/> </title>
          <xsl:copy-of select="$style"/>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.js"></script>
          <script type="text/javascript" src="file.js"></script>
        </head>
        <body>
          <div class="zoom"></div>
          <div id="titolo">
            <h1> <xsl:copy-of select="$title"/> </h1>
            <p class="subtitle">
              Autore <xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/bibl/author" /> |
              <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/respStmt/resp" />
              <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/respStmt/name" />
            </p>
          </div>
          <ul id="menu">
            <li> <a href="#ancora_antroponimi">Persone</a> </li>
            <li> <a href="#ancora_toponimi">Luoghi</a> </li>
            <li> <a href="#ancora_istituzioni">Istituzioni</a> </li>
            <li> <a href="#ancora_testo">Testo</a> </li>
          </ul>

          <div class="index">
            <h2 id="ancora_antroponimi">Persone</h2>
            <div id="persone_section">
              <xsl:apply-templates select="TEI/standOff/listPerson"/>
            </div>
            <h2 id="ancora_toponimi">Luoghi</h2>
            <div id="luoghi_section">
              <xsl:apply-templates select="TEI/standOff/listPlace"/>
            </div>
            <h2 id="ancora_istituzioni">Istituzioni</h2>
            <div id="istituzioni_section">
              <xsl:apply-templates select="TEI/standOff/listObject"/>
            </div>
            <h2 id="ancora_testo">Testo</h2>
            <div id="testo_section">
              <xsl:call-template name="testo">
                <xsl:with-param name="facsimile" select = "TEI/facsimile" />
                <xsl:with-param name="text" select = "TEI/text/body" />
              </xsl:call-template>
            </div>
          </div>

        </body>
      </html>
    </xsl:template>

    <xsl:template match="listPerson"> <!-- Sezione persone -->
      <xsl:for-each select="person">
        <ul id="{./@xml:id}">
          <li>
            <span>Nome:</span>
            <xsl:value-of select="persName/forename"/>
            <xsl:value-of select="persName/surname"/>
            <xsl:value-of select="persName/roleName"/>
          </li>
          <li><span>Sesso:</span> <xsl:value-of select="sex"/></li>
          <li><span>Nascita:</span> <xsl:value-of select="birth/@when"/></li>
          <li><span>Morte:</span> <xsl:value-of select="death/@when"/></li>
          <li><span>Note:</span> <xsl:value-of select="note"/></li>
        </ul>
      </xsl:for-each>
    </xsl:template>

   <xsl:template match="listPlace"> <!-- Sezione luoghi -->
     <xsl:for-each select="place">
       <div class="toponimo">
         <xsl:if test="not(placeName/@notAfter)">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d11379667.893494574!2d-6.924094218123403!3d45.8665231138562!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd54a02933785731%3A0x6bfd3f96c747d9f7!2sFrance!5e0!3m2!1sen!2sit!4v1623947340545!5m2!1sen!2sit" width="200" height="200" style="border:0;" allowfullscreen="" loading="lazy">
          </iframe>
         </xsl:if>
         <div>
           <h4 id="{./@xml:id}"><xsl:value-of select="placeName"/></h4>
           <p><xsl:value-of select="note"/></p>
         </div>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template match="listObject"> <!-- Sezione istituzioni -->
     <xsl:for-each select="object[@type='institution']">
       <div>
         <h4 id="{./@xml:id}"><xsl:value-of select="objectIdentifier/objectName"/></h4>
         <p><xsl:value-of select="p"/></p>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template name = "testo" > <!-- Sezione testo -->
     <xsl:param name = "facsimile" />
     <xsl:param name = "text" />
     <xsl:for-each select="$facsimile/surface/zone/figure">
       <xsl:variable name="text_id">
         <xsl:value-of select="substring (../@start ,2 )"/>
       </xsl:variable>
       <xsl:variable name="text_id_it">
         <xsl:value-of select="concat(substring (../@start ,2 ), '_IT')"/>
       </xsl:variable>
       <div class="sezione">
         <h4><xsl:value-of select = "head" /></h4>
          <p class="desc"><xsl:value-of select = "figDesc" /></p>
          <div class="img">
           <xsl:choose>
            <xsl:when test="graphic/@width &lt; 1000">
              <img class="img_sezione small" src="{graphic/@url}"/>
            </xsl:when>
            <xsl:otherwise>
              <img class="img_sezione" src="{graphic/@url}"/>
            </xsl:otherwise>
          </xsl:choose>
         </div>
         <div class="testi">
           <div class="testo_fr">
             <xsl:apply-templates select="$text/div[@xml:id=$text_id]/p"/>
           </div>
           <div class="testo_it">
             <xsl:apply-templates select="$text/div[@xml:id=$text_id_it]/p"/>
           </div>
         </div>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template match="p">
     <p>
       <xsl:apply-templates/>
     </p>
   </xsl:template>

  <xsl:template match="lb">
    <br/>
  </xsl:template>

  <xsl:template match="w[@rend] | term[@rend] |del[@rend]">
    <span class="{./@rend}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="choice">
    <div class="tooltip">
      <xsl:choose>
        <xsl:when test="abbr[@rend]">
          <span class="{abbr/@rend}"><xsl:value-of select="abbr"/></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="abbr"/>
        </xsl:otherwise>
      </xsl:choose>
      <span class="tooltiptext"><xsl:value-of select="expan"/></span>
    </div>
  </xsl:template>

  <xsl:template match="gap">
    <span class="gap"> *** </span>
  </xsl:template>

  <xsl:template match="persName">
    <a href="#ancora_antroponimi"><xsl:value-of select="."/></a>
  </xsl:template>

  <xsl:template match="placeName">
    <a href="#ancora_toponimi"><xsl:value-of select="."/></a>
  </xsl:template>

  <xsl:template match="objectName">
    <a href="#ancora_istituzioni"><xsl:value-of select="."/></a>
  </xsl:template>

</xsl:stylesheet>
