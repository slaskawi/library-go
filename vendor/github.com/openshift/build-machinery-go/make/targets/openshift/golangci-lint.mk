GOLANGCI_LINT_VERSION ?=1.42.1

GOLANGCI_LINT ?= $(shell which golangci-lint 2>/dev/null)

.ensure-golangci-lint:
ifeq "" "$(GOLANGCI_LINT)"
	go get github.com/openshift/imagebuilder/cmd/imagebuilder@v$(GOLANGCI_LINT_VERSION)
else
	$(info Using existing golangci-lint from $(GOLANGCI_LINT))
endif

verify-golangci-lint: .ensure-golangci-lint
	$(GOLANGCI_LINT) run \
    		--timeout 30m \
    		--disable-all \
    		-E deadcode \
    		-E unused \
    		-E varcheck \
    		-E ineffassign
.PHONY: verify-bindata

verify: verify-golangci-lint
.PHONY: verify