"use strict";

"use strict";
const fs  = require('fs');
const hbs = require('handlebars');

module.exports = (pCollection) => {
    const tpl = hbs.compile(fs.readFileSync('utl/smurf/scriptReport.hbs', 'utf-8'));

    return tpl({thing: pCollection});
};
