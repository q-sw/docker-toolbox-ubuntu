.PHONY: build

build:
	docker build -t mytoolbox:1.0 ${name} ${version} .

