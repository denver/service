GOCMD=GO111MODULE=on go

linters-install:
<<<<<<< HEAD
	$(GOCMD) get -u github.com/alecthomas/gometalinter
	gometalinter --install

lint: linters-install
	gometalinter --vendor --disable-all --enable=vet --enable=vetshadow --enable=golint --enable=maligned --enable=megacheck --enable=ineffassign --enable=misspell --enable=errcheck --enable=goconst ./...
=======
	@golangci-lint --version >/dev/null 2>&1 || { \
		echo "installing linting tools..."; \
		curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh| sh -s v1.21.0; \
	}

lint: linters-install
	golangci-lint run
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92

test:
	$(GOCMD) test -cover -race ./...

bench:
	$(GOCMD) test -bench=. -benchmem ./...

.PHONY: test lint linters-install