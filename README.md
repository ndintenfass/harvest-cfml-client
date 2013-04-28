Harvest CFML Client
===================

A CFML client for the Harvest API implemented as a single CFC.

You initialize it with your subdomain and a username and password (Harvest recommends creating a separate account for use with the API).


Usage
-------

The CFML client implements most of the Harvest API methods verbatim, with a few additions and modifications mostly for convenience or to be more idiomatic with CFML. For instance, if you want to get all the project for a given client there's a getClientProjects(clientID) method, which internally just calls getAllProjects() and sends a client filter along.

To get started put the harvestclient.cfc file in the appropriate place in your application and instantiate it:

```Javascript
harvestClient = new harvestclient(subdomain, username, password);

- or -

harvestClient = createObject("component", "harvestClient").init(subdomain, username, password);
```

The init variables are accessor-driven properties, so you could alternately do:

```Javascript
harvestclient.setSubdomain("mycompany");
harvestclient.setUsername("foo");
harvestclient.setPassword("bar");
```

Other properties you could set but don't need to (and likely won't) are:

* format (default = "json")
* useSSL (default = true)
* baseEndpoint (default = ".harvestapp.com")
* userAgent (default = "CFML Harvest Client by Hotel Delta (hoteldelta.net)")
* retryRequests (default="false" type="boolean")
* retryCount (default="3")

When a method has a FILTER argument it expects a struct with simple values and will be automatically converted to query string variables in the ultimate API call -- see the API documentation at harvest for what the filter options are in certain circumstances.  In most cases you can filter "updated_since" with a timestamp that looks like: <code>2010-09-25+18%3A30</code>

For update methods and others that take an object you can pass a struct that mimics the name/value pairs the Harvest API expects.  The client will do a little work to wrap that struct into the proper root node and serialize it for you before sending.  You also need not send the entire object when updating, as the API is smart enough to update only the sent fields.  For instance, if you were to retrieve a project and edit one field, then update that same project you might do something like:

```Javascript
project = harvest.getProject(12345);
project.notes = "The new notes for the project go here";
updatedProject = harvest.updateProject(project.id,project);
```

The variable _updatedProject_ in that case contains the entirety of the project with the new data after updating.  This is because the client will automatically get a URL if the Harvest API returns the LOCATION header (which is what happens when adding/updating).

Methods
-------

Below is a full enumeration of the methods available (by category):

### ACCOUNT ISSUES

* whoAmI() 
* getRateLimitStatus()


### PROJECTS

* getProject(id)
* getAllProjects(filter = {})
* getClientProjects(id)
* archiveProject(id)
* reactivateProject(id)
* deleteProject(id)
* updateProject(id, project)
* createProject(project)

### CLIENTS

* getClient(id)
* getAllClients(filter = {})
* archiveClient(id)
* reactivateClient(id)
* deleteClient(id)
* updateClient(id, client)
* createClient(client) 

### CONTACTS

* getContact(id)
* getAllContacts(filter = {})
* getClientContacts(id, filter = {})
* deleteContact(id)
* updateContact(id, contact)
* createContact(contact) 

### TASKS

* getTask(id)
* getAllTasks(filter = {})
* deleteTask(id)
* updateTask(id, task)
* createTask(task) 
* activateTask(id)

### USERS

* getUser(id) 
* getAllUsers(filter = {})
* archiveUser(id)
* reactivateUser(id)
* resetUserPassword(id)
* deleteUser(id)
* updateUser(id, user)
* createUser(user)

### USER ASSIGNMENTS
  
* getUserAssignmentsForProject(projectid, filter={})
* getUserAssignment(projectid, userassignmentid)
* assignUser(projectid,userid)
* removeUserFromProject(projectid,userassignmentid)
* updateUserAssignment(projectid,userassignmentid,userassignment)

### TASK ASSIGNMENTS

* getTaskAssignmentsForProject(projectid, filter={})
* getTaskAssignment(projectid, taskassignmentid)
* assignTask(projectid,taskid)
* removeTaskFromProject(projectid,taskassignmentid)
* updateTaskAssignment(projectid,taskassignmentid,taskassignment)
* createTaskInProject(projectid,taskname)

### EXPENSE CATEGORIES

* getExpenseCategory(id)
* getAllExpenseCategories(filter = {})
* archiveExpenseCategory(id)
* reactivateExpenseCategory(id)
* deleteExpenseCategory(id)
* updateExpenseCategory(id, expenseCategory)
* createExpenseCategory(expenseCategory)

### EXPENSES

* getExpense(id) 
* getAllExpenses(userid = "", filter = {}) 
* deleteExpense(id)
* updateExpense(id, expense)
* createExpense(expense, userid = "")
* getExpenseReceiptImage(id)

### REPORTS

* getProjectTimeEntries(required id, required from, required to, user_id, billable, only_billed, only_unbilled, is_closed, updated_since)
* getUserTimeEntries(required id, required from, required to, project_id, billable, only_billed, only_unbilled, is_closed, updated_since)
* getUserExpenses(required id, required from, required to, only_billed, only_unbilled, is_closed, updated_since)
* getProjectExpenses(required id, required from, required to, only_billed, only_unbilled, is_closed, updated_since)