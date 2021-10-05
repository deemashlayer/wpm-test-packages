<HTML>
    <HEAD>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <META HTTP-EQUIV="Expires" CONTENT="-1">
		<meta http-equiv="cache-control" content="no-cache, no-store"> 
    </HEAD>
	
	<script>
               
    function logout() {
        // There is not a reliable cross-browser technique to force a logoff, so we are sending a request without password.
        // This will cause the server to return a 401 and a WWW-Authenticate header.
        var xmlHttp = new XMLHttpRequest();
        try {
            // The "true" on this call causes it to be an async, so the logoff result returns and displays.
            // The browser should prompt for a userid/password on the next request for an IS resource.
           var checkSecure = window.location.protocol;
	   var queryString = window.location.search;
				
			var address = "";
			if(checkSecure == "https:"){
				address = "https://"+window.location.hostname+":"+window.location.port+queryString ;
			} else{
				address = "http://"+window.location.hostname+":"+window.location.port+queryString ;
			}
			
			// A new request is sent with bad username/password to clear all sessions.
			// The current user is not used as it might cause account locking if any condition is set on LDAP or Account Locking settings in // IS			
            xmlHttp.open( "GET", address, true, "_Admin"," " );
            xmlHttp.send();
        }
        catch (e) {}  
    }

    function redirect(){
	
	var checkSecure = window.location.protocol;
	var queryString = window.location.search;
	var address = "";
	queryString = queryString.substring(queryString.indexOf("=")+1)
			if(checkSecure == "https:"){
				address = "https://"+window.location.hostname+":"+window.location.port+"/"+queryString  ;
			} else{
				address = "http://"+window.location.hostname+":"+window.location.port+"/"+queryString  ;
			}
	if(address.includes("?")){
		address = address + "&option=skip";
		}
	else{
		address = address + "?option=skip";
		}
	//xmlHttp.open( "GET", address );
    //    xmlHttp.send();
	window.location = address;

	}

    function getAddress(){
	var checkSecure = window.location.protocol;
	   const queryString = window.location.search;
				
			var address = "";
			if(checkSecure == "https:"){
				address = "https://"+window.location.hostname+":"+window.location.port+queryString ;
			} else{
				address = "http://"+window.location.hostname+":"+window.location.port+queryString ;
			}
	}

    </script>

    
    <BODY onLoad="logout()" class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
	%invoke wm.server:disconnect%
	
    <table width="100%">
            <tr><td style="background-color: #08429C; color: #FFFFFF; text-align: left; font-weight: bold;">
				Session timeout occurred.
			</td></tr>            
			<tr><td>Click <button onClick="redirect();">here</button> to resume</td></tr> 
        </table> 
         
        <script>
			
		</script> 
    </BODY>
</HTML>