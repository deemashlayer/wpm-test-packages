var pairs =
{
"logs":{"menu":1}
,"menu":{"error":1}
,"error":{"log":1}
,"log":{"screen":1}
,"screen":{"guaranteed":1,"messaging":1,"security":1,"server":1,"service":1,"session":1}
,"guaranteed":{"delivery":1}
,"delivery":{"-inbound":1,"-outbound":1}
,"-inbound":{"log":1}
,"-outbound":{"log":1}
,"messaging":{"log":1}
,"security":{"log":1}
,"server":{"log":1}
,"service":{"log":1}
,"session":{"log":1}
}
;Search.control.loadWordPairs(pairs);
