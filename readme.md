# CFSelenium - A Native CFML (ColdFusion) Client Library for Selenium-RC

> This project was forked from Bob Silverberg's project: http://github.com/bobsilverberg/CFSelenium

## What is CFSelenium?

CFSelenium is a ColdFusion Component (CFC) which provides a native client library for Selenium-RC. This allows you to write tests, using CFML, which will drive a browser and verify results via Selenium-RC.

### Requirements

1. [ColdFusion 10+](http://www.coldfusion.com) or [Lucee 4.5+](http://lucee.org)
2. The [Selenium-RC Server jar](http://www.seleniumhq.org/download/), the latest version of which is included in the distribution
3. [TestBox](http://www.ortussolutions.com/products/testbox) for Behavior Driven Development and contributing to our test suite.

### Support

* Please use the main repo's [issue tracker](https://github.com/Ortus-Solutions/CFSelenium/issues) to report bugs and request enhancements.
* You can also use the **TestBox** help group for help: https://groups.google.com/forum/#!forum/coldbox

## Installation 

CFSelenium can be installed via [CommandBox](http://www.ortussolutions.com/products/commandbox) by typing:

```bash
box install cfselenium
```

This will create the following structure under a `cfselenium` folder:

* **formats** : Browser Extensions
* **Selenium-RC** : The Selenium Standalone Java Server
* **BaseSpec.cfc** : The TestBox base specification to use for Selenium driven specs
* **Selenium.cfc** : This nice project CFC
* **Server.cfc** : The driver CFC for the embedded server

**Note:** Optionally if you would like to integrate with [TestBox](http://www.ortussolutions.com/products/testbox) you will have to create a mapping to the `cfselenium` installed folder as `/cfselenium`.

### Contributing

If you want to contribute to this project, please make sure you clone it from here: https://github.com/Ortus-Solutions/CFSelenium/.  You will need [CommandBox](http://www.ortussolutions.com/products/commandbox) in order to do development, so once installed and cloned, just type:

```bash
box install && box server start
```

In the root of the clone and all the required dependencies will be installed and you can contribute to the project.  An embedded server will also be started so you can execute the tests and develop.

## Usage

Optionally, start the Selenium-RC server.  `Selenium.cfc` will automatically start the Selenium-RC server for you in the background if it isn't already started. To start it manually, the command is similar to this:

```bash
java -jar selenium-server-standalone-2.46.0.jar
```

Create an instance of selenium.cfc.

```js
selenium = new Selenium();
```

You can also pass the **host** and **port** into the constructor, which default to `localhost` and `4444`:

```js
selenium = new Selenium( "localhost", 4444 );
```

To start up a browser, call `selenium.start()` passing in the starting URL and, optionally, a browser command telling it which browser to start (the default is `*firefox`):

```
selenium.start( "http://github.com/" );
```

To start a different browser (e.g., Google Chrome), pass in the browser command too:

```
selenium.start( "http://github.com/", "*googlechrome" );
```

Call methods on the selenium object to drive the browser and check values.  Most likely you will be using [TestBox](http://www.ortussolutions.com/products/testbox) for driving expectations on these values:

```js
// all your suites go here.
describe( "CFSelenium", function(){

    it( "can open an external readme", function(){
        selenium.open("/Ortus-Solutions/CFSelenium");

        expect( selenium.getTitle() ).toInclude( "CFSelenium" );
    });

    it( "can navigate and verify", function(){
        selenium.click( "link=readme.md" );
        selenium.waitForPageToLoad( "30000" );          
        sleep( 1000 );

        expect( selenium.getTitle() ).toInclude( "readme.md" );

        selenium.click( "raw-url" );
        selenium.waitForPageToLoad( "30000" );

        expect( selenium.getTitle() ).toBeEmpty();
        expect( selenium.isTextPresent("[CFSelenium]") ).toBeTrue();

    });

});
```

You can shut down the browser using the `stop()`` method:

```js
selenium.stop();
```

## TestBox Integration

CFSelenium integrates with [TestBox](http://www.ortussolutions.com/products/testbox) via the `BaseSpec.cfc` that can be found in the root of the project.  Every Spec that you create in which you want to enable CFSelenium for will inherit from this spec, which in turn inherits from the TestBox `BaseSpec` as well.

```
component extends="cfselenium.BaseSpec"{}
```

Then you will have access to our life-cycle methods of `beforeAll` and `afterAll`.  The `beforeAll()` method takes in two arguments in order to setup the Selenium connection.  The `afterAll()` method can be omitted in your concrete spec and it stops the Selenium connection.  

### BeforeAll()

```js
/**
* Please note the two arguments to get a selenium server started
* @browserURL The base URL of the application to test.
* @browser The browser to run the tests, defaults to *firefox
*/
function beforeAll( required browserURL, browser="*firefox" ){}
```

You can then use it in your specs:

```js
/**
* Readme Spec
*/
component extends="cfselenium.BaseSpec"{
    
/*********************************** LIFE CYCLE Methods ***********************************/

    // executes before all suites+specs in the run() method
    function beforeAll(){
        super.beforeAll( "http://github.com/", "*firefox" );
    }

}
```

### A Selenium-IDE Formatter Too ###

Also included in the distribution is a Firefox extension which will add a formatter to Selenium-IDE which will allow you to export tests in CFSelenium / MXUnit format. The plugin can be found in the _formats_ folder.