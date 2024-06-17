<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- ドキュメント全体に対するルール -->
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <link rel="stylesheet" type="text/css" href="style.css"/>
                <meta charset="UTF-8" />
                <title>マルチリンガルポートフォリオ</title>
                <link rel="alternate" hreflang="en" href="index.html?lang=en" />
                <link rel="alternate" hreflang="fr" href="index.html?lang=fr" />
                <link rel="alternate" hreflang="jp" href="index.html?lang=jp" />
                <link rel="stylesheet" href="style.css" />
            </head>
            <body>
                <header>
                    <h1 id="title"></h1>
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

    <!-- 個人情報セクションに対するマッチング -->
    <xsl:template match="personalInformation">
        <div id="personalInfo">
            <h2><xsl:value-of select="titre"/></h2>
            <p><strong>名前:</strong> <xsl:value-of select="name"/></p>
            <p><strong>アドレス:</strong> <xsl:value-of select="address"/></p>
            <p><strong>メール:</strong> <a href="mailto:{email}"><xsl:value-of select="email"/></a></p>
        </div>
    </xsl:template>

    <!-- 経験セクションに対するマッチング -->
    <xsl:template match="experience">
        <div id="experience">
            <h2>経験</h2>
            <xsl:apply-templates select="job"/>
        </div>
    </xsl:template>

    <!-- 各ジョブに対するマッチング -->
    <xsl:template match="job">
        <div class="job">
            <h3><xsl:value-of select="title"/></h3>
            <p><strong>会社:</strong> <xsl:value-of select="company"/></p>
            <p><strong>年:</strong> <xsl:value-of select="year"/></p>
            <p><strong>説明:</strong> <xsl:value-of select="description"/></p>
        </div>
    </xsl:template>

    <!-- 教育セクションに対するマッチング -->
    <xsl:template match="formation">
        <div id="education">
            <h2>教育</h2>
            <xsl:apply-templates select="education"/>
        </div>
    </xsl:template>

    <!-- 各教育に対するマッチング -->
    <xsl:template match="education">
        <div class="education">
            <h3><xsl:value-of select="degree"/></h3>
            <p><strong>機関:</strong> <xsl:value-of select="institution"/></p>
            <p><strong>年:</strong> <xsl:value-of select="year"/></p>
            <!-- プロジェクトがある場合 -->
            <xsl:if test="projects">
                <h4>プロジェクト</h4>
                <ul>
                    <xsl:apply-templates select="projects/project"/>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <!-- 各プロジェクトに対するマッチング -->
    <xsl:template match="project">
        <li><xsl:value-of select="."/></li>
    </xsl:template>

    <!-- スキルセクションに対するマッチング -->
    <xsl:template match="skills">
        <div id="skills">
            <h2>スキル</h2>
            <xsl:apply-templates select="skill"/>
        </div>
    </xsl:template>

    <!-- 各スキルに対するマッチング -->
    <xsl:template match="skill">
        <div class="skill">
            <h3><xsl:value-of select="name"/></h3>
            <p><xsl:value-of select="details"/></p>
        </div>
    </xsl:template>

    <!-- 言語セクションに対するマッチング -->
    <xsl:template match="languages">
        <div id="languages">
            <h2>言語</h2>
            <xsl:apply-templates select="language"/>
        </div>
    </xsl:template>

    <!-- 各言語に対するマッチング -->
    <xsl:template match="language">
        <div class="language">
            <h3><xsl:value-of select="name"/></h3>
            <p><strong>レベル:</strong> <xsl:value-of select="level"/></p>
        </div>
    </xsl:template>

</xsl:stylesheet>
