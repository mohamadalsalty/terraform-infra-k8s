# Define variables
TERRAFORM_CMD := terraform
TEST_CMD := test

# Define targets
.PHONY: test

# Run Terraform tests
test:
	$(TERRAFORM_CMD) $(TEST_CMD)
