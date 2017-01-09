"use strict";

const extractCollection = require("./extractCollection");
const jsonReport        = require('./jsonReport');
const htmlReport        = require('./htmlReport');
const mkThumbsReport    = require('./mkThumbsReport');

const FORMAT2REPORTER = {
    html: htmlReport,
    json: jsonReport,
    mkThumbs: mkThumbsReport
};

process.stdout.write((FORMAT2REPORTER[process.argv[2]] || htmlReport)(extractCollection()));

/* eslint dot-notation: 0 */
