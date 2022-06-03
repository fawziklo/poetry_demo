CMD:= poetry run

info:
	@echo "############################################################################################################"
	@echo "First create a venv environment & activate it, next run make all"
	@echo "make all is a chain of commands: install lint format test"
	@echo "make install : install all dependencies of requirements.txt"
	@echo "make format: apply black formatting"
	@echo "make lint: apply pylint linting"
	@echo "make test: apply pytest testing & code coverage"
	@echo "make clean: clean up by deletion venv file from the project"
	@echo "############################################################################################################"

pre-install:
	(Invoke-WebRequest -Uri https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py -UseBasicParsing).Content | python -

install:
	$(CMD) install

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
