var pairs =
{
"edit":{"issuer":1,"edit":1,"issuers":1,"description":1}
,"issuer":{"screen":1,"click":1,"name":1,"description":1,"note":1,"related":1}
,"screen":{"screen":1,"heading":1,"view":1,"click":1,"issuer":1}
,"heading":{"security":1}
,"security":{"jwt":1,"menu":1}
,"jwt":{"trusted":1,"security":1,"screen":1}
,"trusted":{"issuers":1,"issuer":1}
,"issuers":{"issuername":1,"screen":1,"open":1,"jwt":1,"return":1}
,"issuername":{"edit":1}
,"view":{"change":1}
,"change":{"descriptio":1}
,"descriptio":{"trusted":1}
,"open":{"edit":1}
,"click":{"jwt":1,"trusted":1,"issuer":1,"return":1}
,"menu":{"navigation":1}
,"navigation":{"panel":1}
,"panel":{"click":1}
,"return":{"trusted":1}
,"name":{"specifies":1,"trusted":1}
,"specifies":{"name":1,"text":1}
,"description":{"specifies":1,"trusted":1,"issuer":1}
,"text":{"description":1}
,"note":{"edit":1}
,"related":{"topics":1}
}
;Search.control.loadWordPairs(pairs);
