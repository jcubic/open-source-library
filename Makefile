.PHONY: publish test coveralls lint

VERSION=0.2.0
BRANCH=`git branch | grep '^*' | sed 's/* //'`
DATE=`date -uR`

GIT=git
SED=sed
CAT=cat
RM=rm
TEST=test
ESLINT=./node_modules/.bin/eslint
COVERALLS=./node_modules/.bin/coveralls
JEST=./node_modules/.bin/jest
UGLIFY=./node_modules/.bin/uglifyjs
BABEL=./node_modules/.bin/babel
ROLLUP=./node_modules/.bin/rollup
PERL=/usr/bin/env perl

ALL: Makefile .$(VERSION) dist/lib.js dist/lib.min.js README.md package.json

dist/lib.js: src/main.js .$(VERSION)
	$(ROLLUP) src/main.js -f umd --name 'lib' --o dist/bundle.js
	$(BABEL) dist/bundle.js > dist/babel.js
	$(PERL) -p0i -e 's#/\*.*?\*/##sg' dist/babel.js
	$(CAT) src/banner.js dist/babel.js | $(SED) -e '/^\s*$$/d' > dist/lib.js
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -i -e "s/{{VER}}/DEV/g" -e \
	"s/{{DATE}}/$(DATE)/g" dist/lib.js || $(SED) -i -e \
	"s/{{VER}}/$(VERSION)/g" -e "s/{{DATE}}/$(DATE)/g" dist/lib.js
	$(RM) dist/bundle.js dist/babel.js

dist/lib.min.js: dist/lib.js .$(VERSION)
	$(UGLIFY) -o dist/lib.min.js --comments --mangle -- dist/lib.js

Makefile: templates/Makefile
	$(SED) -e "s/{{VER""SION}}/"$(VERSION)"/" templates/Makefile > Makefile

package.json: templates/package.json .$(VERSION)
	$(SED) -e "s/{{VER}}/"$(VERSION)"/" templates/package.json > package.json

README.md: templates/README.md
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -e "s/{{VER}}/DEV/g" -e "s/{{BRANCH}}/$(BRANCH)/g" -e "s/{{CHECKSUM}}/$(SPEC_CHECKSUM)/" < templates/README.md > README.md || $(SED) -e "s/{{VER}}/$(VERSION)/g" -e "s/{{BRANCH}}/$(BRANCH)/g" -e "s/{{CHECKSUM}}/$(SPEC_CHECKSUM)/" < templates/README.md > README.md

.$(VERSION): Makefile
	touch .$(VERSION)

publish:
	npm publish --access=public

test:
	$(JEST)

coveralls:
	cat ./coverage/lcov.info | $(COVERALLS)

lint:
	$(ESLINT) src/lib.js spec/lib.spec.js
