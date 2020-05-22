PROJECT_IMAGE ?= data_visualization:develop
PROJECT_CONTAINER ?= data_visualization_web_1
CI_COMMIT_SHORT_SHA ?= $(shell git rev-parse --short HEAD)
GIT_STAMP ?= $(shell git describe)

.EXPORT_ALL_VARIABLES:

run: COMPOSE ?= docker-compose -f compose-dev.yml
run: docker-build
	$(COMPOSE) up

mm: COMPOSE ?= docker-compose -f compose-dev.yml
mm: docker-build
	$(COMPOSE) run --name $(CI_COMMIT_SHORT_SHA) web \
	python3 manage.py makemigrations
	$(COMPOSE) stop
	$(COMPOSE) rm -f

docker-build:
	docker build --build-arg version=$(GIT_STAMP) -t $(PROJECT_IMAGE) .

script:
	$(eval SCRIPT ?= $(shell read -p "Script: " SCRIPT; echo $$SCRIPT))
	docker exec -it $(PROJECT_CONTAINER) ./manage.py $(SCRIPT)

rm: COMPOSE ?= docker-compose -f compose-dev.yml
rm:
	$(COMPOSE) stop
	$(COMPOSE) rm -f

clean:
	docker exec -it citizenship_db_1 bash -c "psql -U psql --command='DROP SCHEMA public CASCADE; \
	CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres; GRANT ALL ON SCHEMA public TO psql; \
	GRANT ALL ON SCHEMA public TO public;'" && \
	echo !!!DATABASE SUCCESFULLY CLEANED, PLEASE RESTART SERVER!!!
