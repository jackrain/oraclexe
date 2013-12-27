<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head/>
			<body>
				<xsl:for-each select="tree">
					<div>
						<xsl:for-each select="node">
							<xsl:if test="position()=1">
								<xsl:text disable-output-escaping="yes">&lt;table border="1"&gt;</xsl:text>
							</xsl:if>
							<xsl:if test="position()=1">
								<thead>
									<tr>
										<td>name</td>
										<td>parent</td>
										<td>label</td>
										<td>icon</td>
										<td>url</td>
										<td>directory</td>
									</tr>
								</thead>
							</xsl:if>
							<xsl:if test="position()=1">
								<xsl:text disable-output-escaping="yes">&lt;tbody&gt;</xsl:text>
							</xsl:if>
							<tr>
								<td>
									<xsl:for-each select="name">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
								<td>
									<xsl:for-each select="parent">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
								<td>
									<xsl:for-each select="label">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
								<td>
									<xsl:for-each select="icon">
										<select size="0">
											<option value=" /images/NDS_folder_sub.gif">树叶</option>
											<option value=" /images/NDS_folder_main.gif">树枝</option>
										</select>
									</xsl:for-each>
								</td>
								<td>
									<xsl:for-each select="url">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
								<td>
									<xsl:for-each select="directory">
										<xsl:apply-templates/>
									</xsl:for-each>
								</td>
							</tr>
							<xsl:if test="position()=last()">
								<xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>
							</xsl:if>
							<xsl:if test="position()=last()">
								<xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
							</xsl:if>
						</xsl:for-each>
					</div>
				</xsl:for-each><br/>
				<br/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="directory">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
