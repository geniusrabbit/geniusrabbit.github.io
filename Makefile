HUGO_URI := -tags extended,withdeploy github.com/gohugoio/hugo@v0.128

.GODEPS:
	go install ${HUGO_URI}

.PHONY: build
build: #.GODEPS ## Build application
	CGO_ENABLED=1 go run ${HUGO_URI} --minify
	echo "geniusrabbit.com" > public/CNAME

.PHONY: tidy
tidy: ## Tidy up dependencies
	go mod tidy

.PHONY: run
run: ## Run application
	go run ${HUGO_URI} server --disableFastRender

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
