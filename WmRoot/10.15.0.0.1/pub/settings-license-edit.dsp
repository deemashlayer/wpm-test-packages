<HTML>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" content="-1">
        <title>Integration Server Settings</title>
        <link rel="stylesheet" type="text/css" href="webMethods.css">
        %ifvar webMethods-wM-AdminUI%
          <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
          <script>webMethods_wM_AdminUI = 'true';</script>
        %endif%
        <script src="webMethods.js"></script>
    </head>

%ifvar doc equals('edit')%
    <body onLoad="setNavigation('settings-license-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_EditLicensingScrn');">
%else%
    <body onLoad="setNavigation('settings-license-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingDetailsScrn');">
%endif%

        <table width="100%">
            <tr>
                <td class="breadcrumb" colspan="2">
                    Settings &gt; License &gt; License Details
                    %ifvar doc equals('edit')%
                       &gt; Edit
                    %endif%
                </td>
            </tr>
    
    %ifvar action equals('change')%
        <!-- call setSettings to update the partner ip information -->
        %invoke wm.server.admin:setAllLicenseSettings%
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr><td class="message" colspan="2">%value message encode(html)%</td></tr>
            <script>
                reloadNavigationFrame();
                reloadTopFrame();
                setNavigation('settings-license-edit.dsp',  'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_LicensingDetailsScrn');
            </script>
        %endinvoke%
    %endif%
      
    %ifvar doc equals('edit')%
            <tr>
                <td colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_settings_license_edit", "settings-license-edit.dsp", "POST", "BODY");
						</script>
                        <li class="listitem">
						<script>getURL("settings-license-edit.dsp","javascript:document.htmlform_settings_license_edit.submit();","Return to Licensing Details")</script>
						</li>
                    </ul>
                </td>
            </tr>
    %else%
            <tr>
                <td colspan="2">
                    <ul class="listitems">
						<script>
						createForm("htmlform_settings_license", "settings-license.dsp", "POST", "BODY");
						createForm("htmlform_settings_license_edit_doc", "settings-license-edit.dsp", "POST", "BODY");
						setFormProperty("htmlform_settings_license_edit_doc", "doc", "edit");
						</script>
                        <li class="listitem">
						<script>getURL("settings-license.dsp","javascript:document.htmlform_settings_license.submit();","Return to License")</script>
						</li>
                        <li class="listitem">
						<script>getURL("settings-license-edit.dsp?doc=edit","javascript:document.htmlform_settings_license_edit_doc.submit();","Edit Licensing Details")</script>
						</li>
                    </ul>
                </td>
            </tr>
    %endif%

    %ifvar doc equals('edit')%
        <form name="editkey" action="settings-license-edit.dsp" method="POST">
            %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%
            <input type="hidden" name="action" value="change">

            <tr>
                <td>
                    <table class="tableView" width="75%">
                        <tr>
                            <td class="heading" colspan="2">Edit License File</td>
                        </tr>
                    %invoke wm.server.query:getLicenseSettings%
                        <tr>
                            <td class="evenrow"><label for="LicenseKeyFile">Integration Server License File</label></td>
                            <td class="evenrow-l">
                                <input name="LicenseKeyFile" id="LicenseKeyFile" size="100" value="%value LicenseKeyFile encode(htmlattr)%" />
                            </td>
                        </tr>
        
                    %ifvar keyPartner%
                        <tr>
                            <td class="heading" colspan="2">
                                Edit Partner Information
                            </td>
                        </tr>
                        <tr>
                            <td class="oddrow-l" colspan="2">
                                Partner License Key Holders Only
                            </td>
                        </tr>
                        <tr>
                            <td class="evenrow">
                                IP Address
                            </td>
                            <td class="evenrow-l">
                                <input name="watt.server.partner" value="%value watt.server.partner encode(htmlattr)%"></input>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
    
                    %endif% 
                    %endinvoke%

                    %invoke wm.server.query:getTerracottaLicenseInformation%
                        <tr>
                            <td class="oddrow"><label for="licensepath">Terracotta License File</label></td>
                            <td class="oddrow-l">
                                <input id="licensepath" name="watt.server.terracotta.license.path" size="100" value="%value terracottaLicenseFileSet encode(htmlattr)%" />
                            </td>
                        </tr>
                    %endinvoke%
        
                        <tr>
                            <td colspan="2" class="action">
                                <input type="submit" value="Save Changes" />
                            </td>
                        </tr>

                    </table>
                </td>
            </tr>
        </form>
    %else%

    %invoke wm.server.query:getLicenseSettings%
        <tr>
            <td>
            %invoke wm.server.query:getLicenseDetails%
                %loop LicenseDetails%
                    %loop -struct%
                     <table class="tableView" width="50%">
                        <tr>
                            <td class="heading" colspan="2">%value $key encode(html)%</td>
                        </tr>
                        %loop #$key%
                            %loop -struct%
                                <tr>
                                    <td class="row" width="25%">
                                        %ifvar $key equals('ExpirationDate')%
                                            %ifvar ../../../../../keyExpired%
                                                <font color="red">
                                            %endif%
                                        %endif%
                                    %value $key encode(html)%</td>
                                    <td class="rowdata-l">
                                    %ifvar $key equals('ExpirationDate')%
                                        %ifvar ../../../../../keyExpired%
                                           <font color="red">
                                        %endif%
                                    %endif%
                                    %value encode(html)%</td>
    
                                </tr>
                            %endloop%
                       %endloop%
                    %endloop%
                    </table>
                %endloop%
            %endinvoke%

           %ifvar keyPartner%
                <!-- calling getSettings returns the value of watt.server.partner -->
                %invoke wm.server.query:getSettings%
                     <table class="tableView" width="50%">  
                    <tr>
                        <td class="heading" colspan="2">Partner Information</td>
                    </tr>
         
                    <tr>
                        <td class="row">Partner IP Address</td>
                        <td class="rowdata-l">%value watt.server.partner encode(html)%</td>
                    </tr>
         
                    </table>
                %endinvoke%
            %endif%

            %invoke wm.server.query:getTerracottaLicenseInformation%
                     <table class="tableView" width="50%">  
                    <tr>
                        <td class="heading" colspan="2">Terracotta</td>
                    </tr>
                 
                    <tr>
                        <td class="row" width="25%">License File</td>
                        <td class="rowdata-l">%value terracottaLicenseFileSet encode(html)%</td>
                    </tr>
                 
                    <tr>
                        <td class="row" width="25%">BigMemory</td>
                        
                        <td class="rowdata-l">
                            %ifvar isBigMemoryLicensed equals('true')%
                                yes
                            %else%
                                no
                            %endif%
                        </td>
                    </tr>
                 
                    <tr>
                        <td class="row" width="25%">Expiration Date</td>
                        <td class="rowdata-l">%value expirationDate encode(html)%</td>
                    </tr>
                  
            %endinvoke%
                </table>
            </td>
        </tr>
    %endinvoke%

    %endif%

        </table>
    </body>
</html>
