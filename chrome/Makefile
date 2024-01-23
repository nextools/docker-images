.PHONY: get-version build test tags

CURRENT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# get-version:
# 	@docker pull ubuntu:bionic > /dev/null 2>&1
# 	@docker run --rm \
# 		ubuntu:bionic \
# 		sh -c "apt-get update --quiet=2 && apt-cache policy chromium-browser | sed --regexp-extended --quiet 's/.*Candidate: ([0-9.]+)-.+/\1/p'"

get-version:
	@echo "120.0.6099.224-1"

build:
	@docker build --tag neuralegion/nextools-chrome --tag 454884832027.dkr.ecr.us-east-1.amazonaws.com/nextools-chrome --build-arg VERSION=$(version) $(CURRENT_DIR)

test:
	@docker run --detach --publish 9222:9222 --name nextools-chrome neuralegion/nextools-chrome
	@timeout 20s sh -c "trap 'docker container rm --force nextools-chrome' 0; until curl http://localhost:9222/json/version; do sleep 1; done"

tags:
	@for i in 3 2 1 0 -1; do \
		if [ $$i -ge 0 ]; then \
			tag=`echo $(version) | sed --regexp-extended "s/(\.[0-9]+){$$i}$$//"`; \
		else \
			tag=latest; \
		fi; \
		echo $$tag; \
		docker tag nextools-chrome neuralegion/nextools-chrome:$$tag; \
		git tag --force nextools-chrome@$$tag; \
	done
