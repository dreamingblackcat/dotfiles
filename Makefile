.PHONY: build test test-auto clean

build:
	docker compose build

test:
	docker compose run --rm dotfiles-test

test-auto:
	docker compose run --rm dotfiles-test bash /home/chan/dotfiles/test/test-chezmoi.sh

clean:
	docker compose down --rmi local --volumes
