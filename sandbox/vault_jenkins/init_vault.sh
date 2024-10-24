#!/bin/sh

# Инициализация Vault
INIT_OUTPUT=$(vault operator init -key-shares=1 -key-threshold=1)

# Извлечение ключа и токена из вывода
UNSEAL_KEY=$(echo "$INIT_OUTPUT" | grep 'Unseal Key 1:' | awk '{print $NF}')
ROOT_TOKEN=$(echo "$INIT_OUTPUT" | grep 'Initial Root Token:' | awk '{print $NF}')

# Размораживание Vault
vault operator unseal "$UNSEAL_KEY"

# Вывод токена для дальнейшего использования
echo "Вывод токена для дальнейшего использования: $ROOT_TOKEN"