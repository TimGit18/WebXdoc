<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY x02022
"<xsl:text disable-output-escaping='yes'>&amp;#x02022;</xsl:text>" >
<!ENTITY x85
"<xsl:text disable-output-escaping='yes'>&amp;#x85;</xsl:text>" >
]>


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
  <xsl:output method="xml" indent="yes"/>

  <!-- ***************** -->
  <!-- Dokumenten-Wurzel -->
  <!-- ***************** -->
  <xsl:template match="document">
  <fo:root>

    <fo:layout-master-set>

      <!-- ***************** -->
      <!-- Dokumenten-Wurzel -->
      <!-- ***************** -->
      <fo:simple-page-master master-name="page" page-height="29.7cm"
          page-width="21cm" margin-top="1cm" margin-bottom="1cm"
          margin-left="2.5cm" margin-right="2.5cm">
        <fo:region-body   margin-top="1cm"/>
        <fo:region-before extent="3cm"/>
        <fo:region-after  extent="0.5cm"/>
        <fo:region-start  extent="2cm"/>
        <fo:region-end    extent="0.5cm"/>
      </fo:simple-page-master>
   
      <fo:page-sequence-master master-name="single-page">
        <fo:repeatable-page-master-reference master-reference="page"/>
      </fo:page-sequence-master>

    </fo:layout-master-set>

    
    <!-- ************** -->
    <!-- Titel mit Logo -->
    <!-- ************** -->
    <fo:page-sequence master-reference="single-page" initial-page-number="1">
      <fo:static-content flow-name="xsl-region-before">
        <fo:block space-after="4pt" space-before="4pt" text-align="right">
          <fo:external-graphic src="url('file:///C:/Users/test/Daten/Web/xdoc/resources/logo.svg')" text-align="right"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align="outside" font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          Seite
          <fo:page-number/>
        </fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="20pt" font-weight="bold"
         space-after="10pt" space-before="10pt" text-align="start">
          &#x85;<xsl:apply-templates select="title"/>    
        </fo:block>
        <fo:block text-align="start" font-family="Helvetica, Arial, sans-serif" font-size="10pt" >
          <xsl:apply-templates select="author"/>    
        </fo:block>
        <fo:block text-align="start" font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:apply-templates select="date"/>    
        </fo:block>
      </fo:flow>
    </fo:page-sequence>

    <!-- ****************** -->
    <!-- Inhaltsverzeichnis -->
    <!-- ****************** -->
    <fo:page-sequence master-reference="single-page" initial-page-number="2">
      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align="outside" font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          Seite
          <fo:page-number/>
        </fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates select="content" mode="toc" />
      </fo:flow>
    </fo:page-sequence>


    <!-- ****** -->
    <!-- Inhalt -->
    <!-- ****** -->
    <fo:page-sequence master-reference="single-page" initial-page-number="3">
      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align="outside" font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          Seite
          <fo:page-number/>
        </fo:block>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
         <fo:block break-after="page" font-family="Helvetica, Arial, sans-serif">
            <xsl:apply-templates select="content"/>
         </fo:block>
      </fo:flow>
    </fo:page-sequence>

  </fo:root>
  </xsl:template>

  <!-- ***** -->
  <!-- Title -->
  <!-- ***** -->
  <xsl:template match="title">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- ****** -->
  <!-- Author -->
  <!-- ****** -->
  <xsl:template match="author">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- **** -->
  <!-- Date -->
  <!-- **** -->
  <xsl:template match="date">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- **************** -->
  <!-- Table Of Content -->
  <!-- **************** -->
  <xsl:template match="content" mode="toc">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="14pt" font-weight="bold"
        space-after="10pt" space-before="10pt" text-align="start">
      Inhalt
    </fo:block>
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" text-align="justify"
        space-before="10pt" space-after="10pt">
      <xsl:for-each select="subheadline">
        <fo:block text-align-last="justify">
          <fo:inline>
            <xsl:value-of select="."/>
            <fo:leader leader-pattern="dots"/>
            <fo:page-number-citation ref-id="{@id}"/>
          </fo:inline>
        </fo:block>
      </xsl:for-each>
    </fo:block>  
  </xsl:template>

  <!-- ******* -->
  <!-- Content -->
  <!-- ******* -->
  <xsl:template match="content">
    <xsl:apply-templates />
  </xsl:template>

  <!-- ******** -->
  <!-- Abstract -->
  <!-- ******** -->
  <xsl:template match="abstract">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" text-align="justify"
        space-before="10pt" space-after="10pt">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- *********** -->
  <!-- Überschrift -->
  <!-- *********** -->
  <xsl:template match="headline">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="20pt" font-weight="bold"
        space-after="10pt" space-before="10pt" text-align="start">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ************** -->
  <!-- Subüberschrift -->
  <!-- ************** -->
  <xsl:template match="subheadline">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="14pt" font-weight="bold"
        space-after="10pt" space-before="10pt" text-align="start" id="{@id}">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ********* -->
  <!-- Textblock -->
  <!-- ********* -->
  <xsl:template match="text">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" text-align="justify"
        space-before="10pt" space-after="10pt">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ************** -->
  <!-- Einfache Liste -->
  <!-- ************** -->
  <xsl:template match="list">
    <fo:list-block provisional-distance-between-starts="50mm"
        provisional-label-separation="10mm" space-after="4pt" space-before="4pt">
      <xsl:apply-templates select="listitem"/>
    </fo:list-block>
  </xsl:template>

  <!-- ************ -->
  <!-- Nummerierung -->
  <!-- ************ -->
  <xsl:template match="numlist">
    <fo:list-block provisional-distance-between-starts="50mm"
        provisional-label-separation="10mm" space-after="4pt" space-before="4pt">
         <xsl:apply-templates select="listitem"/>
    </fo:list-block>
  </xsl:template>

  <!-- ************* -->
  <!-- Listenelement -->
  <!-- ************* -->
  <xsl:template match="listitem">
    <fo:list-item>
      <fo:list-item-label>
    
        <!-- *********************************** -->
        <!-- Dots (&#x02022;) für normale Listen -->
        <!-- *********************************** -->
        <xsl:if test="parent::*[1][self::list]">
          <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" font-weight="normal">
           &#x02022;
          </fo:block>
        </xsl:if>

        <!-- *************************** -->
        <!-- Zahlen für georderte Listen -->
        <!-- *************************** -->
        <xsl:if test="parent::*[1][self::numlist]">
          <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" font-weight="normal">
            <xsl:number/>.
          </fo:block>
        </xsl:if>
      </fo:list-item-label>
      <fo:list-item-body>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" start-indent="5mm">
          <xsl:value-of select="."/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <!-- ******* -->
  <!-- Tabelle -->
  <!-- ******* -->
  <xsl:template match="table">
    <fo:block space-after="10pt" space-before="10pt">
      <fo:table table-layout="fixed" width="100%">
        <fo:table-header>
          <xsl:apply-templates select="tableheadline"/>
        </fo:table-header>
        <fo:table-body>
          <xsl:apply-templates select="tablebody"/>
        </fo:table-body>
      </fo:table>

      <!-- ******************** -->
      <!-- Tabellenbeschreibung -->
      <!-- ******************** -->
      <xsl:if test="child::tablebody/tablecaption"> 
          <xsl:apply-templates select="tablebody/tablecaption"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <!-- ***************** -->
  <!-- Tabelle-Kopfzeile -->
  <!-- ***************** -->
  <xsl:template match="tableheadline">
    <xsl:apply-templates select="tablerow"/>
  </xsl:template>

  <!-- ************** -->
  <!-- Tabellenkörper -->
  <!-- ************** -->
  <xsl:template match="tablebody">
    <xsl:apply-templates select="tablerow"/>
  </xsl:template>

  <!-- ************* -->
  <!-- Tabellenzeile -->
  <!-- ************* -->
  <xsl:template match="tablerow">
    <fo:table-row>

      <!-- ****************************** -->
      <!-- Überschrift fett und vor grau  -->
      <!-- ****************************** -->
      <xsl:if test="parent::*[1][self::tableheadline]">
        <xsl:for-each select="tableheaditem">
          <fo:table-cell border-color="black" border-style="solid">
            <fo:block background-color="#f0f0f0" font-family="Helvetica, Arial, sans-serif"
                font-size="10pt" font-weight="bold">
              <xsl:value-of select="."/>
            </fo:block>
          </fo:table-cell>
        </xsl:for-each>
      </xsl:if>

      <!-- ********************* -->
      <!-- Normale Tabellenzeile -->
      <!-- ********************* -->
      <xsl:if test="parent::*[1][self::tablebody]">
        <xsl:for-each select="tableitem">
          <fo:table-cell border-color="black" border-style="solid">
            <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
              <xsl:value-of select="."/>
            </fo:block>
          </fo:table-cell>
        </xsl:for-each>
      </xsl:if>
    </fo:table-row>
  </xsl:template>

  <!-- ********************* -->
  <!-- Tabellen-Beschreibung -->
  <!-- ********************* -->
  <xsl:template match="tablecaption">
    <fo:block space-after="6pt" space-before="6pt" font-family="Helvetica, Arial, sans-serif" font-size="10pt" font-style="italic">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ************ -->
  <!-- Bildstruktur -->
  <!-- ************ -->
  <xsl:template match="figure">
    <xsl:apply-templates select="image"/>
    <xsl:apply-templates select="figurecaption"/>
  </xsl:template>

  <!-- *********** -->
  <!-- Bildverweis -->
  <!-- *********** -->
  <xsl:template match="image">
    <fo:block space-after="4pt" space-before="4pt">
      <fo:external-graphic>
        <xsl:attribute name="src">url('<xsl:value-of select="@source"/>')</xsl:attribute>
      </fo:external-graphic>
    </fo:block>  
  </xsl:template>

  <!-- *********** -->
  <!-- Bildverweis -->
  <!-- *********** -->
  <xsl:template match="figurecaption">
    <fo:block space-after="6pt" space-before="6pt" font-family="Helvetica, Arial, sans-serif" font-size="10pt" font-style="italic">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- *********** -->	
  <!-- Codierblock -->
  <!-- *********** -->	
  <xsl:template match="codebox">
    <fo:block font-family="Courier" font-size="6pt" linefeed-treatment="preserve" white-space-treatment="preserve"
        space-before="0pt" space-after="4pt" text-align="start"
        white-space-collapse="false">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- *********** -->
  <!-- Codierzeile -->
  <!-- *********** -->
  <xsl:template match="codeline">
    <fo:block font-family="Courier" font-size="6pt" linefeed-treatment="preserve"  white-space-treatment="preserve"
        space-before="4pt" space-after="4pt" text-align="start"
        white-space-collapse="false">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ********* -->
  <!-- Fettdruck -->
  <!-- ********* -->
  <xsl:template match="bold">
    <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt" font-weight="bold">
      <xsl:value-of select="."/>
    </fo:block>
  </xsl:template>

  <!-- ********** -->
  <!-- Hyperlinks -->
  <!-- ********** -->
  <xsl:template match="hyperlinks">
    <fo:block space-after="6pt" space-before="6pt">
      <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="150mm" />
        <fo:table-body>
          <xsl:apply-templates select="hyperlink"/>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!-- ********* -->
  <!-- Hyperlink -->
  <!-- ********* -->
  <xsl:template match="hyperlink">
    <fo:table-row>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:value-of select="@name"/>
          <fo:basic-link>
            <xsl:attribute name="external-destination">
	            <xsl:value-of select="."/>
            </xsl:attribute>
            </fo:basic-link>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>


  <!-- ******* -->
  <!-- Sequenz -->
  <!-- ******* -->
  <xsl:template match="sequence">
    <fo:block space-after="6pt" space-before="6pt">
      <fo:table table-layout="fixed" width="100%">
        <fo:table-column column-width="30mm" />
        <fo:table-column column-width="10mm" />
        <fo:table-column column-width="60mm" />
        <fo:table-column column-width="60mm" />
        <fo:table-body>
          <xsl:apply-templates/>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!-- ************** -->
  <!-- Sequenz-Zeile -->  
  <!-- ************* -->
  <xsl:template match="sequenceline">
    <fo:table-row>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:value-of select="@start"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          ==&gt;
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:choose>
            <xsl:when test="@dialogue='yes'">
              <fo:block font-weight="bold">
                <xsl:value-of select="@target"/>
              </fo:block>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@target"/>
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

  <!-- *************** -->
  <!-- Sequenz-Element -->  
  <!-- *************** -->
  <xsl:template match="sequenceitem">
    <fo:table-row>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:value-of select="@target"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell>
        <fo:block font-family="Helvetica, Arial, sans-serif" font-size="10pt">
          <xsl:value-of select="@comment"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>
