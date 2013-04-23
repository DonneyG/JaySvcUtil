﻿<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:edm="@@VERSIONNS@@" 
                xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata" 
                xmlns:annot="http://schemas.microsoft.com/ado/2009/02/edm/annotation" 
                xmlns:exsl="http://exslt.org/common" 
                xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:key name="entityType" match="edm:EntityType" use="concat(string(../@Namespace),'.', string(@Name))"/>
  <xsl:key name="associations" match="edm:Association" use="concat(string(../@Namespace),'.', string(@Name))"/>

  <xsl:strip-space elements="property item unprocessed"/>
  <xsl:output method="text" indent="no"  />
  <xsl:param name="contextNamespace" />

  <xsl:param name="SerivceUri" />
  <xsl:param name="EntityBaseClass"/>
  <xsl:param name="ContextBaseClass"/>
  <xsl:param name="AutoCreateContext"/>
  <xsl:param name="ContextInstanceName"/>
  <xsl:param name="EntitySetBaseClass"/>
  <xsl:param name="CollectionBaseClass"/>
  <xsl:param name="DefaultNamespace"/>

  <xsl:variable name="EdmJayTypeMapping">
    <map from="Edm.Boolean" to="bool" />
    <map from="Edm.Binary" to="Uint8Array" />
    <map from="Edm.DateTime" to="Date" />
    <map from="Edm.DateTimeOffset" to="Date" />
    <map from="Edm.Time" to="Date" />
    <map from="Edm.Decimal" to="string" />
    <map from="Edm.Single" to="number" />
    <map from="Edm.Float" to="number" />
    <map from="Edm.Double" to="number" />
    <map from="Edm.Guid" to="string" />
    <map from="Edm.Int16" to="number" />
    <map from="Edm.Int32" to="number" />
    <map from="Edm.Int64" to="string" />
    <map from="Edm.Byte" to="number" />
    <map from="Edm.SByte" to="number" />
    <map from="Edm.String" to="string" />
    <map from="Edm.GeographyPoint" to="$data.Geography" />
    <map from="Edm.GeographyLineString" to="$data.GeographyLineString" />
    <map from="Edm.GeographyPolygon" to="$data.GeographyPolygon" />
    <map from="Edm.GeographyMultiPoint" to="$data.GeographyMultiPoint" />
    <map from="Edm.GeographyMultiLineString" to="$data.GeographyMultiLineString" />
    <map from="Edm.GeographyMultiPolygon" to="$data.GeographyMultiPolygon" />
    <map from="Edm.GeographyCollection" to="$data.GeographyCollection" />
    <map from="Edm.GeometryPoint" to="$data.GeometryPoint" />
    <map from="Edm.GeometryLineString" to="$data.GeometryLineString" />
    <map from="Edm.GeometryPolygon" to="$data.GeometryPolygon" />
    <map from="Edm.GeometryMultiPoint" to="$data.GeometryMultiPoint" />
    <map from="Edm.GeometryMultiLineString" to="$data.GeometryMultiLineString" />
    <map from="Edm.GeometryMultiPolygon" to="$data.GeometryMultiPolygon" />
    <map from="Edm.GeometryCollection" to="$data.GeometryCollection" />
  </xsl:variable>

  <xsl:template match="/">///&lt;reference path="./jaydata.d.ts" /&gt;
/*//////////////////////////////////////////////////////////////////////////////////////
////// Autogenerated by JaySvcUtil.exe http://JayData.org for more info        /////////
//////                      oData @@VERSION@@ TypeScript                              /////////
//////////////////////////////////////////////////////////////////////////////////////*/

<xsl:for-each select="//edm:Schema"  xml:space="default">
module <xsl:value-of select="concat($DefaultNamespace,@Namespace)"/> {
<xsl:for-each select="edm:EntityType | edm:ComplexType" xml:space="default">
  <xsl:message terminate="no">Info: generating type <xsl:value-of select="concat(../@Namespace, '.', @Name)"/>
</xsl:message>
    <xsl:variable name="ctorprops">
    <xsl:apply-templates select="*">
      <xsl:with-param name="suffix" select="'?'" />
    </xsl:apply-templates>
  </xsl:variable>
  <xsl:variable name="props">
    <xsl:apply-templates select="*" />
  </xsl:variable>
  <xsl:variable name="keyprops">
    <xsl:apply-templates select="*">
      <xsl:with-param name="suffix" select="''" />
      <xsl:with-param name="keyProperties" select="'true'" />
    </xsl:apply-templates>
  </xsl:variable>
  <xsl:variable name="fullName">
    <xsl:value-of select="concat($DefaultNamespace,parent::edm:Schema/@Namespace)"/>.<xsl:value-of select="@Name"/>
  </xsl:variable>
  <xsl:variable name="BaseType">
    <xsl:choose>
      <xsl:when test="@BaseType">
        <xsl:value-of select="@BaseType"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$EntityBaseClass"  />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:text xml:space="preserve">  </xsl:text>class <xsl:value-of select="@Name"/> extends <xsl:value-of select="$BaseType"  /> {
    constructor ();
    constructor (initData: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$ctorprops" /></xsl:call-template>});
    <xsl:choose>
    <xsl:when test="function-available('msxsl:node-set')">
      <xsl:for-each select="msxsl:node-set($props)/*">
        <xsl:value-of select="."/>;
    </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="exsl:node-set($props)/*">
        <xsl:value-of select="."/>;
    </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:variable name="currentName"><xsl:value-of select="concat(../@Namespace,'.',@Name)"/></xsl:variable>
    <xsl:for-each select="//edm:FunctionImport[@IsBindable and edm:Parameter[1]/@Type = $currentName]">
      <xsl:apply-templates select="."><xsl:with-param name="skipParam" select="1"></xsl:with-param></xsl:apply-templates>;
    </xsl:for-each>
  }

  export interface <xsl:value-of select="@Name"/>Queryable extends $data.Queryable {
    filter(predicate:(it: <xsl:value-of select="$fullName"/>) => bool): <xsl:value-of select="$fullName"/>Queryable;
    filter(predicate:(it: <xsl:value-of select="$fullName"/>) => bool, thisArg: any): <xsl:value-of select="$fullName"/>Queryable;

    map(projection: (it: <xsl:value-of select="$fullName"/>) => any): <xsl:value-of select="$fullName"/>Queryable;

    length(): $data.IPromise;
    length(handler: (result: number) => void): $data.IPromise;
    length(handler: { success?: (result: number) => void; error?: (result: any) => void; }): $data.IPromise;

    forEach(handler: (it: <xsl:value-of select="$fullName"/>) => void ): $data.IPromise;
    
    toArray(): $data.IPromise;
    toArray(handler: (result: <xsl:value-of select="$fullName"/>[]) => void): $data.IPromise;
    toArray(handler: { success?: (result: <xsl:value-of select="$fullName"/>[]) => void; error?: (result: any) => void; }): $data.IPromise;

    single(predicate: (it: <xsl:value-of select="$fullName"/>, params?: any) => bool, params?: any, handler?: (result: <xsl:value-of select="$fullName"/>) => void): $data.IPromise;
    single(predicate: (it: <xsl:value-of select="$fullName"/>, params?: any) => bool, params?: any, handler?: { success?: (result: <xsl:value-of select="$fullName"/>[]) => void; error?: (result: any) => void; }): $data.IPromise;

    take(amout: number): <xsl:value-of select="$fullName"/>Queryable;
    skip(amout: number): <xsl:value-of select="$fullName"/>Queryable;

    order(selector: string): <xsl:value-of select="$fullName"/>Queryable;
    orderBy(predicate: (it: <xsl:value-of select="$fullName"/>) => any): <xsl:value-of select="$fullName"/>Queryable;
    orderByDescending(predicate: (it: <xsl:value-of select="$fullName"/>) => any): <xsl:value-of select="$fullName"/>Queryable;
    
    first(predicate: (it: <xsl:value-of select="$fullName"/>, params?: any) => bool, params?: any, handler?: (result: <xsl:value-of select="$fullName"/>) => void): $data.IPromise;
    first(predicate: (it: <xsl:value-of select="$fullName"/>, params?: any) => bool, params?: any, handler?: { success?: (result: <xsl:value-of select="$fullName"/>[]) => void; error?: (result: any) => void; }): $data.IPromise;
    
    include(selector: string): <xsl:value-of select="$fullName"/>Queryable;
    withInlineCount(): <xsl:value-of select="$fullName"/>Queryable;
    withInlineCount(selector: string): <xsl:value-of select="$fullName"/>Queryable;

    removeAll(): $data.IPromise;
    removeAll(handler: (count: number) => void): $data.IPromise;
    removeAll(handler: { success?: (result: number) => void; error?: (result: any) => void; }): $data.IPromise;
  }

<xsl:if test="local-name() != 'ComplexType'">
  export interface <xsl:value-of select="@Name"/>Set extends <xsl:value-of select="@Name"/>Queryable {
    add(initData: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$ctorprops" /></xsl:call-template>}): <xsl:value-of select="$fullName"/>;
    add(item: <xsl:value-of select="$fullName"/>): <xsl:value-of select="$fullName"/>;
    addMany(items: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$ctorprops" /></xsl:call-template>}[]): <xsl:value-of select="$fullName"/>[];
    addMany(items: <xsl:value-of select="$fullName"/>[]): <xsl:value-of select="$fullName"/>[];
  
    attach(item: <xsl:value-of select="$fullName"/>): void;
    attach(item: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$keyprops" /></xsl:call-template>}): void;
    attachOrGet(item: <xsl:value-of select="$fullName"/>): <xsl:value-of select="$fullName"/>;
    attachOrGet(item: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$keyprops" /></xsl:call-template>}): <xsl:value-of select="$fullName"/>;

    detach(item: <xsl:value-of select="$fullName"/>): void;
    detach(item: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$keyprops" /></xsl:call-template>}): void;

    remove(item: <xsl:value-of select="$fullName"/>): void;
    remove(item: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$keyprops" /></xsl:call-template>}): void;
    
    elementType: new (initData: { <xsl:call-template name="generateProperties"><xsl:with-param name="properties" select="$ctorprops" /></xsl:call-template>}) => <xsl:value-of select="$fullName"/>;
    
    <xsl:variable name="CollectionType" select="concat('Collection(', $currentName, ')')" />
    <xsl:for-each select="//edm:FunctionImport[edm:Parameter[1]/@Type = $CollectionType]">
      <xsl:apply-templates select="."><xsl:with-param name="skipParam" select="1"></xsl:with-param></xsl:apply-templates>;
    </xsl:for-each>
  }

</xsl:if>
</xsl:for-each>

<xsl:for-each select="edm:EntityContainer">
  <xsl:text xml:space="preserve">  </xsl:text>export class <xsl:value-of select="@Name"/> extends <xsl:value-of select="$ContextBaseClass"  /> {
    onReady(): $data.IPromise;
    onReady(handler: (context: <xsl:value-of select="@Name"/>) => void): $data.IPromise;
    <xsl:for-each select="edm:EntitySet | edm:FunctionImport[not(@IsBindable)]">
      <xsl:apply-templates select="." />;
    </xsl:for-each>
  }
</xsl:for-each>
<xsl:text>}
</xsl:text>
</xsl:for-each> 
    
</xsl:template>

  <xsl:template name="generateProperties">
    <xsl:param name="properties" />

    <xsl:choose>
      <xsl:when test="function-available('msxsl:node-set')">
        <xsl:for-each select="msxsl:node-set($properties)/*">
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="exsl:node-set($properties)/*">
          <xsl:value-of select="."/>
          <xsl:text>; </xsl:text>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="edm:Key"></xsl:template>

  <xsl:template match="edm:FunctionImport">
    <xsl:param name="skipParam" select="0"></xsl:param>
    <xsl:variable name="isCollection">
      <xsl:choose>
        <xsl:when test="starts-with(@ReturnType, 'Collection')">
          <xsl:value-of select="'true'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'false'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="elementType">
      <xsl:if test="$isCollection = 'true'">
        <xsl:call-template name="GetElementType">
          <xsl:with-param name="ReturnType" select="@ReturnType" />
          <xsl:with-param name="noResolve" select="'true'" />
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="canFilter">
      <xsl:choose>
        <xsl:when test="($isCollection = 'true' and not(starts-with($elementType, 'Edm')))">
          <xsl:value-of select="'true'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'false'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    

    <xsl:value-of select="@Name"/>
    <xsl:text>: </xsl:text>
    <!--<xsl:if test="$canFilter = 'true' or count(edm:Parameter) > $skipParam">-->
      <xsl:text>{</xsl:text>
    <!--</xsl:if>-->
    
    <xsl:choose>
      <xsl:when test="$canFilter = 'true'">
          <xsl:text>
      (</xsl:text>
          <xsl:for-each select="edm:Parameter[position() > $skipParam]">
            <xsl:value-of select="@Name"/>: <xsl:apply-templates select="@Type" mode="render-functionImport-type" />
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
          <xsl:text>): </xsl:text>
          <xsl:value-of select="$elementType"/>
          <xsl:text>Queryable;</xsl:text>

          <xsl:if test="count(edm:Parameter) > $skipParam">
          <xsl:text>
      (params?: { </xsl:text>
          <xsl:for-each select="edm:Parameter[position() > $skipParam]">
            <xsl:value-of select="@Name"/>?: <xsl:apply-templates select="@Type" mode="render-functionImport-type" />
            <xsl:text>; </xsl:text>
          </xsl:for-each>
          <xsl:text>}): </xsl:text>
          <xsl:value-of select="$elementType"/>
          <xsl:text>Queryable;</xsl:text>
          </xsl:if>
        
        
          <xsl:text>
      (</xsl:text>
          <xsl:for-each select="edm:Parameter[position() > $skipParam]">
            <xsl:value-of select="@Name"/>: <xsl:apply-templates select="@Type" mode="render-functionImport-type" /><xsl:text>, </xsl:text>
          </xsl:for-each>
          <xsl:text>handler: (</xsl:text>
          <xsl:apply-templates select="." mode="render-return-config" />
          <xsl:text>) => void): $data.IPromise;</xsl:text>

          <xsl:if test="count(edm:Parameter) > $skipParam">
          <xsl:text>
      (params: {</xsl:text>
          <xsl:for-each select="edm:Parameter[position() > $skipParam]">
            <xsl:value-of select="@Name"/>?: <xsl:apply-templates select="@Type" mode="render-functionImport-type" /><xsl:text>; </xsl:text>
          </xsl:for-each>
          <xsl:text>}, handler: (</xsl:text>
          <xsl:apply-templates select="." mode="render-return-config" />
          <xsl:text>) => void): $data.IPromise;</xsl:text>
          
          <xsl:text>
      (handler: (</xsl:text>
          <xsl:apply-templates select="." mode="render-return-config" />
          <xsl:text>) => void): $data.IPromise;</xsl:text>
        </xsl:if>
        
        <!--<xsl:text>}</xsl:text>-->
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>
      (</xsl:text>
        <xsl:for-each select="edm:Parameter[position() > $skipParam]">
          <xsl:value-of select="@Name"/>: <xsl:apply-templates select="@Type" mode="render-functionImport-type" /><xsl:text>, </xsl:text>
        </xsl:for-each>
        <xsl:text>handler?: (</xsl:text>
        <xsl:apply-templates select="." mode="render-return-config" />
        <xsl:text>) => void): $data.IPromise;</xsl:text>
        
        <xsl:if test="count(edm:Parameter) > $skipParam">
        <xsl:text>
      (params?: { </xsl:text>
        <xsl:for-each select="edm:Parameter[position() > $skipParam]">
          <xsl:value-of select="@Name"/>?: <xsl:apply-templates select="@Type" mode="render-functionImport-type" /><xsl:text>; </xsl:text>
        </xsl:for-each>
        <xsl:text>}, handler?: (</xsl:text>
        <xsl:apply-templates select="." mode="render-return-config" />
        <xsl:text>) => void): $data.IPromise;</xsl:text>
        </xsl:if>
        
      </xsl:otherwise>
    </xsl:choose>

    <!--<xsl:if test="$canFilter = 'true' or count(edm:Parameter) > $skipParam">-->
      <xsl:text>
    }</xsl:text>
    <!--</xsl:if>-->

    <!--<xsl:choose>
      <xsl:when test="$canFilter = 'true'">
        <xsl:text>) => void) => </xsl:text>
        <xsl:value-of select="$elementType"/>
        <xsl:text>Queryable</xsl:text>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>-->
  </xsl:template>

  <xsl:template match="@Type | @ReturnType" mode="render-functionImport-type">
    <xsl:variable name="curr" select="."/>
    <xsl:choose>
      <xsl:when test="//edm:Schema[starts-with($curr, @Namespace)]"> 
        <xsl:value-of select="concat($DefaultNamespace,$curr)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="resolveType">
          <xsl:with-param name="type" select="$curr" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  
  <xsl:template match="edm:FunctionImport" mode="render-return-config">
    <xsl:choose>
      <xsl:when test="not(@ReturnType)"></xsl:when>
      <xsl:when test="starts-with(@ReturnType, 'Collection')">
        <xsl:text>result: </xsl:text>
        <xsl:call-template name="GetElementType">
          <xsl:with-param name="ReturnType" select="@ReturnType" />
        </xsl:call-template>
        <xsl:text>[]</xsl:text>
      </xsl:when>
      <xsl:otherwise>result: <xsl:apply-templates select="@ReturnType" mode="render-functionImport-type" /></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="GetElementType">
    <xsl:param name="ReturnType" />
    <xsl:param name="noResolve" />

    <xsl:variable name="len" select="string-length($ReturnType)-12"/>
    <xsl:variable name="curr" select="substring($ReturnType,12,$len)"/>
    <xsl:choose>
      <xsl:when test="//edm:Schema[starts-with($curr, @Namespace)]">
        <xsl:value-of select="concat($DefaultNamespace,$curr)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$noResolve = ''">
            <xsl:call-template name="resolveType">
              <xsl:with-param name="type" select="$curr" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$curr"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="edm:EntitySet"><xsl:value-of select="@Name"/>: <xsl:value-of select="concat($DefaultNamespace,@EntityType)"/>Set</xsl:template>
  
  <xsl:template match="edm:Property | edm:NavigationProperty">
    <xsl:param name="suffix" />
    <xsl:param name="keyProperties" />
    <xsl:if test="$keyProperties != 'true' or parent::edm:EntityType/edm:Key/edm:PropertyRef[@Name = current()/@Name]">
      <property>
    <xsl:variable name="memberDefinition">
      <xsl:if test="parent::edm:EntityType/edm:Key/edm:PropertyRef[@Name = current()/@Name]"><attribute name="key">true</attribute></xsl:if>
      <xsl:apply-templates select="@*[local-name() != 'Name']" mode="render-field" />
    </xsl:variable>
      <xsl:value-of select="@Name"/><xsl:value-of select="$suffix"/>: <xsl:choose>
      <xsl:when test="function-available('msxsl:node-set')">
        <xsl:call-template name="propertyType">
          <xsl:with-param name="type" select="msxsl:node-set($memberDefinition)/*[@name = 'type']" />
          <xsl:with-param name="elementType" select="msxsl:node-set($memberDefinition)/*[@name = 'elementType']" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="propertyType">
          <xsl:with-param name="type" select="exsl:node-set($memberDefinition)/*[@name = 'type']" />
          <xsl:with-param name="elementType" select="exsl:node-set($memberDefinition)/*[@name = 'elementType']" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose></property>
    </xsl:if>
</xsl:template>
  <xsl:template name="propertyType">
    <xsl:param name="type" />
    <xsl:param name="elementType" />

    <xsl:choose>
      <xsl:when test="$elementType">
        <xsl:call-template name="resolveType">
          <xsl:with-param name="type" select="$elementType" />
        </xsl:call-template>
        <xsl:text>[]</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="resolveType">
          <xsl:with-param name="type" select="$type" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="resolveType">
    <xsl:param name="type" />
    <xsl:variable name="mapped">
      <xsl:choose>
        <xsl:when test="function-available('msxsl:node-set')">
          <xsl:value-of select="msxsl:node-set($EdmJayTypeMapping)/*[@from = $type]/@to"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="exsl:node-set($EdmJayTypeMapping)/*[@from = $type]/@to"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$mapped != ''">
        <xsl:value-of select="$mapped"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="@Name" mode="render-field">
  </xsl:template>

  <xsl:template match="@Type" mode="render-field">
    <xsl:choose>
      <xsl:when test="starts-with(., 'Collection')">
        <attribute name="type">Array</attribute>
        <xsl:variable name="len" select="string-length(.)-12"/>
        <xsl:variable name="currType" select="substring(.,12,$len)"/>
        <xsl:choose>
          <xsl:when test="starts-with($currType, ../../../@Namespace)">
            <attribute name="elementType"><xsl:value-of select="$DefaultNamespace"/><xsl:value-of select="$currType" /></attribute>
          </xsl:when>
          <xsl:otherwise>
            <attribute name="elementType"><xsl:value-of select="$currType" /></attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="starts-with(., ../../../@Namespace)">
        <attribute name="type"><xsl:value-of select="$DefaultNamespace"/><xsl:value-of select="."/></attribute>
      </xsl:when>
      <xsl:otherwise>
        <attribute name="type"><xsl:value-of select="."/></attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@ConcurrencyMode" mode="render-field">
    <attribute name="concurrencyMode">$data.ConcurrencyMode.<xsl:value-of select="."/></attribute>
  </xsl:template>

  <xsl:template match="@Nullable" mode="render-field">
    <attribute name="nullable"><xsl:value-of select="."/></attribute>
    
    <xsl:if test=". = 'false'">
      <xsl:choose>
        <xsl:when test="parent::edm:Property/@annot:StoreGeneratedPattern = 'Identity' or parent::edm:Property/@annot:StoreGeneratedPattern = 'Computed'"></xsl:when>
        <xsl:otherwise><attribute name="required">true</attribute></xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@annot:StoreGeneratedPattern" mode="render-field">
    <xsl:if test=". != 'None'"><attribute name="computed">true</attribute></xsl:if>    
  </xsl:template>

  <xsl:template match="@MaxLength" mode="render-field">
    <attribute name="maxLength">
      <xsl:choose>
        <xsl:when test="string(.) = 'Max'">Number.POSITIVE_INFINITY</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </attribute>
  </xsl:template>

  <xsl:template match="@FixedLength | @Unicode | @Precision | @Scale" mode="render-field">
  </xsl:template>
  <xsl:template match="@*" mode="render-field">
    <xsl:variable name="nameProp">
      <xsl:choose>
        <xsl:when test="substring-after(name(), ':') != ''">
          <xsl:value-of select="substring-after(name(), ':')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="name()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="attribute"><xsl:attribute name="extended">true</xsl:attribute><xsl:attribute name="name"><xsl:value-of select="$nameProp"/></xsl:attribute>'<xsl:value-of select="."/>'</xsl:element>
  </xsl:template>

  <xsl:template match="@Relationship" mode="render-field">
    <xsl:variable name="relationName" select="string(../@ToRole)"/>
    <xsl:variable name="relationshipName" select="string(.)" />
    <xsl:variable name="relation" select="key('associations',string(.))/edm:End[@Role = $relationName]" />
    <xsl:variable name="otherName" select="../@FromRole" />
    <xsl:variable name="otherProp" select="//edm:NavigationProperty[@ToRole = $otherName and @Relationship = $relationshipName]" />
    <xsl:variable name="m" select="$relation/@Multiplicity" />
    <xsl:choose>
      <xsl:when test="$m = '*'">
        <attribute name="type"><xsl:value-of select="$CollectionBaseClass"/></attribute>
        <attribute name="elementType"><xsl:value-of select="$DefaultNamespace"/><xsl:value-of select="$relation/@Type"/></attribute>
        <xsl:if test="not($otherProp/@Name)">
          <attribute name="inverseProperty">'$$unbound'</attribute></xsl:if>
        <xsl:if test="$otherProp/@Name">
          <attribute name="inverseProperty"><xsl:value-of select="$otherProp/@Name"/></attribute></xsl:if>
      </xsl:when>
      <xsl:when test="$m = '0..1'">
        <attribute name="type"><xsl:value-of select="$DefaultNamespace"/><xsl:value-of select="$relation/@Type"/></attribute>
        <xsl:choose>
          <xsl:when test="$otherProp">
            <attribute name="inverseProperty"><xsl:value-of select="$otherProp/@Name"/></attribute>
          </xsl:when >
          <xsl:otherwise>
            <attribute name="inverseProperty">'$$unbound'</attribute>
            <xsl:message terminate="no">  Warning: inverseProperty other side missing: <xsl:value-of select="."/>
          </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$m = '1'">
        <attribute name="type"><xsl:value-of select="$DefaultNamespace"/><xsl:value-of select="$relation/@Type"/></attribute>
        <attribute name="required">true</attribute>
        <xsl:choose>
          <xsl:when test="$otherProp">
            <attribute name="inverseProperty">'<xsl:value-of select="$otherProp/@Name"/>'</attribute>
          </xsl:when >
          <xsl:otherwise>
            <attribute name="inverseProperty">'$$unbound'</attribute>
            <xsl:message terminate="no">
              Warning: inverseProperty other side missing: <xsl:value-of select="."/>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="@FromRole | @ToRole" mode="render-field"></xsl:template>

  <xsl:template match="*" mode="render-field">
    <!--<unprocessed>!!<xsl:value-of select="name()"/>!!</unprocessed>-->
    <xsl:message terminate="no">  Warning: <xsl:value-of select="../../@Name"/>.<xsl:value-of select="../@Name"/>:<xsl:value-of select="name()"/> is an unknown/unprocessed attribued</xsl:message>
  </xsl:template>
  <!--<xsl:template match="*">
    !<xsl:value-of select="name()"/>!
  </xsl:template>-->
</xsl:stylesheet>
