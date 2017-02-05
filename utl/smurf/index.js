"use strict";

const extractCollection = require("./extractCollection");
const jsonReport        = require('./jsonReport');
const htmlReport        = require('./htmlReport');
const scriptReport      = require('./scriptReport');

const FORMAT2REPORTER = {
    html: htmlReport,
    json: jsonReport,
    scrippie: scriptReport
};

process.stdout.write((FORMAT2REPORTER[process.argv[2]] || htmlReport)(extractCollection()));

/* eslint dot-notation: 0 */
