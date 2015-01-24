public class GenericCalloutClass {

public String sEndpoint {get;set;}
public String sRawResponse {get;set;}
public String sToken;
public String sCalloutType {get;set;}
public Boolean bSuccess {get;set;}
public String sError {get;set;}
public Map<String, String> ResponseMap {get;set;}
public Boolean bParsetoMap;


public GenericCalloutClass() {
    sCalloutType = 'GET';
    bSuccess = FALSE;
    bParsetoMap = TRUE;
    
}

public void ExecuteCallout() {
bSuccess = FALSE;

HttpRequest req2 = new HttpRequest();

String authorizationHeader = 'Bearer ' + sToken;
req2.setEndpoint(sEndpoint);
req2.setMethod(sCalloutType);
req2.setHeader('Authorization', authorizationHeader);
req2.setHeader('Accept', 'application/json');
 
Http http = new Http();

try {
    HTTPResponse res = http.send(req2);
    sRawResponse = res.getBody();
    system.debug('Callout to : ' + sEndPoint + ' => ' + sRawResponse);
    if (bParsetoMap) {
        ResponseMap = (Map<String, String>) JSON.deserialize(sRawResponse, Map<String, String>.class);
    }
    
    bSuccess = TRUE;
}    
Catch (Exception Ex) {
       sError = Ex.GetMessage();
}

}



}