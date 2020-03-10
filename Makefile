.PHONY: build-image push-image run-image

build-image:
	sudo docker build  --no-cache -t akaesus/swarmedgp .

push-image:
	sudo docker push akaesus/swarmedgp

run-image:
	docker run --rm -it akaesus/swarmedgp
