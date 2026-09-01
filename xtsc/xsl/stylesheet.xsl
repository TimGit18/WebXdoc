<?xml version="1.0" encoding="utf-8" standalone='yes'?>
<!DOCTYPE stylesheet [
<!ENTITY rArr
"<xsl:text disable-output-escaping='yes'>&amp;rArr;</xsl:text>" >
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output encoding="utf-8" method="html"/>
  <xsl:template match="document">
  <html lang="de">

    <!-- *********************************** -->
  	<!-- Header mit Viewport und Stylesheets -->
    <!-- *********************************** -->
    <head>
      <title><xsl:value-of select="title"/></title>
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
      <div class="container">
        <div class="row">

          <!-- ************************************************************* -->
          <!-- Seitliche, feste Navigationsleiste für das Inhaltsverzeichnis -->
          <!-- ************************************************************* -->
          <div class="col-sm-2 bg-light">
            <figure class="figure">
              <img class="figure-img img-fluid rounded" src="http://localhost:8080/xdoc/Ressources/getsitelogo.png"/>
            </figure>   
            <nav id="toc" class="sticky-top" data-toggle="toc"></nav>
          </div>

          <!-- **************************** -->
          <!-- Eigentlicher Content-Bereich -->
          <!-- **************************** -->
          <div class="col-sm-10">

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

  <!-- ********* -->
  <!-- Bold font -->
  <!-- ********* -->
  <xsl:template match="bold">
    <p></p><b>
      <xsl:value-of select="."/>
    </b><p></p>
  </xsl:template>

  <!-- ******* -->
  <!-- Codebox -->
  <!-- ******* -->
  <xsl:template match="codebox">
    <pre><code>
      <xsl:value-of select="."/>
    </code></pre>
  </xsl:template>

  <!-- ******** -->
  <!-- Codeline -->
  <!-- ******** -->
  <xsl:template match="codeline">
    <pre><code>
      <xsl:value-of select="."/>
    </code></pre>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für content -->
  <!-- ************************** -->
  <xsl:template match="content">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- ******* -->
  <!-- Figure  -->
  <!-- ******* -->
  <xsl:template match="figure">
    <figure class="figure">
      <xsl:apply-templates select="image"/>
      <xsl:apply-templates select="figurecaption"/>
    </figure>
  </xsl:template>

  <!-- ************* -->
  <!-- Figurecaption -->
  <!-- ************* -->
  <xsl:template match="figurecaption">
    <figcaption class="figure-caption text-left">
      <xsl:value-of select="."/>
    </figcaption>
  </xsl:template>

  <!-- ***** -->
  <!-- Image -->
  <!-- ***** -->
  <xsl:template match="image">
    <img class="figure-img img-fluid rounded">
       <xsl:attribute name="src">
          <xsl:value-of select="@link"/>
       </xsl:attribute>
    </img>
  </xsl:template>

  <!-- *************************** -->
  <!-- Template Match für headline -->
  <!-- *************************** -->
  <xsl:template match="headline">
    <h2><xsl:value-of select="."/></h2>
  </xsl:template>

  <!-- ***************************** -->
  <!-- Template Match für hyperlinks -->
  <!-- ***************************** -->
  <xsl:template match="hyperlinks">
    <p></p><xsl:apply-templates/><p></p>
  </xsl:template>

  <!-- **************************** -->
  <!-- Template Match für hyperlink -->
  <!-- **************************** -->
  <xsl:template match="hyperlink">
    <div>
      <a>
      <xsl:attribute name="href">
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="@name"/>
      </a>
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

  <!-- ******************************** -->
  <!-- Template Match für (Simple) list -->
  <!-- ******************************** -->
  <xsl:template match="list">
    <ul><xsl:apply-templates select="listitem"/></ul>
  </xsl:template>

  <!-- *************************** -->
  <!-- Template Match für listitem -->
  <!-- *************************** -->
  <xsl:template match="listitem">
    <li><xsl:value-of select="."/></li>
  </xsl:template>

  <!-- ********************************************* -->
  <!-- Template Match für main (Hauptnavigation)     -->
  <!-- ********************************************* -->
  <xsl:template match="main">
    <xsl:apply-templates select="topic"/>
  </xsl:template>

  <!-- ******************************** -->
  <!-- Template Match für Numbered List -->
  <!-- ******************************** -->
  <xsl:template match="numlist">
    <ol><xsl:apply-templates select="listitem"/></ol>
  </xsl:template>

  <!-- ************************** -->
  <!-- Template Match für scripts -->
  <!-- ************************** -->
  <xsl:template match="scripts">
    <xsl:apply-templates select="script"/>
  </xsl:template>

  <!-- ****** -->
  <!-- Script -->
  <!-- ****** -->
  <xsl:template match="script">
    <script>
      <xsl:attribute name="src">
        <xsl:value-of select="."/>
      </xsl:attribute>
    </script>
  </xsl:template>

  <!-- ******** -->
  <!-- Sequence -->
  <!-- ******** -->
  <xsl:template match="sequence">
    <dl class="row">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>

  <!-- ************* -->
  <!-- Sequence Line -->
  <!-- ************* -->
  <xsl:template match="sequenceline">
    <dt class="col-sm-2">
      <xsl:value-of select="@start"/>
    </dt>
    <dd class="col-sm-1">&rArr;
    </dd>
    <dd class="col-sm-4">
      <xsl:choose>
         <xsl:when test="@dialogue='yes'">
           <b>
             <xsl:value-of select="@target"/>
           </b>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="@target"/>
         </xsl:otherwise>
      </xsl:choose>
    </dd>
    <dd class="col-sm-5">
      <xsl:value-of select="@comment"/>
    </dd>
  </xsl:template>

  <!-- ************* -->
  <!-- Sequence Item -->
  <!-- ************* -->
  <xsl:template match="sequenceitem">
    <dt class="col-sm-2">
    </dt>
    <dd class="col-sm-1">
    </dd>
    <dd class="col-sm-4">
        <xsl:value-of select="@target"/>
    </dd>
    <dd class="col-sm-5">
      <xsl:value-of select="@comment"/>
    </dd>
  </xsl:template>

  <!-- **************** -->
  <!-- Subüberschriften -->
  <!-- **************** -->
  <xsl:template match="subheadline">
    <h3><xsl:value-of select="."/></h3>
  </xsl:template>

  <!-- ***** -->
  <!-- Table -->
  <!-- ***** -->
  <xsl:template match="table">
    <p></p>
    <table class="table table-hover table-responsive-sm">
      <xsl:apply-templates select="tableheadline"/>
      <xsl:apply-templates select="tablebody"/>
    </table>
    <p></p>
  </xsl:template>

  <!-- ********** -->
  <!-- Table Body -->
  <!-- ********** -->
  <xsl:template match="tablebody">
    <tbody>
      <xsl:apply-templates select="tablerow"/>
      <xsl:apply-templates select="tablecaption"/>
    </tbody>
  </xsl:template>

  <!-- ************* -->
  <!-- Table Caption -->
  <!-- ************* -->
  <xsl:template match="tablecaption">
    <caption>
        <xsl:value-of select="."/>
    </caption>
  </xsl:template>

  <!-- ************** -->
  <!-- Table Headline -->
  <!-- ************** -->
  <xsl:template match="tableheadline">
    <thead class="thead-light">
      <xsl:apply-templates select="tablerow"/>
    </thead>
  </xsl:template>

  <!-- ********* -->
  <!-- Table Row -->
  <!-- ********* -->
  <xsl:template match="tablerow">
    <tr>
      <xsl:for-each select="tableheaditem">
        <th>
          <xsl:value-of select="."/>
        </th>
      </xsl:for-each>
    </tr>
    <tr>
      <xsl:for-each select="tableitem">
        <td>
          <xsl:value-of select="."/>
        </td>
      </xsl:for-each>
    </tr>
  </xsl:template>

  <!-- ********* -->
  <!-- Textblock -->
  <!-- ********* -->
  <xsl:template match="text">
    <p></p>
      <xsl:value-of select="."/>
    <p></p>
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
