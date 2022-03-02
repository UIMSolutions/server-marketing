module servers.marketing.entities;

@safe:
import servers.marketing;

mixin(PageControllerCalls!("uimEmails", "MRKEmails", "serverMarketing"));
mixin(PageControllerCalls!("uimGeoPins", "MRKGeoPins", "serverMarketing"));
mixin(PageControllerCalls!("uimLists", "MRKLists", "serverMarketing"));
mixin(PageControllerCalls!("uimPages", "MRKPages", "serverMarketing"));
mixin(PageControllerCalls!("uimEventCustomRegistrationFields", "MRKEventCustomRegistrationFields", "serverMarketing"));
mixin(PageControllerCalls!("uimEvents", "MRKEvents", "serverMarketing"));
mixin(PageControllerCalls!("uimEventRegistrations", "MRKEventRegistrations", "serverMarketing"));
mixin(PageControllerCalls!("uimEventCustomRegistrationFields", "MRKEventCustomRegistrationFields", "serverMarketing"));
mixin(PageControllerCalls!("uimEventCustomRegistrationFields", "MRKEventCustomRegistrationFields", "serverMarketing"));

	mixin(AddRoutes!("router", "/marketing/events", ""));
	mixin(AddRoutes!("router", "/marketing/events/registrations", ""));
	mixin(AddRoutes!("router", "/marketing/libraries", "uimLibraries"));
	mixin(AddRoutes!("router", "/marketing/events/teammembers", "uimEventTeamMembers"));
	mixin(AddRoutes!("router", "/marketing/events/vendors", "uimEventVendors"));
	mixin(AddRoutes!("router", "/marketing/forms", "uimForms"));
	mixin(AddRoutes!("router", "/marketing/forms/pages", "uimFormPages"));