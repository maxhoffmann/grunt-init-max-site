/*
 * grunt-init-max-site
 *
 * Copyright (c) 2013 Maximilian Hoffmann
 * Licensed under the MIT license.
 */

"use strict";

exports.description = 'Creates a new template for websites';

exports.notes = 'This template includes grunt tasks for compiling sass, optimizing images and livereloading changes.';

exports.after = 'You should now install grunt dependencies with _npm install_ and bower dependencies with __bower install__.';

exports.warnOn = 'Gruntfile.js';
exports.warnOn = 'package.json';
exports.warnOn = '.gitignore';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({type: 'max-site'}, [

    init.prompt('name', 'site'),
    init.prompt('title', 'New Site'),
    {
      name: 'lang',
      message: 'Language (html tag)',
      default: 'en',
      validator: /\w/
    },
    init.prompt('description'),
    init.prompt('version'),
    init.prompt('repository'),
    init.prompt('homepage'),
    init.prompt('author_name'),
    init.prompt('author_email'),
    init.prompt('author_url'),

  ], function(err, props) {

    var files = init.filesToCopy(props);

    init.copyAndProcess(files, props);

    init.writePackageJSON('package.json', {

      name: props.name,
      version: props.version,
      devDependencies: {
        "grunt": "~0.4.1",
        "grunt-contrib-watch": "~0.5.1",
        "grunt-contrib-connect": "~0.3.0",
        "grunt-contrib-clean": "~0.5.0",
        "grunt-contrib-concat": "~0.3.0",
        "grunt-contrib-uglify": "~0.2.2",
        "grunt-contrib-copy": "~0.4.1",
        "grunt-contrib-imagemin": "~0.1.4",
        "grunt-contrib-sass": "~0.4.1",
        "grunt-contrib-coffee": "~0.7.0",
        "connect-livereload": "~0.2.0"
      }

    });

    done();
  });

};
