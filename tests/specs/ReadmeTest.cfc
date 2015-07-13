/**
* Readme Spec
*/
component extends="cfselenium.BaseSpec"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll( "http://github.com/", "*firefox" );
	}

/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "CFSelenium", function(){

			it( "can open an external readme", function(){
				selenium.open("/Ortus-Solutions/CFSelenium");

				expect(	selenium.getTitle() ).toInclude( "CFSelenium" );
			});

			it( "can navigate and verify", function(){
				selenium.click( "link=readme.md" );
				selenium.waitForPageToLoad( "30000" );			
				sleep( 1000 );

				expect(	selenium.getTitle() ).toInclude( "readme.md" );

				selenium.click( "raw-url" );
				selenium.waitForPageToLoad( "30000" );

				expect(	selenium.getTitle() ).toBeEmpty();
				expect(	selenium.isTextPresent("[CFSelenium]") ).toBeTrue();

			});

		});
	}
	
}