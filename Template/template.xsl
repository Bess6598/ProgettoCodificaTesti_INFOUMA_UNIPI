<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" >

    <xsl:output method="html" indent="yes" />

    <xsl:variable name="stile">
      <link rel="stylesheet" type="text/css" href="./mycss.css" />
      <style>
        h1 {
          color:blue;
        }
      </style>
    </xsl:variable>

    <xsl:template match="/">
      <html>
        <head>
          <title>
            <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title" />
          </title>
          <xsl:copy-of select="$stile" />
        </head>
        <body>
          <div class="index">
            <h1>INDEX</h1>
            <ul>
              <xsl:call-template name="index_template">
                <xsl:with-param name="capitoli" select="//div[@type='chapter']" />
              </xsl:call-template>
            </ul>
          </div>
          <div>
            <xsl:call-template name="id_doc_template">
              <xsl:with-param name="nodes" select="child::node()" />
            </xsl:call-template>
            <xsl:call-template name="title_template">
              <xsl:with-param name="nodes" select="child::node()" />
            </xsl:call-template>
            <xsl:call-template name="chapter_template">
              <xsl:with-param name="nodes" select="child::node()" />
            </xsl:call-template>
          </div>
        </body>
      </html>
    </xsl:template>

    <xsl:template match="div" name="index_template" mode="index">
      <xsl:param name="capitoli" />
      <ul>
        <xsl:for-each select="$capitoli">
        <li> <xsl:value-of select="head" /> </li>
        </xsl:for-each>
      </ul>
    </xsl:template>

    <xsl:template name="title_template">
      <xsl:param name="nodes" />
      <h2> <xsl:value-of select="$nodes//titleStmt/title" /> </h2>
    </xsl:template>

    <xsl:template name="chapter_template">
      <xsl:param name="nodes" />
      <xsl:for-each select="$nodes">
        <h3> <xsl:value-of select="$nodes//div/head" /> </h3>
        <p> <xsl:value-of select="$nodes//div/p" /> </p>
      </xsl:for-each>
    </xsl:template>

    <xsl:template name="id_doc_template">
      <xsl:param name="nodes" />
      <span>[identificativo del documento: <xsl:value-of select="$nodes//teiHeader/@id" />]</span>
    </xsl:template>

</xsl:stylesheet>
