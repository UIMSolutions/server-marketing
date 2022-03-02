import vibe.vibe;
import servers.marketing;

mixin DefaultConfig!("server-marketing");
//mixin ReadConfig;
void main(string[] args) {
	debug writeln("readConfig()");
  // readConfig();

	debug writeln("mixin GetoptConfig");
  //mixin GetoptConfig;
  
	auto router = new URLRouter;	
	debug writeln("SetRouterDefault!()");
  mixin(SetRouterDefault!());

/* 	router
		.get("/login", &servermarketing.loginPage.request)
		.get("/logout", &servermarketing.logoutPage.request);
 */
debug writeln("Setting router");
router // Pages
		.get("/marketing", &uimmarketingPage);

	mixin(AddRoutes!("router", "/marketing/emails", "uimEmails"));
	mixin(AddRoutes!("router", "/marketing/geopins", "uimGeoPins"));
	mixin(AddRoutes!("router", "/marketing/lists", "uimLists"));
	mixin(AddRoutes!("router", "/marketing/pages", "uimPages"));
	mixin(AddRoutes!("router", "/marketing/events/customregistrations/fields", "uimEventCustomRegistrationFields"));
	mixin(AddRoutes!("router", "/marketing/events", "uimEvents"));
	mixin(AddRoutes!("router", "/marketing/events/registrations", "uimEventRegistrations"));
	mixin(AddRoutes!("router", "/marketing/libraries", "uimLibraries"));
	mixin(AddRoutes!("router", "/marketing/events/teammembers", "uimEventTeamMembers"));
	mixin(AddRoutes!("router", "/marketing/events/vendors", "uimEventVendors"));
	mixin(AddRoutes!("router", "/marketing/forms", "uimForms"));
	mixin(AddRoutes!("router", "/marketing/forms/pages", "uimFormPages"));

	router
		.get("/", &uimIndex)
		.get("/login", &uimLoginPage)
		.get("/login2", &uimLogin2Page)
		.get("/register", &uimRegister)
		.get("/logout", &uimLogout)
		.get("/server", &uimServer)
		.get("/sites", &uimSites);

	router // actions
		.post("/login_action", &uimLoginAction)
		.post("/login2_action", &uimLogin2Action)
		.post("/sites/select", &uimSiteSelectAction);

	debug writeln("Create Database");
	auto database = ETBBase.importDatabase(JSBFileBase("../../DATABASES/uim"));
	debug writeln("Found Tenants:", database.count);

	debug writeln("auto dbTentant = database[system]");
	if (auto dbTentant = database["systems"]) {
		debug writeln("Found tentant");

		foreach(name; dbTentant.collectionNames) {
			debug writeln("uimEntityRegistry name:", name, " path:", name);
		
			if (auto entityTemplate = uimEntityRegistry[name]) {
				debug writeln("entityid = ", uimEntityRegistry[name].id);
		
				dbTentant[name].entityTemplate(entityTemplate);
	}}}

	debug writeln("auto dbTentant = database[uim]");
	if (auto dbTentant = database["uim"]) {
		debug writeln("Found tentant");

		foreach(name; dbTentant.collectionNames) {
			debug writeln("uimEntityRegistry name:", name, " path:", name);

			if (auto entityTemplate = uimEntityRegistry[name]) {
				debug writeln("entityid = ", uimEntityRegistry[name].id);
	
				dbTentant[name].entityTemplate(entityTemplate);
	}}}

	debug writeln("database.tenantNames -> ", database.tenantNames);
	foreach(tenant; database.tenantNames) {
		debug writeln(tenant, " with ", database[tenant].collectionNames);
	}

	debug writeln("servermarketing.database(database)");
  servermarketing.database(database);
	// servermarketing.rootPath(rootPath).registerApp(router); 

  mixin(SetHTTP!());
	runApplication();
}
