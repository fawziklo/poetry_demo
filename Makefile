CMD:= poetry run

info:
	@echo "############################################################################################################"
	@echo "If you're in local, please make sure that you have poetry installed"
	@echo "make pre-install & install are used in CI"
	@echo "make all-dev is a chain of commands: type format lint test"
	@echo "make install : install all dependencies from pyproject.toml"
	@echo "make type: apply type checking"
	@echo "make format: apply black formatting"
	@echo "make lint: apply pylint linting"
	@echo "make test: apply pytest testing & code coverage"
	@echo "make test-cov generate test summary as html report"
	@echo "make clean: clean up by deletion venv file from the project"
	@echo "############################################################################################################"

pre-install:
	pip install poetry

install:
	poetry install

format:
	$(CMD) python -m black --version
	$(CMD) black poetry_demo tests

clean:
	rmdir /s /q venv

type:
	$(CMD) python -m mypy --version
	$(CMD) mypy poetry_demo tests

lint:
	$(CMD) python -m pylint --version
	$(CMD) pylint	--disable=R,C	poetry_demo tests

test:
	$(CMD) python -m pytest --version
	$(CMD) python -m pytest -v --cov=poetry_demo tests

test-cov:
	$(CMD) python -m pytest --version
	$(CMD) python -m pytest -v --cov=poetry_demo tests --cov-report html

all-dev:	type format lint test
all:	install type format lint test
