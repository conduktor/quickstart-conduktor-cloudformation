.PHONY: setup-precommit install-hooks install-deps create-venv precommit-all-files

# Alias to set up pre-commit hooks with venv and pip management
setup-precommit: create-venv install-deps install-hooks

# Install pre-commit hooks
install-hooks:
	@echo "Installing pre-commit hooks..."
	pre-commit install
	@echo "Pre-commit hooks installed successfully."


# Install dependencies, supporting virtual environments and checking pip/pip3
install-deps:
	@echo "Detecting whether to use pip or pip3..."
	@if command -v pip3 >/dev/null 2>&1; then \
		echo "pip3 found. Using pip3."; \
		PIP=pip3; \
	elif command -v pip >/dev/null 2>&1; then \
		echo "pip found. Using pip."; \
		PIP=pip; \
	else \
		echo "No pip or pip3 found. Please install pip."; \
		exit 1; \
	fi; \
	echo "Installing pre-commit and cfn-lint with $$PIP..."; \
	$$PIP install pre-commit cfn-lint
	@echo "Dependencies installed successfully."

# Create a virtual environment if it doesn't exist
create-venv:
	@echo "Checking for virtual environment..."
	@if [ ! -d "venv" ]; then \
		echo "No virtual environment found. Creating one..."; \
		python3 -m venv venv; \
		echo "Virtual environment created in ./venv."; \
	fi
	@echo "To activate the virtual environment, run 'source venv/bin/activate' on Linux/Mac or 'venv\\Scripts\\activate' on Windows."

# Run precommit on all files
precommit-all-files:
	@echo "Running precommit on all files"
	pre-commit run --all-files
