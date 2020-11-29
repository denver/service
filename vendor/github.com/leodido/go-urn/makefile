SHELL := /bin/bash

<<<<<<< HEAD
machine.go: machine.go.rl
	ragel -Z -G2 -e -o $@ $<
	@gofmt -w -s $@
	@sed -i '/^\/\/line/d' $@

.PHONY: build
build: machine.go
=======
build: machine.go

images: docs/urn.png

machine.go: machine.go.rl
	ragel -Z -G2 -e -o $@ $<
	@sed -i '/^\/\/line/d' $@
	@$(MAKE) -s file=$@ snake2camel
	@gofmt -w -s $@

docs/urn.dot: machine.go.rl
	@mkdir -p docs
	ragel -Z -e -Vp $< -o $@

docs/urn.png: docs/urn.dot
	dot $< -Tpng -o $@
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

.PHONY: bench
bench: *_test.go machine.go
	go test -bench=. -benchmem -benchtime=5s ./...

.PHONY: tests
tests: *_test.go machine.go
<<<<<<< HEAD
	go test -race -timeout 10s -coverprofile=coverage.out -covermode=atomic -v ./...
=======
	go test -race -timeout 10s -coverprofile=coverage.out -covermode=atomic -v ./...

.PHONY: clean
clean:
	@rm -rf docs
	@rm -f machine.go

.PHONY: snake2camel
snake2camel:
	@awk -i inplace '{ \
	while ( match($$0, /(.*)([a-z]+[0-9]*)_([a-zA-Z0-9])(.*)/, cap) ) \
	$$0 = cap[1] cap[2] toupper(cap[3]) cap[4]; \
	print \
	}' $(file)
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
