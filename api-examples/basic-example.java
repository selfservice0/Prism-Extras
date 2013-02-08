/**
 * First you need to check for access to prism core. Generally you'll
 * want to do this in the onEnable portion of your plugin.
 */
Plugin _tempPrism = getServer().getPluginManager().getPlugin("Prism");
if (_tempPrism != null) {
	// It exists, so cast it.
	prism = (Prism)_tempPrism;

	/**
	 * Next, you need to build a query parameter example. This
	 * class allows you to define every condition you need
	 * to properly query the database. The query is generated
	 * for you using the same methods Prism uses.
	 *
	 * Check the QueryParameters class for all possible methods.
	 */
	QueryParameters parameters = new QueryParameters();
	parameters.setWorld("world");
	parameters.addActionType(ActionType.BLOCK_BREAK);
	parameters.setLimit(100);

	/**
	 * Next, pass the QueryParameters object to the actions query
	 * system. It will return a QueryResult object that contains
	 * information about the results.
	 */
	ActionsQuery aq = new ActionsQuery(prism);
	QueryResult lookupResult = aq.lookup( parameters );
	if(!lookupResult.getActionResults().isEmpty()){

		/**
		 * Pull the actual results. There's also a getPaginatedActionResults
		 * if you wish to let Prism handle the pagination. However, you must
		 * store the QueryResult object for later use.
		 *
		 * What is returned is a List of Actions.
		 */
		List<Action> results = lookupResult.getActionResults();
		if(results != null){
			for(Action a : results){
				// An example that prints the player name and the action type.
				// full action details will be available to you here.
				System.out.print("Player " + a.getPlayerName() + " caused action " + a.getType().getActionType() );
			}
		}
	}
}

// Example output:
// [INFO] Player viveleroi caused action block-break
// [INFO] Player viveleroi caused action block-break
// [INFO] Player viveleroi caused action block-break
// [INFO] Player viveleroi caused action block-break