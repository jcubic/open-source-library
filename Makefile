.PHONY: publish test coveralls lint

VERSION=0.1.0
BRANCH=`git branch | grep '^*' | sed 's/* //'`
DATE=`date -uR`

GIT=git
SED=sed
RM=rm
TEST=test
ESLINT=./node_modules/.bin/eslint
COVERALLS=./node_modules/.bin/coveralls
JEST=./node_modules/.bin/jest
UGLIFY=./node_modules/.bin/uglifyjs
BABEL=./node_modules/.bin/babel


ALL: Makefile .$(VERSION) dist/lib.js dist/lib.min.js README.md package.json

dist/lib.js: src/lib.js .$(VERSION)
	$(GIT) branch | grep '* devel' > /dev/null && $(SED) -e "s/{{VER}}/DEV/g" -e "s/{{DATE}}/$(DATE)/g" src/lib.js > dist/lib.tmp.js || $(SED) -e "s/{{VER}}/$(VERSION)/g" -e "s/{{DATE}}/$(DATE)/g" src/lib.js > dist/lib.tmp.js
	$(BABEL) dist/lib.tmp.js > dist/lib.js
	$(RM) dist/lib.tmp.js

dist/lib.min.js: dist/lib.js .$(VERSION)
	$(UGLIFY) -o dist/lib.min.js --comments --mangle -- dist/lib.js

Makefile: templates/Makefile
	$(SED) -e "s/{{VER""SION}}/"$(VERSION)"/" templates/Makefile > Makefile

package.json: templates/package.json .$(VERSION)
	$(SED) -e "s/{{VER}}/"$(VERSION)"/" templates/package.json > package.json || true

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
