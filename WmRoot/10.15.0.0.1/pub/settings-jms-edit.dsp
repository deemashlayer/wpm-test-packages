<html>
<head>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<meta http-equiv="Expires" content="-1">

<link rel="stylesheet" TYPE="text/css" HREF="webMethods.css">
%ifvar webMethods-wM-AdminUI%
  <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
  <script>webMethods_wM_AdminUI = 'true';</script>
%endif%
<script src="webMethods.js"></script>

%invoke wm.server.jms:getConnectionAliasReport%

<script language ="javascript">

/**
 * displaySettings
 */ 
function displaySettings(object) {

    if (object.options[object.selectedIndex].value == "0") {
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';
    }else if (object.options[object.selectedIndex].value == "1") {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'block';
    }else {
        document.all.div1.style.display = 'none';
        document.all.div2.style.display = 'none';
    }
}

/**
 * onChange - capture change made to the producer cache mode
 */
function producerModeSettings(object) {

    if (object.value == 0) { // disabled
        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'none';
    }else if (object.value == 1) { // enabled     
        document.getElementById('divCacheEnabled').style.display = 'block';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'block';
    }else if (object.value == 2) { // per destination
        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'block';
        document.getElementById('divCacheEnabled2').style.display = 'none';
    }
}

/**
 * displayPollingInterval
 */
function displayPollingInterval(object) {

    if (object.options[object.selectedIndex].value == "CLIENT_POLL") {
        document.all.divPoll.style.display = 'block';

        // when Monitor type is changed to client polling set polling interval to default, but
        // if already saved as client polling display saved value.
        if (document.editform.jndi_connectionFactoryPollingInterval.value < 1) {
            document.editform.jndi_connectionFactoryPollingInterval.value = 1440;
        }
    }else {
        document.all.divPoll.style.display = 'none';
    }
}

/**
 * loadDocument
 */ 
function loadDocument() {

    setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_JMSaliasEditScrn');

    for (i=0; i<document.editform.classLoader.options.length; i++) {
      if ("PACKAGE: %value classLoader encode(javascript)%" == document.editform.classLoader.options[i].text) {
        document.editform.classLoader.selectedIndex=i;
      }
    }
  
    %switch transactionType%
    %case '0'%
      document.editform.transactionType.selectedIndex=0;
    %case '1'%
      document.editform.transactionType.selectedIndex=1;
    %case '2'%
      document.editform.transactionType.selectedIndex=2;
    %end%

    for (i=0; i<document.editform.jndi_connectionFactoryUpdateType.options.length; i++) {
      if ("%value jndi_connectionFactoryUpdateType encode(javascript)%" == document.editform.jndi_connectionFactoryUpdateType.options[i].value) {
        document.editform.jndi_connectionFactoryUpdateType.selectedIndex=i;
      }
    }

    for (i=0; i<document.editform.jndi_jndiAliasName.options.length; i++) {
      if ("%value jndi_jndiAliasName encode(javascript)%" == document.editform.jndi_jndiAliasName.options[i].text) {
          document.editform.jndi_jndiAliasName.selectedIndex=i;
      }
    }

    %ifvar associationType equals('0')%
        document.editform.associationType.selectedIndex=0;
        document.all.div1.style.display = 'block';
        document.all.div2.style.display = 'none';

        %ifvar jndi_connectionFactoryUpdateType equals('CLIENT_POLL')%
            document.all.divPoll.style.display = 'block';
        %else%
            document.all.divPoll.style.display = 'none';
        %endif%
    %else%
        document.editform.associationType.selectedIndex=1;
        document.all.div1.style.display = 'none';
        document.all.divPoll.style.display = 'none';
        document.all.div2.style.display = 'block';
    %endif%

    %switch nwm_keystoreType%
        %case 'JKS'%
            document.editform.nwm_keystoreType.selectedIndex=1;
        %case 'PKCS12'%
            document.editform.nwm_keystoreType.selectedIndex=2;
    %end%
  
    %switch nwm_truststoreType%
        %case 'JKS'%
            document.editform.nwm_truststoreType.selectedIndex=1;
    %end%

    /*
     * Producer Caching 
     */

    %ifvar producerCachingMode equals('0')%
        document.editform.producerCachingMode.selectedIndex=0;

        document.getElementById('divCacheEnabled').style.display = 'none';
        document.getElementById('divCacheEnabledPer').style.display = 'none';
        document.getElementById('divCacheEnabled2').style.display = 'none';

        // set defaults values for the other options
        document.editform.producerSessionPoolMinSize_divCacheEnabled.value = '1';
        document.editform.producerSessionPoolSize_divCacheEnabled.value = '30';
        document.editform.producerSessionPoolMinSize_divCacheEnabledPer.value = '1';
        document.editform.producerSessionPoolSize_divCacheEnabledPer.value = '30';

        //document.editform.cacheProducersPoolMinSize_divCacheEnabledPer.value = '';
        //document.editform.cacheProducersPoolSize_divCacheEnabledPer.value = '';
    %else%
        %ifvar producerCachingMode equals('1')%
            // this feature is not implemented yet, so skip its index
            document.getElementById('divCacheEnabled').style.display = 'block';
            document.getElementById('divCacheEnabledPer').style.display = 'none';
            document.getElementById('divCacheEnabled2').style.display = 'block';
        %else%
            document.editform.producerCachingMode.selectedIndex=1;
            document.getElementById('divCacheEnabled').style.display = 'none';
            document.getElementById('divCacheEnabledPer').style.display = 'block';
            document.getElementById('divCacheEnabled2').style.display = 'none';
        %endif%
    %endif%
}

/**
 * validateForm
 */ 
function validateForm(obj) {

    var associationTypeElem = obj.associationType;
    var associationTypeValue = associationTypeElem.options[associationTypeElem.selectedIndex].value;

    if (obj.description.value == "") {
        alert("Description must be specified.");
        return false;
    }

    if (associationTypeValue == '0') {
        if (obj.jndi_jndiAliasName.options.length == 0) {
            alert("No JNDI Provider Aliases are configured. You must first create a JNDI Provider Alias via Settings - Messaging - JNDI Settings.");
            return false;
        }
        if (obj.jndi_connectionFactoryLookupName.value == "") {
            alert("Connection Factory Lookup Name must be specified.");
            return false;
        }
        if (obj.jndi_connectionFactoryUpdateType.value == "CLIENT_POLL"
                && (obj.jndi_connectionFactoryPollingInterval.value == '0' || !isInt(obj.jndi_connectionFactoryPollingInterval.value))) {
            alert("Polling Interval must be a positive integer.");
            return false;
        }
    }else {
        if(obj.nwm_brokerHost.value == "") {
            alert("Broker Host must be specified.");
            return false;
        }
        if(obj.nwm_brokerName.value == "") {
            alert("Broker Name must be specified.");
            return false;
        }
        if(obj.nwm_clientGroup.value == "") {
            alert("Client Group must be specified.");
            return false;
        }
        if(obj.clientID.value == "") {
            alert("Connection Client ID must be specified when connecting via Native webMethods API");
            return false;
        }
    }

    if(obj.clientID.value != "") {
          var regex=/^([A-Za-z][_A-Za-z0-9$]*)$/;
          if(!regex.test(obj.clientID.value)) {
            alert("Connection Client ID must contain only letters, digits, underscores and dollar characters; and it must start with a letter.");
            return false;
        }
    }
    if (obj.csqSize.value != "" && obj.csqSize.value != "-1" && !isInt(obj.csqSize.value)) {
        alert("Maximum CSQ Size must be a positive integer, 0, or -1. A value of -1 indicates that the CSQ Size is unlimited.");
        return false;
    }

    /*
     * Producer Caching Validation
     */

    var cacheMode = document.all.editform.producerCachingMode.value;
    var timeout;

    if (cacheMode == 1) { // enabled
      
        var minpool = document.all.editform.producerSessionPoolMinSize_divCacheEnabled.value;
        var maxpool = document.all.editform.producerSessionPoolSize_divCacheEnabled.value;

        var int_minpool = parseInt(minpool);
        var int_maxpool = parseInt(maxpool);

        timeout = document.all.editform.poolTimeout_divCacheEnabled.value;

        if (maxpool == '' || int_maxpool < 1) {
            alert("Maximum Pool Size is required and must be a positive integer.");
            return false;
        }

        if ( (minpool != '') && (!isInt(minpool)) ) {
            alert("Minimum Pool Size must be a nonnegative integer.");
            return false;
        }

        if (!isInt(maxpool)) {
            alert("Maximum Pool Size must be a positive integer.");
            return false;
        }

        if (int_minpool > int_maxpool) {
            alert("Minimum Pool Size cannot be greater than Maximum Pool Size.");
              return false;
        }

        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }

    }else if (cacheMode == 2) { // enabled per destination
      
        var minpoolPerDefault = document.all.editform.producerSessionPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPerDefault = document.all.editform.producerSessionPoolSize_divCacheEnabledPer.value;
        var minpoolPer = document.all.editform.cacheProducersPoolMinSize_divCacheEnabledPer.value;
        var maxpoolPer = document.all.editform.cacheProducersPoolSize_divCacheEnabledPer.value;

        var int_minpoolPerDefault = parseInt(minpoolPerDefault);
        var int_maxpoolPerDefault = parseInt(maxpoolPerDefault);
        var int_minpoolPer = parseInt(minpoolPer);
        var int_maxpoolPer = parseInt(maxpoolPer);

        if (maxpoolPerDefault == '' || int_maxpoolPerDefault < 1) {
            alert("Maximum Pool Size (unspecified destinations) is required and must be a positive integer.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (!isInt(minpoolPerDefault)) ) {
            alert("Minimum Pool Size (unspecified destinations) must be a nonnegative integer.");
            return false;
        }

        if (!isInt(maxpoolPerDefault)) {
            alert("Maximum Pool Size (unspecified destinations) must be a positive integer.");
            return false;
        }

        if ( (minpoolPerDefault != '') && (int_minpoolPerDefault > int_maxpoolPerDefault) ) {
            alert("Minimum Pool Size (unspecified destinations) cannot be greater than Maximum (unspecified destinations) Pool Size.");
              return false;
        }

        if ( (minpoolPer != '') && (!isInt(minpoolPer)) ) {
            alert("Minimum Pool Size Per Destination must be a nonnegative integer.");
            return false;
        }

        if ( (maxpoolPer != '') && (!isInt(maxpoolPer)) ) {
            alert("Maximum Pool Size Per Destination must be a positive integer.");
            return false;
        }

        if (int_minpoolPer > int_maxpoolPer) {
            alert("Minimum Pool Size Per Destination cannot be greater than Maximum Pool Size Per Destination.");
              return false;
        }

        var queuelist = '';
        var topiclist = '';
        var destMsg = "The Maximum Pool Size Per Destination and at least one destination are required to enable per destination pooling.  To disable per destination pooling, set Maximum Pool Size Per Destination and the destination list(s) to blank."

        if ("%value associationType encode(javascript)%" == '1') { //WM

            queuelist = document.all.editform.cacheProducersQueueList_divCacheEnabledPer.value;
            topiclist = document.all.editform.cacheProducersTopicList_divCacheEnabledPer.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '' && topiclist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '' || topiclist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }else {

            queuelist = document.all.editform.cacheProducersQueueList_divCacheEnabledPer.value;

            if (maxpoolPer != '' && maxpoolPer != '0' && queuelist == '') {
                alert(destMsg);
                return false;
            }

            if ( (queuelist != '') && (maxpoolPer == '' || maxpoolPer == '0') ) {
                alert(destMsg);
                return false;
            }

        }
        timeout = document.all.editform.poolTimeout_divCacheEnabledPer.value;
        if ( (timeout != '') && (!isInt(timeout)) && (timeout != "-1") ) {
            alert("Idle Timeout must be a positive integer, 0, or -1. A value of 0 indicates the pool entry will never expire. A value of -1 indicates the system default will be used.");
            return false;
        }
     }
    
    /*
     * Producer Retry Validation
     */
     
    if (obj.producerMaxRetryAttempts.value != "" && !isInt(obj.producerMaxRetryAttempts.value)) {
        alert("Max Retry Attempts must be a positive integer.");
        return false;
    }
    
    if (obj.producerRetryInterval.value != "" && !isInt(obj.producerRetryInterval.value)) {
        alert("Retry Interval must be a positive integer.");
        return false;
    } 
    
    return true;
}

/**
 * isInt
 */ 
function isInt(value) {

    var strValidChars = "0123456789";
    var strChar;
    var blnResult = true;

    for (i = 0; i < value.length && blnResult == true; i++) {
        strChar = value.charAt(i);
        if (strValidChars.indexOf(strChar) == -1) {
            blnResult = false;
        }
    }
    return blnResult;
}

</script>

</head>

<body onLoad="loadDocument();">

  <table width="100%">
    <tr>
      <td class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; JMS Settings &gt; JMS Connection Alias &gt; Edit</TD>
    </tr>
    <tr>
      <td colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_jms_detail", "settings-jms-detail.dsp", "POST", "BODY");
		  setFormProperty("htmlform_settings_jms_detail", "aliasName", "%value aliasName encode(url)%");
		  </script>
          <li class="listitem">
		  <script>getURL("settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%","javascript:document.htmlform_settings_jms_detail.submit();","Return to JMS Connection Alias Detail")</script>
		  </li>
        </ul>
      </td>
    </tr>
    <tr>

    <form name="editform" action="settings-jms-detail.dsp" METHOD="POST">
      %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%

      <td>
        <table class="tableView" width="100%">

          <!-- form name="editData" -->

          <tr>
            <td class="heading" colspan=2>General Settings</td>
          </tr>

          <!-- Alias Name -->
          <tr>
            <td width="40%" class="oddrow-l" nowrap="true"><label for="aliasName">Connection Alias Name</label></td>
            <td class="oddrowdata-l"><INPUT NAME="aliasName" id="aliasName" size="50" value="%value aliasName encode(htmlattr)%" DISABLED></td>
          </tr>

          <!-- Description -->
          <tr>
            <td class="evenrow-l"><label for="description">Description</label></td>
            <td class="evenrowdata-l"><INPUT NAME="description" id="description" size="50" value="%value description encode(htmlattr)%"></td>
          </tr>

          <!-- Transaction Mode -->
          <tr>
            <td class="oddrow-l"><label for="transactionType">Transaction Mode</label></td>
            <td class="oddrowdata-l">
              <select name="transactionType" id="transactionType" >
                <option value="0">NO_TRANSACTION</option>
                <option value="1">LOCAL_TRANSACTION</option>
                <option value="2">XA_TRANSACTION</option>
              </select>
            </td>
          </tr>

          <!-- Client ID -->
          <tr>
            <td class="evenrow-l"><label for="clientID">Connection Client ID</label></td>
            <td class="evenrowdata-l"><INPUT NAME="clientID" id="clientID" size="50" value="%value clientID encode(htmlattr)%" onchange="alert ('Warning! \n\nChanging the Connection Client ID results in the creation of durable subscribers for triggers that use the alias because Integration Server uses the Connection Client ID as the first part of the durable subscriber name. The durable subscribers that use the old Connection Client ID as part of the name are not automatically removed from Universal Messaging. Old durable subscribers might contain messages and continue to receive messages.');"></td>
          </tr>

          <!-- User -->
          <tr>
            <td class="oddrow-l"><label for="user">User (optional)</label></td>
            <td class="oddrowdata-l"><INPUT NAME="user" id="user" size="50" value="%value user encode(htmlattr)%"></td>
          </tr>

          <!-- Password -->
          <tr>
            <td class="evenrow-l"><label for="password">Password (optional)</label></td>
            <td class="evenrowdata-l"><input name="password" id="password" type="password" autocomplete="off" size="50" value="%value password encode(htmlattr)%"/></td>
          </tr>

	</table>
        <table class="tableView" width="100%">
	  
          <tr>
            <TD class="heading" colspan=2>Connection Protocol Settings</TD>
          </tr>

          <!-- Association Type -->
          <tr>
            <td class="oddrow-l">
               <label for="associationType"> Create Connection Using</label>
            </td>
            <td class="oddrowdata-l">
                <select name="associationType" id="associationType" onChange="displaySettings(this)">
                    <option value="0">JNDI LOOKUP</option>
                    <option value="1">NATIVE BROKER API (Deprecated)</option>
                </select>
            </td>
          </tr>

        <!-- DIV1 JNDI -->

        <div id="div1" STYLE="display: none">
          <tr>
            <td class="evenrow-l" width="40%"><label for="jndi_jndiAliasName">JNDI Provider Alias Name</label></td>
            <td class="evenrowdata-l">
              <select name="jndi_jndiAliasName" id="jndi_jndiAliasName" >
                %invoke wm.server.jndi:getJNDIAliases%
                  %loop jndiData%
                    <option value="%value jndiAliasName encode(htmlattr)%">%value jndiAliasName encode(html)%</option>
                  %endloop%
                %onerror%
                  %value errorService encode(html)%<br>%value error encode(html)%<br>%value errorMessage encode(html)%<br>
                %endinvoke%
              </select>
            </td>
          <tr>
            <td class="oddrow-l" nowrap><label for="jndi_connectionFactoryLookupName">Connection Factory Lookup Name</label></td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryLookupName" id="jndi_connectionFactoryLookupName" size="50" value="%value jndi_connectionFactoryLookupName encode(htmlattr)%"></td>
          </tr>
          
          <tr>
            <td class="oddrow-l"><label for="jndi_automaticallyCreateUMAdminObjects">Create Administered Objects On Demand (Universal Messaging)</label></td>
            %ifvar jndi_automaticallyCreateUMAdminObjects equals('true')%
             <td class="oddrow-l"><input type="checkbox" name="jndi_automaticallyCreateUMAdminObjects" id="jndi_automaticallyCreateUMAdminObjects" checked=true></td>
            %else%
             <td class="oddrow-l"><input type="checkbox" name="jndi_automaticallyCreateUMAdminObjects" id="jndi_automaticallyCreateUMAdminObjects" ></td>
            %endif%
            </td>
          </tr>
          
          <tr>
            <td class="oddrow-l"><label for="jndi_enableFollowTheMaster">Enable Follow the Master (Universal Messaging)</label></td>
            %ifvar jndi_enableFollowTheMaster equals('true')%
              <script>writeTD("oddrowdata-l");</script><input type="checkbox" name="jndi_enableFollowTheMaster" id="jndi_enableFollowTheMaster" checked="true">
            %else%
              <script>writeTD("oddrowdata-l");</script><input type="checkbox" name="jndi_enableFollowTheMaster" id="jndi_enableFollowTheMaster" >
            %endif%
          </tr>
          
          <tr>
            <td class="evenrow-l"><label for="jndi_connectionFactoryUpdateType">Monitor webMethods Connection Factory</label></td>
            <td class="evenrowdata-l">
              <select name="jndi_connectionFactoryUpdateType" id="jndi_connectionFactoryUpdateType" onChange="displayPollingInterval(this.form.jndi_connectionFactoryUpdateType)")>
                <option value="NONE">No</option>
                <option value="CLIENT_POLL">Poll for changes (specify interval)</option>
                <option value="JNDI_POLL">Poll for changes (interval defined by webMethods Connection Factory)</option>
                <option value="NOTIFICATION">Register change listener</option>
              </select>
          </tr>   

        </table>
        </div>

        <div id="divPoll" STYLE="display: block">
        <table class="tableView" width="100%">
          <tr>
            <td class="oddrow-l" width="40%"><label for="jndi_connectionFactoryPollingInterval">Polling Interval (minutes)</label></td>
            <td class="oddrowdata-l"><input name="jndi_connectionFactoryPollingInterval" id="jndi_connectionFactoryPollingInterval" size="50" value="%value jndi_connectionFactoryPollingInterval encode(htmlattr)%"></td>
          </tr>
        </table>
        </div>

        <!-- DIV2 WM -->

        <div id="div2" STYLE="display: none">
        <table class="tableView" width="100%">

          <!-- Broker Host -->
          <script>//swapRows();</script>
          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="nwm_brokerHost">Broker Host</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerHost" id="nwm_brokerHost" size="50" value="%value nwm_brokerHost encode(htmlattr)%"></td>
          </tr>

          <!-- Broker Name -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_brokerName">Broker Name</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_brokerName" id="nwm_brokerName" size="50" value="%value nwm_brokerName encode(htmlattr)%"></td>
          </tr>

          <!-- Client Group -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_clientGroup">Client Group</label></td>
            <script>writeTD("row-l");</script><INPUT NAME="nwm_clientGroup" id="nwm_clientGroup" size="50" value="%value nwm_clientGroup encode(htmlattr)%"></td>
          </tr>

          <!-- Broker List -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_brokerList">Broker List (optional)</label></td>
            <script>writeTD("row-l");</script><input name="nwm_brokerList" id="nwm_brokerList" size="50" value="%value nwm_brokerList encode(htmlattr)%"></td>
          </tr>

          <!-- Keystore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_keystore">Keystore (optional)</label></td>
            <script>writeTD("row-l");</script><input name="nwm_keystore" id="nwm_keystore" size="50" value="%value nwm_keystore encode(htmlattr)%"></td>
          </tr>

          <!-- Keystore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_keystoreType">Keystore Type (optional)</label></td>
            <script>writeTD("row-l");</script>
              <select name="nwm_keystoreType" id="nwm_keystoreType" >
                <option value=""></option>
                <option value="JKS">JKS</option>
                <option value="PKCS12">PKCS12</option>
              </select>
            </td>
          </tr>

          <!-- Truststore -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_truststore">Truststore (optional)</label></td>
            <script>writeTD("row-l");</script><input name="nwm_truststore" id="nwm_truststore" size="50" value="%value nwm_truststore encode(htmlattr)%"></td>
          </tr>

          <!-- Truststore Type -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_truststoreType">Truststore Type (optional)</label></td>
            <script>writeTD("row-l");</script>
              <select name="nwm_truststoreType" id="nwm_truststoreType" >
                <option value=""></option>
                <option value="JKS">JKS</option>
              </select>
            </td>
          </tr>

          <!-- Encrypted -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="nwm_encrypted">Encrypted</label></td>
            %ifvar nwm_encrypted equals('true')%
              <script>writeTD("row-l");</script><input type="checkbox" name="nwm_encrypted" id="nwm_encrypted" checked="true">
            %else%
              <script>writeTD("row-l");</script><input type="checkbox" name="nwm_encrypted" id="nwm_encrypted" >
            %endif%
            </td>
          </tr>

        </table>
        </div>

        <table class="tableView" width="100%">

         <tr>
            <td class="heading" colspan=2>Advanced Settings</td>
          </tr>

          <!-- Class loader -->
          <script>//uncomment as needed... if ("%value associationType encode(javascript)%" == 1)swapRows();</script>
          <script>swapRows();</script>

          <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="classLoader">Class Loader</label></td>
            <script>writeTD("row-l");</script>
              <select name="classLoader" id="classLoader">
                <option value="INTEGRATION_SERVER">INTEGRATION_SERVER</option>
                %invoke wm.server.packages:packageList%
                  %loop packages%
                    <option value="%value name encode(htmlattr)%">PACKAGE: %value name encode(html)%</option>
                  %endloop%
                %endinvoke%
              </select>
            </td>
          </tr>

          <!-- CSQ -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="csqSize">Maximum CSQ Size (messages)</label></td>
            <script>writeTD("rowdata-l");</script><input name="csqSize" id="csqSize" size="50" value="%value csqSize encode(htmlattr)%"></td>
          </tr>

          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l");</script><label for="csqDrainInOrder">Drain CSQ in Order</label></td>
            %ifvar csqDrainInOrder equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="csqDrainInOrder" id="csqDrainInOrder" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="csqDrainInOrder" id="csqDrainInOrder" ></td>
            %endif%
          </tr>

          <!-- Temp Queue -->
          <script>swapRows();</script>
            <tr>
            <script>writeTD("row-l");</script><label for="optTempQueueCreate">Create Temporary Queue</label></td>
            %ifvar optTempQueueCreate equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="optTempQueueCreate" id="optTempQueueCreate" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="optTempQueueCreate" id="optTempQueueCreate" ></td>
            %endif%
          </tr>
          
          <!-- Reply To Consumer -->
          <script>swapRows();</script>
            <tr>
            <script>writeTD("row-l");</script><label for="allowReplyToConsumer">Enable Request-Reply Listener for Temporary Queue</td>
            %ifvar allowReplyToConsumer equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowReplyToConsumer" id="allowReplyToConsumer" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowReplyToConsumer" id="allowReplyToConsumer" ></td>
            %endif%
          </tr>

          <!-- Manage Dest -->
          <script>swapRows();</script>
          <tr>  
            <script>writeTDWidth("row-l", "40%");</script><label for="manageDestinations">Enable Destination Management with Designer (Broker and Universal Messaging)</label></td>
            %ifvar manageDestinations equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="manageDestinations" id="manageDestinations" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="manageDestinations" id="manageDestinations" ></td>
            %endif%
            </td>
          </tr>

          <!-- Create New Connection per Trigger -->
          <script>swapRows();</script>
          <tr>
            <script>writeTD("row-l", "40%");</script><label for="allowNewConnectionPerTrigger">Create New Connection per Trigger</label></td>
            %ifvar allowNewConnectionPerTrigger equals('true')%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowNewConnectionPerTrigger" id="allowNewConnectionPerTrigger" checked=true></td>
            %else%
              <script>writeTD("rowdata-l");</script><input type="checkbox" name="allowNewConnectionPerTrigger" id="allowNewConnectionPerTrigger" ></td>
            %endif%
            </td>
          </tr>

        </table>

        <!--------------------------->
        <!-- Producer Pool Caching -->
        <!--------------------------->
        <table class="tableView" width="100%">        
          <tr>
              <td class="heading" colspan=2>Producer Caching</td>
          </tr>

          <!-- Caching Mode -->
          <tr>
              <script>swapRows();</script>
              <script>writeTDWidth("row-l", "40%");</script><label for="producerCachingMode">Caching Mode</label></td>
              <script>writeTD("rowdata-l");</script>
                  <select name="producerCachingMode" id="producerCachingMode" onchange="producerModeSettings(this.form.producerCachingMode)">
                      <option value="0">DISABLED</option>
                    <!--  <option value="1">ENABLED</option>  -->
                      <option value="2">ENABLED PER DESTINATION</option>
                  </select>
              </td>
          </tr>
        </table>

        <!-- Producer Pool Caching - Enabled -->
      <div id="divCacheEnabled" STYLE="display: block">
        <table class="tableView" width="100%">

          <script>swapRows();</script>
             <tr>
                 <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolMinSize_divCacheEnabled">Minimum Pool Size</label></td>
                <script>writeTD("rowdata-l");</script>
              <input name="producerSessionPoolMinSize_divCacheEnabled" id="producerSessionPoolMinSize_divCacheEnabled" size="50" value="%value producerSessionPoolMinSize encode(htmlattr)%">
            </td>
          </tr>

            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolSize_divCacheEnabled">Maximum Pool Size</label></td>
                <script>writeTD("rowdata-l");</script>
              <input name="producerSessionPoolSize_divCacheEnabled" id="producerSessionPoolSize_divCacheEnabled" size="50" value="%value producerSessionPoolSize encode(htmlattr)%">
            </td>
              </tr>

        </table>
        </div>

        <!-- Producer Pool Caching - Enabled Per Destination -->
    <div id="divCacheEnabledPer" STYLE="display: block">
        <table class="tableView" width="100%">

                <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolMinSize_divCacheEnabledPer">Minimum Pool Size (unspecified destinations)</td>
            <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolMinSize_divCacheEnabledPer" id="producerSessionPoolMinSize_divCacheEnabledPer" size="50" value="%value producerSessionPoolMinSize encode(htmlattr)%">
                    </td>
        </tr>

        <script>swapRows();</script>
            <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="producerSessionPoolSize_divCacheEnabledPer">Maximum Pool Size (unspecified destinations)</label></td>
            <script>writeTD("rowdata-l");</script>
                        <input name="producerSessionPoolSize_divCacheEnabledPer" id="producerSessionPoolSize_divCacheEnabledPer" size="50" value="%value producerSessionPoolSize encode(htmlattr)%">
                    </td>
        </tr>
        
                <script>swapRows();</script>
        <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersPoolMinSize_divCacheEnabledPer">Minimum Pool Size Per Destination</label></td>
            <script>writeTD("rowdata-l");</script>
                        %ifvar cacheProducersPoolMinSize equals('0')%
                            <input name="cacheProducersPoolMinSize_divCacheEnabledPer" id="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value="">
                        %else%
                            <input name="cacheProducersPoolMinSize_divCacheEnabledPer" id="cacheProducersPoolMinSize_divCacheEnabledPer" size="50" value="%value cacheProducersPoolMinSize encode(htmlattr)%">
                        %endif%
                    </td>
        </tr>

                <script>swapRows();</script>
        <tr>
            <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersPoolSize_divCacheEnabledPer">Maximum Pool Size Per Destination</label></td>
            <script>writeTD("rowdata-l");</script>
                        %ifvar cacheProducersPoolMinSize equals('0')%
                            <input name="cacheProducersPoolSize_divCacheEnabledPer" id="cacheProducersPoolSize_divCacheEnabledPer" size="50" value="">
                        %else%
                            <input name="cacheProducersPoolSize_divCacheEnabledPer" id="cacheProducersPoolSize_divCacheEnabledPer" size="50" value="%value cacheProducersPoolSize encode(htmlattr)%">
                        %endif%
                    </td>
        </tr>

                %ifvar associationType equals('1')%

                    <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersQueueList_divCacheEnabledPer">Queue List (semicolon delimited)</label></td>
                    <script>writeTD("row-l");</script>
	                   <input name="cacheProducersQueueList_divCacheEnabledPer" id="cacheProducersQueueList_divCacheEnabledPer" size="50" value="%value cacheProducersQueueList encode(htmlattr)%">
                    </td>
                </tr>
              
                    <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersTopicList_divCacheEnabledPer">Topic List (semicolon delimited)</label></td>
                    <script>writeTD("row-l");</script>
	                   <input name="cacheProducersTopicList_divCacheEnabledPer" id="cacheProducersTopicList_divCacheEnabledPer" size="50" value="%value cacheProducersTopicList encode(htmlattr)%">
                    </td>
                </tr>

                %else%

                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="cacheProducersQueueList_divCacheEnabledPer">Destination Lookup Names (semicolon delimited)</label></td>
                    <script>writeTD("row-l");</script>
	                    <input name="cacheProducersQueueList_divCacheEnabledPer" id="cacheProducersQueueList_divCacheEnabledPer" size="50" value="%value cacheProducersQueueList encode(htmlattr)%">
                    </td>
                    </tr>


               %endif%

                <script>swapRows();</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="poolTimeout_divCacheEnabledPer">Idle Timeout (milliseconds)</label></td>
                    <script>writeTD("rowdata-l");</script><input name="poolTimeout_divCacheEnabledPer" id="poolTimeout_divCacheEnabledPer" size="50" value="%value poolTimeout encode(htmlattr)%"></td>
                </tr>

            </table>
        </div>

        <!-- Producer Pool Caching - Idle Timeout -->
      <div id="divCacheEnabled2" STYLE="display: block">
        <table class="tableView" width="100%">
	        <script>if ("%value associationType encode(javascript)%" == "0") { swapRows() };</script>
                <tr>
                    <script>writeTDWidth("row-l", "40%");</script><label for="poolTimeout_divCacheEnabled">Idle Timeout (milliseconds)</label></td>
                    <script>writeTD("rowdata-l");</script><input name="poolTimeout_divCacheEnabled" id="poolTimeout_divCacheEnabled" size="50" value="%value poolTimeout encode(htmlattr)%"></td>
                </tr>

            </table>
        </div>
        
        <!-- --------------------- -->
        <!-- Producer Retry        -->
        <!-- --------------------- -->
        <table class="tableView" width="100%">
            <tr>
                    <td class="heading" colspan=2>Producer Retry</td>
            </tr>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerMaxRetryAttempts">Max Retry Attempts</label></td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerMaxRetryAttempts" id="producerMaxRetryAttempts" size="50" value="%value producerMaxRetryAttempts encode(htmlattr)%">
                </td>
            </tr>
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script><label for="producerRetryInterval">Retry Interval (milliseconds)</label></td>
                <script>writeTD("rowdata-l");</script>
                    <input name="producerRetryInterval" id="producerRetryInterval" size="50" value="%value producerRetryInterval encode(htmlattr)%">
                </td>
            </tr>
            
        <!--   
            <script>swapRows();</script>
            <tr>
                <script>writeTDWidth("row-l", "40%");</script>Retry Only if Connected</td>
                %ifvar producerRetryOnlyIfConnected equals('true')%
                    <script>writeTD("row-l");</script><input type="checkbox" name="producerRetryOnlyIfConnected" checked="true"></td>
                %else%
                    <script>writeTD("row-l");</script><input type="checkbox" name="producerRetryOnlyIfConnected"></td>
                %endif%
            </tr>
        -->
        
        </table>
        
        <!-- --------------------- -->
        <!-- Enhanced Logging      -->
        <!-- --------------------- -->
        <table class="tableView" width="100%">
          
          <tr>
            <td class="heading" colspan=2>Enhanced Logging</td>
          </tr>

          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_loggingOutput">Logging Type</label></TD>
            <TD class="oddrowdata-l">
              <select name="um_loggingOutput" id="um_loggingOutput" >
                        %ifvar um_loggingOutput equals('0')%
                            <option value="0" selected>SERVER LOG</option>    
                        %else%
                            <option value="0">SERVER LOG</option>
                        %endif%
                        %ifvar um_loggingOutput equals('1')%
                            <option value="1" selected>MESSAGING AUDIT LOG</option>
                        %else%
                            <option value="1">MESSAGING AUDIT LOG</option>
                        %endif%
              </select>
            </TD>            
          </TR> 
  
          <TR>
            <TD width="40%" class="oddrow-l"><label for="um_producerMessageTracking">Enable Producer Message ID Tracking</label></TD>
            <TD class="oddrowdata-l">
              %ifvar um_producerMessageTracking equals(true)%
                <INPUT TYPE="checkbox" NAME="um_producerMessageTracking" id="um_producerMessageTracking" checked="true">       
              %else%
                <INPUT TYPE="checkbox" NAME="um_producerMessageTracking" id="um_producerMessageTracking" >
              %endif%                                                                             
            </TD>
          </TR>  
          <TR>
            <TD class="oddrow-l"><label for="um_producerIncludedStrings">Producer Message ID Tracking: Include Destinations (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="um_producerIncludedStrings" id="um_producerIncludedStrings" size="50" value="%value um_producerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
          
          <TR>
            <TD class="oddrow-l"><label for="um_consumerMessageTracking">Enable Consumer Message ID Tracking</label></TD>
            <TD class="oddrowdata-l"> 
              %ifvar um_consumerMessageTracking equals(true)%
                <INPUT TYPE="checkbox" NAME="um_consumerMessageTracking" id="um_consumerMessageTracking" checked="true">        
              %else%
                <INPUT TYPE="checkbox" NAME="um_consumerMessageTracking" id="um_consumerMessageTracking" >
              %endif%
            </TD>
          </TR>
          <TR>
            <TD class="oddrow-l"><label for="um_consumerIncludedStrings">Consumer Message ID Tracking: Include Triggers (semicolon delimited)</label></TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="um_consumerIncludedStrings" id="um_consumerIncludedStrings" size="50" value="%value um_consumerIncludedStrings encode(htmlattr)%">
            </TD>
          </TR>
	       </table>

        <!-- Submit Button -->
        <table class="tableView" width="100%">
          <tr>
              <td class="action" colspan=2>

                <input name="aliasName" type="hidden" value="%value aliasName encode(htmlattr)%">
                <input name="associationTypeREM" type="hidden" value="%value associationType encode(htmlattr)%">
                <input name="action" type="hidden" value="edit">
                <input type="submit" value="Save Changes" onClick="javascript:return validateForm(this.form)">

                <!-- <a href="settings-jms-detail.dsp?aliasName=%value aliasName encode(url)%"> -->

              </td>
            </tr>

        </table>

      </td>
    </tr>


    </form>
  </table>

%onerror%
%value errorService encode(html)%<br>
%value error encode(html)%<br>
%value errorMessage encode(html)%<br>

</body>

%endinvoke%

</html>