<?xml version="1.0" encoding='ISO-8859-1'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <xsl:output method="html"/>
  <xsl:template match="document">
  <html lang="de">

    <!-- *********************************** -->
  	<!-- Header mit Viewport und Stylesheets -->
    <!-- *********************************** -->
    <head>
      <title><xsl:value-of select="@env"/></title>
      <meta charset="utf-8"/>
      <meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
      <xsl:apply-templates select="links"/>
    </head>

    <!-- ****************************************************************** 	-->
  	<!-- Body Tag mit Container für die Ausrichtung auf zwei Spalten Grid 		-->
  	<!-- Layout. Der Container besteht aus einer Zeile und zwei Spalten.			-->
  	<!-- Die erste Spalte beinhaltet das dynamische Inhaltsverzeichnis.				-->
  	<!-- Die zweite Spalte beinhaltet die fest-verankterte Navigationsleiste	-->
  	<!-- sowie den Content-Bereich.																					  -->
  	<!-- ****************************************************************** 	-->
    <body data-spy="scroll" data-target="#toc">

      <!-- ************************** -->
      <!-- Start des Content-Bereichs -->
      <!-- ************************** -->
      <div class="container-fluid">
        <div class="row">

          <!-- ************************************************************* -->
          <!-- Seitliche, feste Navigationsleiste für das Inhaltsverzeichnis -->
          <!-- ************************************************************* -->
          <div class="col-sm-1 bg-light">
            <figure class="figure">
              <img class="figure-img img-fluid rounded" src="http://localhost:8080/xdoc/Ressources/getsitelogo.png"/>
            </figure>   
            <!-- <nav id="toc" class="sticky-top" data-spy="affix" data-toggle="toc"></nav> -->
          </div>

          <!-- **************************** -->
          <!-- Eigentlicher Content-Bereich -->
          <!-- **************************** -->
          <div class="col-sm-11">

            <!-- ****************************************** -->
            <!-- Feste Navigationsleiste für externe Links  -->
            <!-- ****************************************** -->
            <nav class="navbar navbar-expand-lg sticky-top navbar-light bg-light">
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                  <xsl:apply-templates select="main"/>
                </ul>
              </div>
            </nav>
            <p></p>

            <!-- *********************** -->
            <!-- Abstract als Plain Text -->
            <!-- *********************** -->
            <xsl:apply-templates select="content"/>

          <!-- ************************* -->
          <!-- Ende des Content-Bereichs -->
          <!-- ************************* -->
          </div>
        </div>
      </div>
      <xsl:apply-templates select="scripts"/>

    </body>
  </html>
  </xsl:template>

  <!-- *************************** -->
  <!-- Template Match für abstract -->
  <!-- *************************** -->
  <xsl:template match="abstract">
    <p></p>
      <xsl:value-of select="."/>
    <p></p>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für content -->
  <!-- ************************** -->
  <xsl:template match="content">
    <xsl:apply-templates select="headline"/>
    <xsl:apply-templates select="abstract"/>
    <xsl:apply-templates select="tableofcontent"/>
  </xsl:template>

  <!-- *************************** -->
  <!-- Template Match für headline -->
  <!-- *************************** -->
  <xsl:template match="headline">
    <h2><xsl:value-of select="."/></h2>
  </xsl:template>

  <!-- *********************** -->
  <!-- Template Match für html -->
  <!-- *********************** -->
  <xsl:template match="html">
    <div class="col-sm-2">
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="@link"/>
        </xsl:attribute>
        <xsl:if test="@type='topic'">
          <xsl:attribute name="class">alert-link</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="@name"/>
      </a>
    </div>
  </xsl:template>

  <!-- *********************** -->
  <!-- Template Match für item -->
  <!-- *********************** -->
  <xsl:template match="item">
    <div class="row">
        <xsl:apply-templates select="html"/>
        <xsl:apply-templates select="pdf"/>
    </div>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für links   -->
  <!-- ************************** -->
  <xsl:template match="links">
    <xsl:apply-templates select="link"/>
  </xsl:template>

  <!-- *********************** -->
  <!-- Template Match für link -->
  <!-- *********************** -->
  <xsl:template match="link">
    <link>
      <xsl:attribute name="rel">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </link>
  </xsl:template>

  <!-- *********************** -->
  <!-- Template Match für main -->
  <!-- *********************** -->
  <xsl:template match="main">
    <xsl:apply-templates select="topic"/>
  </xsl:template>

  <!-- ********************** -->
  <!-- Template Match für pdf -->
  <!-- ********************** -->
  <xsl:template match="pdf">
    <div class="col-sm-2">
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="@link"/>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </a>
    </div>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für scripts -->
  <!-- ************************** -->
  <xsl:template match="scripts">
    <xsl:apply-templates select="script"/>
  </xsl:template>

  <!-- ************************* -->
  <!-- Template Match für script -->
  <!-- ************************* -->
  <xsl:template match="script">
    <script>
      <xsl:attribute name="src">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </script>
  </xsl:template>

  <!-- ********************************* -->
  <!-- Template Match für tableofcontent -->
  <!-- ********************************* -->
  <xsl:template match="tableofcontent">
    <h3>Inhalt</h3>
    <xsl:apply-templates select="item"/>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für topic   -->
  <!-- ************************** -->
  <xsl:template match="topic">
    <li class="nav-item">
      <a class="nav-link">
        <xsl:attribute name="href">
          <xsl:value-of select="@link"/>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </a>
    </li>
  </xsl:template>

</xsl:stylesheet>
