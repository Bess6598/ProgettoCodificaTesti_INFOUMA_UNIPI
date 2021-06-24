<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" >

    <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>

    <xsl:variable name="style">
      <link rel="stylesheet" type="text/css" href="./stile.css" />
      <link rel="icon" type="image/x-icon"  href="./img/icona.ico" />
    </xsl:variable>

    <xsl:variable name="title">
      <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title" />
    </xsl:variable>

    <xsl:template match="/tei:TEI">
      <html>
        <head>
          <title><xsl:value-of select="$title" /></title>
          <xsl:copy-of select="$style"/>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.js"></script>
          <script type="text/javascript" src="file.js"></script>
        </head>
        <body>
          <div id="#page_cpontainer">
            <div class="zoom"></div>
            <div id="titolo">
              <h1> <xsl:copy-of select="$title"/> </h1>
              <p class="subtitle">
                Autore <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:author" /> |
                <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp" />
                <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name" />
              </p>
            </div>
            <ul id="menu">
              <li> <a id="persone_button" class="checkPage" href="#ancora_antroponimi">Persone</a> </li>
              <li> <a id="luoghi_button" class="checkPage" href="#ancora_toponimi">Luoghi</a> </li>
              <li> <a id="istituzioni_button" class="checkPage" href="#ancora_istituzioni">Istituzioni</a> </li>
              <li> <a id="testo_button" class="checkPage" href="#ancora_testo">Testo</a> </li>
            </ul>

            <div class="index">
              <div id="persone_page">
                <h2>Persone</h2>
                <div id="persone_section">
                  <xsl:apply-templates select="tei:standOff/tei:listPerson"/>
                </div>
              </div>
              <div id="luoghi_page">
                <h2>Luoghi</h2>
                <div id="luoghi_section">
                  <xsl:apply-templates select="tei:standOff/tei:listPlace"/>
                </div>
              </div>
              <div id="istituzioni_page">
                <h2>Istituzioni</h2>
                <div id="istituzioni_section">
                  <xsl:apply-templates select="tei:standOff/tei:listObject"/>
                </div>
              </div>
              <div id="testo_page">
                <h2>Testo</h2>
                <div id="testo_section">
                  <xsl:call-template name="testo">
                    <xsl:with-param name="facsimile" select = "tei:facsimile" />
                    <xsl:with-param name="text" select = "tei:text/tei:body" />
                  </xsl:call-template>
                </div>
              </div>
            </div>
            <footer>
              <p>
                Sito realizzato da
                <a  title="Pagina GitHub"  href="https://github.com/Bess6598" target="_blank" >
                  Carolina Sgherri
                </a>
              </p>
            </footer>
          </div>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="tei:listPerson"> <!-- Sezione persone -->
      <xsl:for-each select="tei:person">
        <ul id="{./@xml:id}">
          <li>
            <span>Nome:</span>
            <xsl:value-of select="tei:persName/tei:forename"/>
            <xsl:value-of select="tei:persName/tei:surname"/>
            <xsl:value-of select="tei:persName/tei:roleName"/>
          </li>
          <li><span>Sesso: </span> <xsl:value-of select="tei:sex"/></li>
          <li><span>Nascita: </span> <xsl:value-of select="tei:birth/@when"/></li>
          <li><span>Morte: </span> <xsl:value-of select="tei:death/@when"/></li>
          <li><span>Note: </span> <xsl:value-of select="tei:note"/></li>
        </ul>
      </xsl:for-each>
    </xsl:template>

   <xsl:template match="tei:listPlace"> <!-- Sezione luoghi -->
     <xsl:for-each select="tei:place">
       <div class="toponimo">
         <xsl:if test="not(tei:placeName/@notAfter)">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d11379667.893494574!2d-6.924094218123403!3d45.8665231138562!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd54a02933785731%3A0x6bfd3f96c747d9f7!2sFrance!5e0!3m2!1sen!2sit!4v1623947340545!5m2!1sen!2sit" width="200" height="200" style="border:0;" allowfullscreen="" loading="lazy">
          </iframe>
         </xsl:if>
         <div>
           <h4 id="{./@xml:id}"><xsl:value-of select="tei:placeName"/></h4>
           <p><xsl:value-of select="tei:note"/></p>
         </div>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template match="tei:listObject"> <!-- Sezione istituzioni -->
     <xsl:for-each select="tei:object[@type='institution']">
       <div>
         <h4><xsl:value-of select="tei:objectIdentifier/tei:objectName"/></h4>
         <p><xsl:value-of select="tei:p"/></p>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template name = "testo" > <!-- Sezione testo -->
     <xsl:param name = "facsimile" />
     <xsl:param name = "text" />
     <xsl:for-each select="$facsimile/tei:surface/tei:zone/tei:figure">
       <xsl:variable name="text_id">
         <xsl:value-of select="substring (../@start ,2 )"/>
       </xsl:variable>
       <xsl:variable name="text_id_it">
         <xsl:value-of select="concat(substring (../@start ,2 ), '_IT')"/>
       </xsl:variable>
       <div class="sezione">
         <h4><xsl:value-of select = "tei:head" /></h4>
          <p class="desc"><xsl:value-of select = "tei:figDesc" /></p>
          <div class="img">
           <xsl:choose>
            <xsl:when test="tei:graphic/@width &lt; 1000">
              <img class="img_sezione small" src="{tei:graphic/@url}"/>
            </xsl:when>
            <xsl:otherwise>
              <img class="img_sezione" src="{tei:graphic/@url}"/>
            </xsl:otherwise>
          </xsl:choose>
         </div>
         <div class="testi">
           <div class="testo_fr">
             <xsl:apply-templates select="$text/tei:div[@xml:id=$text_id]/tei:p"/>
           </div>
           <div class="testo_it">
             <xsl:apply-templates select="$text/tei:div[@xml:id=$text_id_it]/tei:p"/>
           </div>
         </div>
       </div>
     </xsl:for-each>
   </xsl:template>

   <xsl:template match="tei:p">
     <p>
       <xsl:apply-templates/>
     </p>
   </xsl:template>

   <xsl:template match="tei:term">
     <span class="term"><xsl:apply-templates/></span>
   </xsl:template>

  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <xsl:template match="tei:w[@rend] | tei:term[@rend] | tei:del[@rend]">
    <span class="{./@rend}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="tei:choice">
    <div class="tooltip">
      <xsl:choose>
        <xsl:when test="tei:abbr[@rend]">
          <span class="{tei:abbr/@rend}"><xsl:value-of select="tei:abbr"/></span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="tei:abbr"/>
        </xsl:otherwise>
      </xsl:choose>
      <span class="tooltiptext"><xsl:value-of select="tei:expan"/></span>
    </div>
  </xsl:template>

  <xsl:template match="tei:gap">
    <span class="gap"> *** </span>
  </xsl:template>

  <xsl:template match="tei:persName">
    <a title="persona" class="checkPage" href="#ancora_antroponimi"><xsl:apply-templates/></a>
  </xsl:template>

  <xsl:template match="tei:placeName">
    <a title="luogo" class="checkPage" href="#ancora_toponimi"><xsl:apply-templates/></a>
  </xsl:template>

  <xsl:template match="tei:objectName">
    <a title="istituzione" class="checkPage" href="#ancora_istituzioni"><xsl:apply-templates/></a>
  </xsl:template>

</xsl:stylesheet>
