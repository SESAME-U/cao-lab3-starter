# Cloud Automation and Orchestration - Lab 3

SESAME University, Computer Engineering, ING5. Week 5: Terraform, part 1.

Until now an `az` script created your VMs, step by step. In this lab you declare the same kind of infrastructure with Terraform: a resource group, a network, a firewall, a public IP and an Ubuntu VM that serves a web page. Then you watch Terraform compare what you declared with what exists, fix drift, and destroy everything with one command.

## Start

1. Open this repository in a Codespace, wait for `Toolbox ready`, run `make check`.
2. `az login --use-device-code`, then `make init`.
3. Follow the Lab 3 handout.

## Files

| Path | What |
| --- | --- |
| `infra/versions.tf`, `infra/providers.tf` | given: Terraform and azurerm versions, provider settings |
| `infra/variables.tf` | three variables given, three to add |
| `infra/main.tf` | your resources |
| `infra/outputs.tf` | three outputs |
| `infra/cloud-init.yaml` | given: installs nginx at first boot |
| `infra/terraform.tfvars.example` | copy to `terraform.tfvars` and set `owner` |
| `infra/tests/` | the autograder's tests: they run without Azure, with a mocked provider |
| `SUBMISSION.md` | answers |

## Grading (10 points, autograded on every push)

| Check | Points |
| --- | --- |
| `terraform fmt`: the code is formatted | 1 |
| `terraform validate`: the configuration is valid | 1 |
| Resources and their settings (`tests/resources.tftest.hcl`) | 3 |
| Variables drive the plan, a large VM is refused (`tests/variables.tftest.hcl`) | 2 |
| Outputs (`tests/outputs.tftest.hcl`) | 1 |
| `SUBMISSION.md` complete | 2 |

The tests never touch Azure: they replace the azurerm provider with a mock. Run them yourself with `make test`.

**Before you leave:** `make destroy`, then stop your Codespace.
