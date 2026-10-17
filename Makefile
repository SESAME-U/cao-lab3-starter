.PHONY: help check init fmt validate plan apply output state test destroy clean

TF = terraform -chdir=infra
# The azurerm provider reads the subscription from this variable.
AZ_SUB = export ARM_SUBSCRIPTION_ID=$$(az account show --query id -o tsv) &&

help:
	@echo "make check      verify the toolbox"
	@echo "make init       download the azurerm provider (terraform init)"
	@echo "make fmt        format the code (terraform fmt)"
	@echo "make validate   check the syntax (terraform validate)"
	@echo "make plan       show what would change in Azure"
	@echo "make apply      create or update the resources in Azure"
	@echo "make output     show the outputs"
	@echo "make state      list what Terraform manages (terraform state list)"
	@echo "make test       run the autograder tests (no Azure needed)"
	@echo "make destroy    delete everything this lab created (do this before you leave)"

check:
	@bash scripts/check.sh

init:
	$(TF) init

fmt:
	terraform fmt -recursive infra

validate:
	$(TF) validate -no-tests

plan:
	@$(AZ_SUB) $(TF) plan $(ARGS)

apply:
	@$(AZ_SUB) $(TF) apply $(ARGS)

output:
	$(TF) output

state:
	$(TF) state list

test:
	$(TF) test

destroy:
	@$(AZ_SUB) $(TF) destroy $(ARGS)

clean:
	rm -rf infra/.terraform
