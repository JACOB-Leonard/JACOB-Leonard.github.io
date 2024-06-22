<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link rel="stylesheet" type="text/css" href="style.css"/>
                <meta charset="UTF-8" />
                <title>Portfolio de Léonard JACOB</title>

                <link rel="stylesheet" href="style.css" />
                <meta name="description" content="Multilingual portfolio website" />
                <meta name="author" content="Léonard JACOB" />
            </head>
            <body>
                <div itemprop="author" itemtype="http://schema.org/Person">
                    <meta itemprop="name" content="Léonard JACOB" />
                    <meta itemprop="email" content="leonard.jacob@hotmail.com" />
                    <meta itemprop="sameAs" content="https://fr.linkedin.com/in/l%C3%A9onard-jacob-257a62228" />
                </div>
                <header>
                    <h1 id="title">Mon Portfolio</h1>
                </header>
            
                <nav>
                    <ul>
                        <li><a href="index.html" id="home-link">Accueil</a></li>
                        <li><a href="cv.html" id="cv-link">Consulter le CV</a></li>
                        <li id="lang-switcher">
                            <a href="?lang=fr"><img src="flags/fr.svg" alt="Français"/></a>
                            <a href="?lang=en"><img src="flags/en.svg" alt="English"/></a>
                            <a href="?lang=jp"><img src="flags/jp.svg" alt="日本語"/></a>
                        </li>
                    </ul>
                </nav>
                <xsl:apply-templates select="cv"/>
            </body>
        </html>
    </xsl:template>

    <!-- Correspondance pour la section d'informations personnelles -->
    <xsl:template match="personalInformation">
        <div id="personalInfo">
            <h2><xsl:value-of select="titre"/></h2>
            <p><strong>Nom:</strong> <xsl:value-of select="name"/></p>
            <p><strong>Adresse:</strong> <xsl:value-of select="address"/></p>
            <p><strong>Email:</strong> <a href="mailto:{email}"><xsl:value-of select="email"/></a></p>
        </div>
    </xsl:template>

    <!-- Correspondance pour la section d'expérience -->
    <xsl:template match="experience">
        <div id="experience">
            <h2>Expérience</h2>
            <xsl:apply-templates select="job"/>
        </div>
    </xsl:template>

    <!-- Correspondance pour chaque emploi -->
    <xsl:template match="job">
        <div class="job">
            <h3><xsl:value-of select="title"/></h3>
            <p><strong>Entreprise:</strong> <xsl:value-of select="company"/></p>
            <p><strong>Année:</strong> <xsl:value-of select="year"/></p>
            <p><strong>Description:</strong> <xsl:value-of select="description"/></p>
        </div>
    </xsl:template>

    <!-- Correspondance pour la section de formation -->
    <xsl:template match="formation">
        <div id="education">
            <h2>Formation</h2>
            <xsl:apply-templates select="education"/>
        </div>
    </xsl:template>

    <!-- Correspondance pour chaque éducation -->
    <xsl:template match="education">
        <div class="education">
            <h3><xsl:value-of select="degree"/></h3>
            <p><strong>Institution:</strong> <xsl:value-of select="institution"/></p>
            <p><strong>Année:</strong> <xsl:value-of select="year"/></p>
            <!-- Si des projets sont présents -->
            <xsl:if test="projets">
                <h4>Projets</h4>
                <ul>
                    <xsl:apply-templates select="projets/projet"/>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <!-- Correspondance pour chaque projet -->
    <xsl:template match="projet">
        <li><xsl:value-of select="."/></li>
    </xsl:template>

    <!-- Correspondance pour la section des compétences -->
    <xsl:template match="skills">
        <div id="skills">
            <h2>Compétences</h2>
            <xsl:apply-templates select="skill"/>
        </div>
    </xsl:template>

    <!-- Correspondance pour chaque compétence -->
    <xsl:template match="skill">
        <div class="skill">
            <h3><xsl:value-of select="name"/></h3>
            <p><xsl:value-of select="details"/></p>
        </div>
    </xsl:template>

    <!-- Correspondance pour la section des langues -->
    <xsl:template match="languages">
        <div id="languages">
            <h2>Langues</h2>
            <xsl:apply-templates select="language"/>
        </div>
    </xsl:template>

    <!-- Correspondance pour chaque langue -->
    <xsl:template match="language">
        <div class="language">
            <h3><xsl:value-of select="name"/></h3>
            <p><strong>Niveau:</strong> <xsl:value-of select="level"/></p>
        </div>
    </xsl:template>

</xsl:stylesheet>
