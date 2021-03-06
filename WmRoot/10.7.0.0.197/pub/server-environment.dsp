<html>
  <head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv='content-type' content='text/html; charset=utf-8'>
    <meta http-equiv="expires" content="-1">
    <script src="webMethods.js"></script>
    <link rel="stylesheet" type="text/css" href="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
  </head>
    
  <script>
    function exportSysInfo() {
        if (is_csrf_guard_enabled && needToInsertToken) {
            createForm("htmlform_getSystemInfoAsXML", "../invoke/wm.server.query:getSystemInfoAsXML", "POST", "BODY");
            setFormProperty("htmlform_getSystemInfoAsXML", _csrfTokenNm_, _csrfTokenVal_);
            document.htmlform_getSystemInfoAsXML.submit();
        } else {
            document.location='../invoke/wm.server.query:getSystemInfoAsXML';
        }
    }

    function downloadDiagnostics() {
        if (is_csrf_guard_enabled && needToInsertToken) {
            createForm("htmlform_getDiagnosticData", "../invoke/wm.server.admin:getDiagnosticData", "POST", "BODY");
            setFormProperty("htmlform_getDiagnosticData", _csrfTokenNm_, _csrfTokenVal_);
            document.htmlform_getDiagnosticData.submit();
        } else {
            document.location.assign('../invoke/wm.server.admin:getDiagnosticData');
        }
        
    }
  </script>

  <BODY onLoad="setNavigation('stats-general.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_AboutISAdmin','foo');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan="2">Server &gt; About</TD>
      </TR>
      
      <TR>
        <TD>
          <TABLE class="tableView" width="100%">
            <TR>
              <TD class="heading" colspan="2">Copyright</TD>
            </TR>

            <TR>
              <TD class="evenrow-l" colspan="2">

              <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                <tr>
                  <td width="100%">
                    <table class="tableInline" width="100%"  cellspacing="0px" cellpadding="0px">
                      <tr>
                      <tr>
                        %invoke wm.server.query:getServerInstanceName%
                          <td valign="top" >
                            <img src="images/blank.gif" height=0 width=5>
                            %ifvar productname equals('Integration Server')%
                              <img src="images/is_logo_stacked.png" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            %else%
                              %ifvar productname equals('Microservices Runtime')%
                                <img src="images/msc_logo_stacked.png" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;
                              %else%
                                <img src="images/ia_logo_stacked.png" border="0"/>&nbsp;&nbsp;&nbsp;&nbsp;
                              %endif%
                            %endif%
                          </td>
    
                          <td>
                            %ifvar productname%
                              <b>webMethods %value productname%</b>
                            %else%
                              <b>webMethods Integration Server</b>
                            %endif%
                          %endinvoke%
                              
          <p>Copyright &copy; 1996 - 2020 Software AG, Darmstadt, Germany and/or Software AG USA
          Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their
          licensors.</p>
                         
          <p>The name Software AG and all Software AG product names are either trademarks or
          registered trademarks of Software AG and/or Software AG USA Inc. and/or its subsidiaries
          and/or its affiliates and/or their licensors. Other company and product names mentioned
          herein may be trademarks of their respective owners.</p>
                              
          <p>Detailed information on trademarks and patents owned by Software AG and/or its
          subsidiaries is located
          at <a href="http://softwareag.com/licenses">http://softwareag.com/licenses</a>.</p>
                            
          <p>This software may include portions of third-party products. For third-party copyright
          notices, license terms, additional rights or restrictions, please refer to "License Texts,
          Copyright Notices and Disclaimers of Third Party Products". For certain specific
          third-party license restrictions, please refer to section E of the Legal Notices available
          under "License Terms and Conditions for Use of Software AG Products / Copyright and
          Trademark Notices of Software AG Products". These documents are part of the product
          documentation, located
          at <a href="http://softwareag.com/licenses">http://softwareag.com/licenses</a> and/or in
          the root installation directory of the licensed product(s).</p>
                            
          <p>Use, reproduction, transfer, publication or disclosure is prohibited except as
          specifically provided for in your License Agreement with Software AG.</p>
    
                          </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
           </td>
         </TR>
      </table>    
    

    <table class="tableView" width="100%">
      <TR>
        <TD class="heading" colspan="2">System</TD>
      </TR>
      %invoke wm.server.query:getSystemInfoAsIData%
        %ifvar systemInfo%
          %loop -struct systemInfo%
            <TR>
              <td class="evenrow" style="width: 10%">%value $key encode(html)%</TD>
              <td class="evenrowdata-l">%value encode(html)%</TD>
            </TR>
          %endloop%
          <TR>
            <TD class="oddrow"></TD><TD class="oddrowdata-l" width=100%>
              <input type="button" onClick="exportSysInfo();" value="Export" />
            </TD>
          </TR>
        %else%
          <TR>
            <TD class="oddrow-l" colspan="2">Not Available</TD>
          </TR>
        %endif%
      %endinvoke%
    </table>
    <table class="tableView" width="100%">
      %invoke wm.server.query.adminui:getSystemAttributes%
        <TR>
          <TD class="heading" colspan="2">Software</TD>
        </TR>
        <TR>
          <TD class="oddrow" style="width: 10%">Product</TD>
          <TD class="oddrowdata-l" width="100%">webMethods 
            %invoke wm.server.query:getServerInstanceName%
              %ifvar productname%
                %value productname%
              %else%
                Integration Server
              %endif%
            %endinvoke%
          </TD>
        </TR>
        <TR>
          <TD class="evenrow">Version</TD>
          <TD class="evenrowdata-l" >%value version encode(html)%
            %ifvar ee%
              <script>
                createForm("htmlform_server_environment", "server-environment.dsp", "POST", "BODY");
              </script>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <script>
                if (is_csrf_guard_enabled && needToInsertToken) {
                  document.write('<A target="_blank" href="javascript:document.htmlform_server_environment.submit();" onclick="return openNotes(\'server-environment.dsp\', \'%value ee encode(javascript)%\');">Credits...</A>');
                } else {
                  document.write('<A target="_blank" href="server-environment.dsp" onclick="return openNotes(\'server-environment.dsp\', \'%value ee encode(javascript)%\');">Credits...</A>');
                }
              </script>
            %endif%
          </TD>
        </TR>
        <tr>
          <td class="oddrow" nowrap>Updates</td>
            %ifvar patches%
              <td class="oddrowdata-l">
                %loop patches%
                  %value encode(html)%<br>
                %endloop%
            %else%
              <td class="oddrowdata-l">
                None
            %endif%
          </td>
        </tr>
        <TR>
          <TD class="evenrow" nowrap>Build Number</TD>
          <TD class="evenrowdata-l" >%value build encode(html)%</TD>
        </TR>
        <TR>
          <TD class="oddrow">SSL</TD>
          <TD class="oddrowdata-l">%value ssl encode(html)%</TD>
        </TR> %ifvar sysattr%
          <TR>
            <TD class="evenrow"></TD>
            <TD class="evenrowdata-l" width=100%>
              <input type="button" onClick="downloadDiagnostics();" value="Get Diagnostics" />
            </TD>
          </TR>
        </table>
        <table class="tableView" width="100%">
          <TR>
            <TD class="heading" colspan="2">Server Environment</TD>
          </TR>                            
                
          %loop -struct sysattr%
            <TR>
              <td class="evenrow" style="width: 10%"><nobr>%value $key encode(none)%</nobr></td>
              <td class="evenrowdata-l">%value encode(none)%</td>
            </TR> %endloop%  %endif%
    %endinvoke%

    </table>
    <table class="tableView" width="100%">
      %invoke wm.server.query:getSecurityProviders%
        <TR>
          <TD class="heading" colspan="2">Security Providers</TD>
        </TR>
        %loop provider%
          <tr> 
            <td class="row" style="width: 10%"><script>var idx = "%value $index encode(html_javascript)%"; document.write("<nobr>" + (++idx) + "</nobr>");</script></td>
            <td class="evenrowdata-l">%value name encode(html)%  %value version encode(html)%</td>
          </tr> 
        %endloop%
      %endinvoke%   
    </TABLE> 
  </BODY>
%ifvar ee%
  <script>
    function openNotes(pagename, pagenumber)
    {
      window.open("doc/OnlineHelp/WmRoot.htm#"+pagename.substr(2, pagenumber/10)+".dsp?d=%value section encode(url)%&g=%value ee encode(url)%",'c2Rr4','width='+screen.width+',height='+screen.height+',top=0,left=0');
      return false;
    }
  </script>
%endif%
</HTML>
