public class EventBritePageController {


private String sToken;
private String sURL;
 
public String sOrganizerId {get;set;}
public String sSelectedEvent {get;set;}

public String sRawResponse {get;set;}

public EB_Events EBEventList {get;set;}
public EB_Attendees EBAttendees {get;set;}

public Boolean bShowEventList {get;set;}
public Boolean bShowAttendeeList {get;set;}

private GenericCalloutClass gCallout;


public EventBritePageController() {
getCredentials();
gCallout = new GenericCalloutClass ();
gCallout.sToken = sToken;

gCallout.bParsetoMap = FALSE;

bShowEventList = TRUE;
bShowAttendeeList = FALSE;
}

private void getCredentials() {
EventBrite_Credentials__c ebc = EventBrite_Credentials__c.getinstance();
sToken = ebc.Token__c;
sURL = ebc.API_Root__c;
	if (ebc.Default_Organizer_Id__c != NULL) {
		sOrganizerId = ebc.Default_Organizer_Id__c;
	}

}

public PageReference returntoEvents() {
	bShowEventList = TRUE;
	bShowAttendeeList = FALSE;
	return null;
}

public PageReference getEventsbyOrganizer() {

gCallout.sEndpoint = sURL + 'events/search/?organizer.id=' + sOrganizerId;

system.debug(gCallout.sEndpoint);
gCallout.ExecuteCallout();
sRawResponse = gCallout.sRawResponse; 
EBEventList = EB_Events.parse(sRawResponse);
system.debug(EBEventList);
return null;

}

public PageReference getAttendeesbyEvent() {

gCallout.sEndpoint = sURL + 'events/' + sSelectedEvent + '/attendees/';

system.debug(gCallout.sEndpoint);
gCallout.ExecuteCallout();
sRawResponse = gCallout.sRawResponse; 
EBAttendees = EB_Attendees.parse(sRawResponse);
bShowEventList = FALSE;
bShowAttendeeList = TRUE;

return null;

}

}