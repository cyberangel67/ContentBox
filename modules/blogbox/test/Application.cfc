﻿<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/16/2007
Description :
	This is the Application.cfc for usage withing the ColdBox Framework.
	Make sure that it extends the coldbox object:
	coldbox.system.Coldbox
	
	So if you have refactored your framework, make sure it extends coldbox.
----------------------------------------------------------------------->
<cfcomponent output="false">
	<!--- APPLICATION CFC PROPERTIES --->
	<cfset this.name = "BlogBoxTestingSuite" & hash(getCurrentTemplatePath())> 
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,30,0)>
	<cfset this.setClientCookies = true>
	
	<cfscript>
	// ORM Settings
	this.ormEnabled = true;
	// FILL OUT: THE DATASOURCE OF BLOGBOX
	this.datasource = "blogbox";
	// FILL OUT: THE LOCATION OF THE BLOG BOX MODULE
	this.mappings["/blogbox"] 	= replacenocase(getDirectoryFromPath(getCurrentTemplatePath()),"test/","");
	this.mappings["/blogbox"] 	= replacenocase(getDirectoryFromPath(getCurrentTemplatePath()),"test/","");
	this.ormSettings = {
		cfclocation=["/blogbox"],
		// FILL OUT: THE DIALECT OF YOUR DATABASE
		dialect 			= "MySQLwithInnoDB",
		logSQL 				= true,
		flushAtRequestEnd 	= false,
		autoManageSession	= false,
		eventHandling 		= true
	};
	
	public boolean function onRequestStart(String targetPage){
		// ORM Reload
		if( structKeyExists(url,"ormReload") ){ ormReload(); }
		return true;
	}
	</cfscript>
</cfcomponent>