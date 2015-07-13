/**
* Readme Spec
*/
component extends="cfselenium.BaseSpec"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		testURL 	= "http://www.ortussolutions.com/products/testbox/";
		selenium 	= new cfselenium.Selenium();
	}

/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "CFSelenium", function(){

			it( "can start a session", function(){
				expect(	selenium.getSessionID() ).toBeEmpty();

		        selenium.start( testURL );
			    
			    expect(	selenium.getSessionID() ).notToBeEmpty();

			});

			it( "can stop a session", function(){
				selenium.stop();
				expect(	selenium.getSessionID() ).toBeEmpty();
			});

			it( "can parse CSV input", function(){
				var input 		= "veni\, vidi\, vici,c:\\foo\\bar,c:\\I came\, I \\saw\\\, I conquered";
				var expected 	= ["veni, vidi, vici", "c:\foo\bar", "c:\i came, i \saw\, i conquered"];
				var results 	= selenium.parseCSV( input );

				debug( results );

				expect(	results ).toBe( expected );
			});
		});
	}
	
}
