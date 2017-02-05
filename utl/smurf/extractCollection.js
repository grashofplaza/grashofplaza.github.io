"use strict";

const fs   = require('fs');
const path = require('path');

const SMURFED_FILENAME_RE = /^([^;]+);([^;]+);([^.]+)\.jpg$/;
const CONTENT_DIR         = "src/content";
const BASE_DIR            = "src";

const matches = pPattern => pString => pPattern.test(pString);

const chopName = pPictureString => path.parse(pPictureString).base.match(SMURFED_FILENAME_RE).map(s => s.trim());

const picture2somethingUseful = (pPictureString) => {
    const lChoppedName = chopName(pPictureString);
    const lPath = path.parse(pPictureString);

    return {
        dirname: path.relative(BASE_DIR, path.dirname(pPictureString)),
        picture: path.relative(BASE_DIR, pPictureString),
        thumb: path.relative(BASE_DIR, path.join(lPath.dir, lPath.name.concat("_klein", lPath.ext))),
        title: lChoppedName[2],
        description: lChoppedName[3]
    };
}

const section2pictureArray = pSection => (
    {
        section: pSection.split("_")[1] || pSection,
        pictures: fs.readdirSync(path.join(CONTENT_DIR, pSection))
            .filter(matches(SMURFED_FILENAME_RE))
            .map(pFileName => path.join(CONTENT_DIR, pSection, pFileName))
            .map(picture2somethingUseful)
    }
);

module.exports = () =>
    fs.readdirSync(CONTENT_DIR)
        .filter(
            pThis => fs.statSync(path.join(CONTENT_DIR, pThis)).isDirectory()
        )
        .map(section2pictureArray)
        .filter(p => p.pictures.length > 0);

/* eslint no-magic-numbers: 0 */
