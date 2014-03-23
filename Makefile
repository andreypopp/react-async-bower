.DELETE_ON_ERROR:
.INTERMEDIATE: react-async.prod.js

BIN = ../node_modules/.bin
PATH := $(BIN):$(PATH)
NAME = ReactAsync
NODE_PATH := ./src/node_modules/:$(NODE_PATH)
TARGETS = \
	react-async.js \
	react-async.min.js

build: $(TARGETS)

react-async.prod.js:
	$(call browserify,production)

react-async.min.js: react-async.prod.js
	@cat $< | uglifyjs -cm > $@

react-async.js:
	$(call browserify,development)

clean:
	@rm -f $(TARGETS)

define browserify
	@mkdir -p $(@D)
	@cat ./shim.begin.js > $@
	@NODE_PATH=$(NODE_PATH) NODE_ENV=$(1)\
		browserify --standalone $(NAME) ./ >> $@
	@cat ./shim.end.js >> $@
endef
