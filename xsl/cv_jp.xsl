<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates select="cv"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="personalInformation">
        <div id="personalInfo">
            <h2><xsl:value-of select="titre"/></h2>
            <p><strong>名前:</strong> <xsl:value-of select="name"/></p>
            <p><strong>アドレス:</strong> <xsl:value-of select="address"/></p>
            <p><strong>メール:</strong> <a href="mailto:{email}"><xsl:value-of select="email"/></a></p>
        </div>
    </xsl:template>

    <xsl:template match="experience">
        <div id="experience">
            <h2>経験</h2>
            <xsl:apply-templates select="job"/>
        </div>
    </xsl:template>

    <xsl:template match="job">
        <div class="job">
            <h3><xsl:value-of select="title"/></h3>
            <p><strong>会社:</strong> <xsl:value-of select="company"/></p>
            <p><strong>年:</strong> <xsl:value-of select="year"/></p>
            <p><strong>説明:</strong> <xsl:value-of select="description"/></p>
        </div>
    </xsl:template>

    <xsl:template match="formation">
        <div id="education">
            <h2>教育</h2>
            <xsl:apply-templates select="education"/>
        </div>
    </xsl:template>

    <xsl:template match="education">
        <div class="education">
            <h3><xsl:value-of select="degree"/></h3>
            <p><strong>機関:</strong> <xsl:value-of select="institution"/></p>
            <p><strong>年:</strong> <xsl:value-of select="year"/></p>
            <xsl:if test="projects">
                <h4>プロジェクト</h4>
                <ul>
                    <xsl:apply-templates select="projects/project"/>
                </ul>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="project">
        <li><xsl:value-of select="."/></li>
    </xsl:template>

    <xsl:template match="skills">
        <div id="skills">
            <h2>スキル</h2>
            <xsl:apply-templates select="skill"/>
        </div>
    </xsl:template>

    <xsl:template match="skill">
        <div class="skill">
            <h3><xsl:value-of select="name"/></h3>
            <p><xsl:value-of select="details"/></p>
        </div>
    </xsl:template>

    <xsl:template match="languages">
        <div id="languages">
            <h2>言語</h2>
            <xsl:apply-templates select="language"/>
        </div>
    </xsl:template>

    <xsl:template match="language">
        <div class="language">
            <h3><xsl:value-of select="name"/></h3>
            <p><strong>レベル:</strong> <xsl:value-of select="level"/></p>
        </div>
    </xsl:template>

</xsl:stylesheet>
