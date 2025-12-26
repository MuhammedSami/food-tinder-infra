ifeq (,$(wildcard .env))
  $(info .env not found - creating from .env.example)
  $(shell cp .env.example .env)
endif

include .env
export $(shell sed 's/=.*//' .env)

include db.mk
include build.mk

# Ensure gotestsum is installed
GOTESTSUM := $(shell command -v gotestsum 2> /dev/null)
APP_NAME := FoodTinder

.PHONY: up down restart ps

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

ps:
	docker compose ps