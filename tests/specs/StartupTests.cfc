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

			afterEach(function( currentSpec ){
				selenium.stop();
			});

			it( "can start FireFox", function(){
				selenium.start( testURL, "*firefox" );
			});

			it( "can start Chrome", function(){
				selenium.start( testURL, "*googlechrome" );
			});

			it( 
				title="can start IE", 
				body=function(){
					selenium.start( testURL, "*iexplore" );
				}, 
				skip=function(){
					return ( findNoCase( "windows", server.os.name ) ? false : true );
				}
			);

		});
	}
	
}