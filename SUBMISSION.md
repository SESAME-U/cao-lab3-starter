# Lab 3 submission

Fill in every line marked `ANSWER:` (one to three sentences each). Write the answer on the same line, right after `ANSWER:`; for pasted output, add a short summary there and paste the output below. Push before the start of the week 6 session.

## Setup

- Path used (azure, or tests only if you have no working Azure subscription): ANSWER:

## Part B - the first resource

1. After your first `make apply`, you ran `make plan` again. What did it print, and which idea from week 1 does that show?
   ANSWER:

2. You changed the `owner` tag of the resource group with `az group update`. Paste the lines of `make plan` that show the change. What did `make apply` then do?
   ANSWER:

## Part C - the web server

3. In which order did Terraform create the resources, and how did it know that order without you writing it?
   ANSWER:

4. Paste the output of `make output`, and the first line returned by `curl` on your `web_url`. (Tests-only path: paste the summary of `make test` instead.)
   ANSWER:

## Part D - variables and state

5. What does `make plan ARGS="-var vm_size=Standard_D64s_v5"` print? Why is it better to fail here than at `apply`?
   ANSWER:

6. Give two reasons why `terraform.tfstate` must never be committed to Git.
   ANSWER:

## Cleanup

- `make destroy` done and the resource group gone (yes/no): ANSWER:
