# grunt-init max-site

My grunt initialization template for new websites.

## Dependencies

- Node.js with npm, bower installed
- Ruby with Sass installed

## Howto

Open the folder you want to insert the template and run:

	$ grunt-init max-site

Then follow the instructions. They’ll ask you to run:

	$ npm install && bower install

Possible grunt tasks:

	// watches for sass,js or html file changes and runs a server at localhost:9000
	$ grunt

	// compiles sass files and concatenates js files
	$ grunt init

	// creates a `dist` folder with optimized assets
	$ grunt deploy

	// runs a server at localhost:9000 from the `dist` folder
	$ grunt dist

