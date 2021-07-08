.PHONY=clean deploy teardown

provider_stack_name := custom-resource-provider-test
instance_stack_name := custom-resource-instance-test

bin/resource-provider.template.yml: obj deploy/resource-provider.template.yml
	@mkdir -p bin
	@sam package --template-file deploy/resource-provider.template.yml --s3-bucket ${S3_BUCKET} --output-template-file bin/resource-provider.template.yml

obj:
	@cp -r src obj
	@poetry run pip freeze > obj/requirements.txt
	@poetry run pip install --target=obj --requirement obj/requirements.txt

deploy: bin/resource-provider.template.yml
	@./scripts/deploy.sh $(provider_stack_name) $(instance_stack_name)

teardown:
	@aws cloudformation delete-stack --stack-name $(provider_stack_name)
	@aws cloudformation delete-stack --stack-name $(instance_stack_name)

clean:
	@rm -rf obj bin


