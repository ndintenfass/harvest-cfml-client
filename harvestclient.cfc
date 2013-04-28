component output = "false" accessors = "true" {
  /*
    Copyright (c) 2013, Hotel Delta Holdings, LLC (hoteldelta.net)

    Author: Nathan Dintenfass (nathan [at] hoteldelta [dot] net)

    For Harvest API documentation (potentially helpful to see values of some arguments):

    http://www.getharvest.com/api


    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


  */
  property username;
  property password;
  property subdomain;
  property name = "format" default = "json";
  property name = "useSSL" default = true;
  property name = "baseEndpoint" default = ".harvestapp.com";
  property name = "userAgent" default = "CFML Harvest Client by Hotel Delta (hoteldelta.net)";
  property name = "retryRequests" default="false" type="boolean";
  property name = "retryCount" default="3";

  function init(subdomain, username, password) {
    setSubdomain(arguments.subdomain);
    setUsername(arguments.username);
    setPassword(arguments.password);
  }

  /*******************************************
  ** ACCOUNT ISSUES
  *******************************************/

  function whoAmI() {
    return call("/account/who_am_i");
  }

  function getRateLimitStatus() {
    return call("/account/rate_limit_status");
  }  

  /*******************************************
  ** PROJECTS
  *******************************************/
  function getProject(id) {
    return call("/projects/#arguments.id#");
  }

  //filters can be "client" or "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllProjects(filter = {}) {
    arguments.action = "/projects";
    return call(argumentCollection = arguments);
  }

  function getClientProjects(id) {
    return getAllProjects( {client = arguments.id});
  }

  function archiveProject(id) {
    //since the API is a "toggle" let's make sure this project is active now, otherwise we can just return as that's the status quo state.
    var project = getProject(arguments.id);
    if(!project.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The project #project.name# (id: #arguments.id#) is already archived.");
    return call("/projects/#arguments.id#/toggle", "PUT");
  }

  function reactivateProject(id) {
    //since the API is a "toggle" let's make sure this project is inactive now
    var project = getProject(arguments.id);
    if(project.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The project #project.name# (id: #arguments.id#) is already active.");
    return call("/projects/#arguments.id#/toggle", "PUT");
  }

  function deleteProject(id) {
    return call("/projects/#arguments.id#", "DELETE");
  }

  function updateProject(id, project) {
    return call("/projects/#arguments.id#", "PUT", arguments.project);
  }

  function createProject(project) {
    return call("/projects", "POST", arguments.project);
  }

  /*******************************************
  ** CLIENTS
  *******************************************/
  function getClient(id) {
    return call("/clients/#arguments.id#");
  }

  //filter is "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllClients(filter = {}) {
    arguments.action = "/clients";
    return call(argumentCollection = arguments);
  }

  function archiveClient(id) {
    //since the API is a "toggle" let's make sure this client is active now, otherwise we can just return as that's the status quo state.
    var client = getClient(arguments.id);
    if(!client.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The client #client.name# (id: #arguments.id#) is already archived.");
    return call("/clients/#arguments.id#/toggle", "PUT");
  }

  function reactivateClient(id) {
    //since the API is a "toggle" let's make sure this client is inactive now
    var client = getClient(arguments.id);
    if(client.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The client #client.name# (id: #arguments.id#) is already active.");
    return call("/clients/#arguments.id#/toggle", "PUT");
  }

  function deleteClient(id) {
    return call("/clients/#arguments.id#", "DELETE");
  }

  function updateClient(id, client) {
    return call("/clients/#arguments.id#", "PUT", arguments.client);
  }

  function createClient(client) {
    return call("/clients", "POST", arguments.client);
  }

  /*******************************************
  ** CONTACTS
  *******************************************/
  function getContact(id) {
    return call("/contacts/#arguments.id#");
  }

  //filter can be "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllContacts(filter = {}) {
    arguments.action = "/contacts";
    return call(argumentCollection = arguments);
  }

  //filter can be "updated_since" (UTC time eg 2010-09-25+18:30)
  function getClientContacts(id, filter = {}) {
    return call(action = "/clients/#arguments.id#/contacts", filter = arguments.filter);
  }

  function deleteContact(id) {
    return call("/contacts/#arguments.id#", "DELETE");
  }

  function updateContact(id, contact) {
    return call("/contacts/#arguments.id#", "PUT", arguments.contact);
  }

  function createContact(contact) {
    return call("/contacts", "POST", arguments.contact);
  }  

  /*******************************************
  ** TASKS
  *******************************************/
  function getTask(id) {
    return call("/tasks/#arguments.id#");
  }

  //filter can be "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllTasks(filter = {}) {
    arguments.action = "/tasks";
    return call(argumentCollection = arguments);
  }

  function deleteTask(id) {
    return call("/tasks/#arguments.id#", "DELETE");
  }

  function updateTask(id, task) {
    return call("/tasks/#arguments.id#", "PUT", arguments.task);
  }

  function createTask(task) {
    return call("/tasks", "POST", arguments.task);
  }

  function activateTask(id) {
    return call("/tasks/#arguments.id#/activate", "POST");
  }  

  /*******************************************
  ** USERS
  *******************************************/
  function getUser(id) {
    return call("/people/#arguments.id#");
  }

  //filter is "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllUsers(filter = {}) {
    arguments.action = "/people";
    return call(argumentCollection = arguments);
  }

  function archiveUser(id) {
    //since the API is a "toggle" let's make sure this people is active now, otherwise we can just return as that's the status quo state.
    var people = getUser(arguments.id);
    if(!people.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The people #people.name# (id: #arguments.id#) is already archived.");
    return call("/people/#arguments.id#/toggle", "POST");
  }

  function reactivateUser(id) {
    //since the API is a "toggle" let's make sure this people is inactive now
    var people = getUser(arguments.id);
    if(people.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The people #people.name# (id: #arguments.id#) is already active.");
    return call("/people/#arguments.id#/toggle", "POST");
  }

  function resetUserPassword(id) {
    return call("/people/#arguments.id#/reset_password", "POST");
  }

  function deleteUser(id) {
    return call("/people/#arguments.id#", "DELETE");
  }

  function updateUser(id, user) {
    return call("/people/#arguments.id#", "PUT", arguments.user);
  }

  function createUser(user) {
    return call("/people", "POST", arguments.user);
  }   

  /*******************************************
  ** USER ASSIGNMENTS
  *******************************************/  

  function getUserAssignmentsForProject(projectid, filter={}){
    var action = "/projects/#arguments.projectid#/user_assignments";
    return call(action = action, filter = arguments.filter);
  }

  function getUserAssignment(projectid, userassignmentid){
    return call("/projects/#arguments.projectid#/user_assignments/#arguments.userassignmentid#");
  }

  //usually we make the developer pass the thing they want to create, but given the simple case here we'll save them some time.
  function assignUser(projectid,userid){
    var user = {"id"=arguments.userid};
    return call("/projects/#arguments.projectid#/user_assignments", "POST", user);
  }

  function removeUserFromProject(projectid,userassignmentid){
    return call("/projects/#arguments.projectid#/user_assignments/#arguments.userassignmentid#", "DELETE");
  }

  function updateUserAssignment(projectid,userassignmentid,userassignment){
    return call("/projects/#arguments.projectid#/user_assignments/#arguments.userassignmentid#", "PUT", userassignment);
  }


  /*******************************************
  ** TASK ASSIGNMENTS
  *******************************************/

  function getTaskAssignmentsForProject(projectid, filter={}){
    var action = "/projects/#arguments.projectid#/task_assignments";
    return call(action = action, filter = arguments.filter);
  }

  function getTaskAssignment(projectid, taskassignmentid){
    return call("/projects/#arguments.projectid#/task_assignments/#arguments.taskassignmentid#");
  }

  //usually we make the developer pass the thing they want to create, but given the simple case here we'll save them some time.
  function assignTask(projectid,taskid){
    var task = {"id"=arguments.taskid};
    return call("/projects/#arguments.projectid#/task_assignments", "POST", task);
  }

  function removeTaskFromProject(projectid,taskassignmentid){
    return call("/projects/#arguments.projectid#/task_assignments/#arguments.taskassignmentid#", "DELETE");
  }

  function updateTaskAssignment(projectid,taskassignmentid,taskassignment){
    return call("/projects/#arguments.projectid#/task_assignments/#arguments.taskassignmentid#", "PUT", taskassignment);
  }

  function createTaskInProject(projectid,taskname){
    var task = {"name"=arguments.taskname};
    return call("/projects/#arguments.projectid#/task_assignments/add_with_create_new_task", "POST", task);
  }

  /*******************************************
  ** EXPENSE CATEGORIES
  *******************************************/
  function getExpenseCategory(id) {
    return call("/expense-category/#arguments.id#");
  }

  //filter can be "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllExpenseCategories(filter = {}) {
    arguments.action = "/expense-category";
    return call(argumentCollection = arguments);
  }

  function archiveExpenseCategory(id) {
    //since the API is a "toggle" let's make sure this expenseCategory is active now, otherwise we can just return as that's the status quo state.
    var expenseCategory = getExpenseCategory(arguments.id);
    if(!expenseCategory.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The expenseCategory #expenseCategory.name# (id: #arguments.id#) is already archived.");
    return call("/expense-category/#arguments.id#/toggle", "PUT");
  }

  function reactivateExpenseCategory(id) {
    //since the API is a "toggle" let's make sure this expenseCategory is inactive now
    var expenseCategory = getExpenseCategory(arguments.id);
    if(expenseCategory.active)
      return;
      //throw(type = makeErrorType("archive"), message = "The expenseCategory #expenseCategory.name# (id: #arguments.id#) is already active.");
    return call("/expense-category/#arguments.id#/toggle", "PUT");
  }

  function deleteExpenseCategory(id) {
    return call("/expense-category/#arguments.id#", "DELETE");
  }

  function updateExpenseCategory(id, expenseCategory) {
    return call("/expense-category/#arguments.id#", "PUT", arguments.expenseCategory);
  }

  function createExpenseCategory(expenseCategory) {
    return call("/expense-category", "POST", arguments.expenseCategory);
  }

  /*******************************************
  ** EXPENSES
  *******************************************/
  function getExpense(id) {
    return call("/expenses/#arguments.id#");
  }

  //filter can be "updated_since" (UTC time eg 2010-09-25+18:30)
  function getAllExpenses(userid = "", filter = {}) {
    arguments.action = "/expenses";
    if(len(trim(userid)) AND NOT structKeyExists(arguments.filter, "of_user"))
      filter.of_user = arguments.userid;
    return call(argumentCollection = arguments);
  }

  function deleteExpense(id) {
    return call("/expenses/#arguments.id#", "DELETE");
  }

  function updateExpense(id, expense) {
    return call("/expenses/#arguments.id#", "PUT", arguments.expense);
  }

  function createExpense(expense, userid = "") {
    return call("/expenses", "POST", arguments.expense, len(trim(arguments.user)) ? {of_user = arguments.userid} : {});
  }  

  function getExpenseReceiptImage(id) {
    return imageNew(call(action = "/expenses/#arguments.id#/receipt", rawresponse = true, getasbinary = true));
  }

  // TODO: upload receipt images


  /*******************************************
  ** REPORTS
  *******************************************/
  function getProjectTimeEntries(required id, required from, required to, user_id, billable, only_billed, only_unbilled, is_closed, updated_since){
    return call(action="/projects/#arguments.id#/entries", filter = makeFilter(argumentCollection=arguments));
  }

  function getUserTimeEntries(required id, required from, required to, project_id, billable, only_billed, only_unbilled, is_closed, updated_since){
    return call(action = "/people/#arguments.id#/entries", filter = makeFilter(argumentCollection=arguments));
  }

  function getUserExpenses(required id, required from, required to, only_billed, only_unbilled, is_closed, updated_since){
    return call(action = "/people/#arguments.id#/expenses", filter = makeFilter(argumentCollection=arguments));
  }

  function getProjectExpenses(required id, required from, required to, only_billed, only_unbilled, is_closed, updated_since){
    return call(action = "/projects/#arguments.id#/expenses", filter = makeFilter(argumentCollection=arguments));
  }

  //TODO: Implement Invoice methods (pull requests welcomed)

  /*******************************************
  ** INTERNAL MACHINERY
  *******************************************/
  //leaving this public to allow raw calls to the API in case someone wants to do it differently than the above implementations or if new methods get added that need to be used before this component is updated.
  function call(action, method = "GET", body, filter = {} , rawresponse = false, getasbinary = false) {
    var connect = getHTTPConnection();
    var preparedBody = "";
    connect.setURL(makeURL(argumentCollection = arguments));
    if(isDefined("arguments.body")) {
      var preparedBody = prepareBody(argumentCollection=arguments);
      connect.addParam(type = "body", value = preparedBody);
    }
    try {
      var httpResponse = connect.send(method = arguments.method, getasbinary = yesNoFormat(arguments.getasbinary));
      connect.tries++;
    }
    //if CF times out that's worth noting as a separate issue, otherwise just pass the error on
    catch("coldfusion.runtime.RequestTimedOutException" err) {
      throw(type = makeErrorType("httpError"), message = "HTTP request to Harvest timed out with action ""#arguments.action#"" and method #arguments.method#");
    }
    catch(any err) {
      rethrow;
    }
    var httpResponseHeaders = httpResponse.getPrefix().ResponseHeader;
    var statusCode = httpResponseHeaders.status_code;
    var fileContent = httpResponse.getPrefix().fileContent;
    //if the status code is 503 we are throttled and need to retry after a wait
    if(statusCode == "503" AND getRetryRequests() & structKeyExists(httpResponseHeaders, "Retry-After")) {
      if(connect.tries GT getRetryCount())
        throw(type = makeErrorType("httpError"), message = "HTTP traffic throttled (503 status more than #getRetryCount()# times in a row)");
      sleep(httpResponseHeaders["Retry-After"] * 1000);
      call(argumentCollection = arguments);
    }
    //if not HTTP status code 200, that's an error
    if(statusCode < 200 OR statusCode > 206)
      throw(  type = makeErrorType("httpError.#statusCode#"),
              message = "HTTP request error with action ""#arguments.action#"" and method #arguments.method#: #statusCode# #httpResponseHeaders.explanation# #structKeyExists(httpResponseHeaders, "hint") ? httpResponseHeaders.hint : ""#",
              detail = "Full URL: #connect.getURL()#  | Body sent: #preparedBody# Full Headers: #httpResponseHeaders.toString()#",
              errorCode = statusCode,
              extendedInfo = serializeJSON(httpResponse.getPrefix())
            );
    //TODO: retry/throttle/etc.
    if(arguments.rawresponse)
      return fileContent;
    //if we get back a LOCATION go to the location -- this usually happens when adding, so we effectively do a GET on the thing created
    if(structKeyExists(httpResponseHeaders, "location")) {
      return call(httpResponseHeaders.location);
    }  
    return parseResponse(fileContent);
  }

  private function parseResponse(response) {
    switch(getFormat()) {
      case "xml": {
        if(!isXML(arguments.response))
          throw(type = makeErrorType("badxml"), message = "Invalid or badly formed XML in response", detail = arguments.response);
        var raw = xmlParse(arguments.response);
        break;
      }
      case "json": {
        if(!isJSON(arguments.response))
          throw(type = makeErrorType("badJSON"), message = "Invalid or badly formed JSON in response", detail = arguments.response);
        var raw = deserializeJSON(arguments.response);
        break;
      }
    }
    //since the API likes to return individual items as nested arrays under a single key we should just get the data out
    if(isStruct(raw) AND structCount(raw) == 1) {
      raw = raw[structKeyArray(raw)[1]];
    }
    return raw;
  }

  private function makeURL(action, filter = {}) {
    return getAPIEndpoint() & arguments.action & "?" & filterToQueryString(arguments.filter);
  }

  private function getAPIEndpoint() {
    return "http" & (getUseSSL() ? "s" : "") & "://" & getSubdomain() & getBaseEndpoint();
  }

  private function filterToQueryString(filter = {}) {
    var qs = "";
    for(key in arguments.filter) {
      qs = listAppend(qs, lcase(key) & "=" & urlEncodedFormat(arguments.filter[key]), "&");
    }
    return qs;
  }

  private function getHTTPConnection() {
    var connection = new http();
    connection.setAttributes(getCommonHTTPAttributes());
    connection.addParam(type = "header", name = "Accept", value = "application/" & getFormat());
    connection.addParam(type = "header", name = "Content-Type", value = "application/" & getFormat() & "; charset = utf-8");
    connection.tries = 0;
    return connection;
  }

  private function getCommonHTTPAttributes() {
    var atts = {} ;
    atts.username = getUsername();
    atts.password = getPassword();
    atts.useragent = getUserAgent();
    atts.redirect = true;
    atts.timeout = 120;
    //TODO: allow it to support a proxy
    return atts;
  }

  private function prepareBody(body, action, method="GET") {
    var rootNodeName = getNounForAction(arguments.action,arguments.method);
    var enrobedBody = {"#rootNodeName#" = arguments.body};
    switch(getFormat()) {
      case "xml": {
        //if(!isXML(arguments.body))
          throw(type = makeErrorType("xmlunsupported"), message = "XML Body currently unsupported!");
      }
      case "json": {
        return serializeJSON(enrobedBody);
      }
    }
  }

  //this is a bit "magical" -- need to think about whether it is too confusing or a real convenience for a developer
  //this is used to "wrap" data in the right root node name, so if we're posting a "user" we don't need to create a nested struct under a single key "user" in the outer struct
  private function getNounForAction(action,method="GET") {
    var raw = listFirst(arguments.action, "/");
    switch(raw) {
      case "people":
        return "user";
      //there are a few times that within a project we are doing assignments, and those require special cases 
      case "projects": {
        if(listLast(arguments.action, "/") == "user_assignments" AND arguments.method == "POST")
          return "user";
        if(listGetAt(arguments.action, 3, "/") == "user_assignments" AND arguments.method == "PUT")
          return "user-assignment";
        if(listLast(arguments.action, "/") == "task_assignments" AND arguments.method == "POST")
          return "task";
        if(listLast(arguments.action, "/") == "add_with_create_new_task" AND arguments.method == "POST")
          return "task";
        if(listGetAt(arguments.action, 3, "/") == "task_assignments" AND arguments.method == "PUT")
          return "task-assignment";
      }
      //by default we just strip off any trailing "s" which accounts for most of the nouns
      default:
        return right(raw, 1) == "s" ? left(raw, len(raw) - 1) : raw;
    }
  }

  private function makeErrorType(type = "") {
    return listAppend("harvestclient", arguments.type, ".");
  }

  private function harvestDateFormat(dateString){
    //if this is a date format it appropriately, otherwise we'll just pass it through
    //TODO: should this have better checking? For now we assume a developer is responsible for this and the API will send a decent error if it's wrong.
    if(isDate(arguments.dateString))
      return dateFormat(arguments.dateString,"YYYYMMDD");
    return arguments.dateString;
  }

  private function makeFilter(){
    var filter = {};
    for(var key in arguments){
      if(structKeyExists(arguments,key))
        filter[key] = arguments[key];
    }
    formatReportFilter(filter);
    return filter;
  }

  private function formatReportFilter(filter){
    for(var key in arguments.filter){
      switch(key){
        case "from":
        case "to":{
          arguments.filter[key] = harvestDateFormat(arguments.filter[key]);
          break;
        }
        case "billable":
        case "only_billed":
        case "only_unbilled":
        case "is_closed":{
          arguments.filter[key] = lcase(yesNoFormat(arguments.filter[key]));
          break;
        }
      }
    }
    return filter;
  }
}