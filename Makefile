.PHONY: publish test coveralls lint

VERSION=0.3.4
BRANCH=`git branch | grep '^*' | sed 's/* //'`
DATE=`date -uR`
SPEC_CHECKSUM=`md5sum spec/lib.spec.js | cut -d' ' -f 1`
COMMIT=`git log -n 1 | grep commit | sed 's/commit //' | tr -d '\n'`

GIT=git
SED=sed
CAT=cat
RM=rm
TEST=test
NPM=npm
ESLINT=./node_modules/.bin/eslint
COVERALLS=./node_modules/.bin/coveralls
JEST=./node_modules/.bin/jest
UGLIFY=./node_modules/.bin/uglifyjs
ROLLUP=./node_modules/.bin/rollup
PERL=/usr/bin/env perl
BUNDLE=$()

ALL: Makefile .$(VERSION) dist/lib.js dist/cjs.js dist/lib.min.js README.md package.json



dist/cjs.js: src/main.js .$(VERSION) rollup.cjs.config.js
	$(ROLLUP) -c rollup.cjs.config.js
	$(PERL) -p0i -e 's#/\*.*?\*/##sg' dist/bundle.js && \
	$(CAT) src/banner.js dist/bundle.js | $(SED) -e '/^\s*$$/d' > dist/cjs.js
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -i -e "s/{{VER}}/DEV/g" -e \
	"s/{{DATE}}/$(DATE)/g" dist/cjs.js || $(SED) -i -e \
	"s/{{VER}}/$(VERSION)/g" -e "s/{{DATE}}/$(DATE)/g" dist/cjs.js
	$(RM) dist/bundle.js

dist/lib.js: src/main.js .$(VERSION) rollup.config.js
	$(ROLLUP) -c
	$(PERL) -p0i -e 's#/\*.*?\*/##sg' dist/bundle.js
	$(CAT) src/banner.js dist/bundle.js | $(SED) -e '/^\s*$$/d' > dist/lib.js
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -i -e "s/{{VER}}/DEV/g" -e \
	"s/{{DATE}}/$(DATE)/g" dist/lib.js || $(SED) -i -e \
	"s/{{VER}}/$(VERSION)/g" -e "s/{{DATE}}/$(DATE)/g" dist/lib.js
	$(RM) dist/bundle.js

dist/lib.min.js: dist/lib.js .$(VERSION)
	$(UGLIFY) -o dist/lib.min.js --comments --mangle -- dist/lib.js

Makefile: templates/Makefile
	$(SED) -e "s/{{VER""SION}}/"$(VERSION)"/" templates/Makefile > Makefile

package.json: templates/package.json .$(VERSION)
	$(SED) -e "s/{{VER}}/"$(VERSION)"/" templates/package.json > package.json

README.md: templates/README.md .$(VERSION)
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -e "s/{{VER}}/DEV/g" -e \
	"s/{{BRANCH}}/$(BRANCH)/g" -e "s/{{CHECKSUM}}/$(SPEC_CHECKSUM)/g" \
	-e "s/{{COMMIT}}/$(COMMIT)/g" < templates/README.md > README.md || \
	$(SED) -e "s/{{VER}}/$(VERSION)/g" -e "s/{{BRANCH}}/$(BRANCH)/g" -e \
	"s/{{CHECKSUM}}/$(SPEC_CHECKSUM)/g" -e "s/{{COMMIT}}/$(COMMIT)/g" < templates/README.md > README.md

.$(VERSION): Makefile
	touch .$(VERSION)

publish:
	$(NPM) publish --access=public

test:
	$(JEST)

coveralls:
	$(CAT) ./coverage/lcov.info | $(COVERALLS)

lint:
	$(ESLINT) src/main.js src/foo.js src/bar.js src/baz.js spec/lib.spec.js
