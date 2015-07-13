/**
* Base Selenium based testing
* Please make sure you call the `beforeAll()` method with the appropriate `browserURL` and `browser` arguments
* The `beforeAll()` method will place an instance of the CFSelenium CFC in the `variables` scope as `selenium`
*/
component extends="testbox.system.BaseSpec"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	/**
	* Please note the two arguments to get a selenium server started
	* @browserURL The base URL of the application to test.
	* @browser The browser to run the tests, defaults to *firefox
	*/
	function beforeAll( required browserURL, browser="*firefox" ){
		// create Selenium class
		variables.selenium = new cfselenium.Selenium();
		// Start it up.
    	variables.selenium.start( arguments.browserURL, arguments.browser );
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		variables.selenium.stop();
		variables.selenium.stopServer()
	}

}