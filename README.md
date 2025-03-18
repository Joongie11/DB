# Інструкція зі створення нового тому та запуску контейнера MSSQL в Docker

---

## Створення нового тому (Volume)

### Терминал (CLI)

1. Створити том для MSSQL:
   ```bash
   docker volume create mssql-volume
   ```

2. Перевірити, що том створено:
   ```bash
   docker volume ls
   ```
---

## Запуск нового MSSQL контейнера з томом та відкритим портом

### Терминал (CLI)

1. Запустити MSSQL контейнер з підключенням тому:
   ```bash
   docker run --platform linux/amd64 \
     -e 'ACCEPT_EULA=Y' \
     -e 'SA_PASSWORD=12321Qwq!' \
     -p 1433:1433 \
     --name mssql \
     -v mssql-volume:/var/opt/mssql \
     -d mcr.microsoft.com/mssql/server:2019-latest
   ```

2. Перевірити, що контейнер працює:
   ```bash
   docker ps
   ```
---

## Перевірка підключеного тому

1. Перевірити монтування тому:
   ```bash
   docker inspect mssql
   ```

➡У виводі шукаємо секцію:
```
"Mounts": [
    {
        "Type": "volume",
        "Name": "mssql-volume",
        "Destination": "/var/opt/mssql"
    }
]
```

---

## Альтернатива: Docker Desktop (GUI)

### Створити том:
1. Відкрити **Docker Desktop → Volumes**.
2. Натиснути **"Create Volume"**.
3. Назвати том `mssql-volume`.

### Запустити контейнер:
1. Відкрити **Docker Desktop → Containers**.
2. Натиснути **"Run"** → Вибрати образ `mcr.microsoft.com/mssql/server`.
3. Налаштувати:
   - Порт **1433**
   - Том **mssql-volume** ➡ `/var/opt/mssql`

---

## Стоп і видалення контейнера 

```bash
docker stop mssql
docker rm mssql
```

---

## Перезапуск контейнера зі збереженими даними в томі
1. Запустити новий контейнер так само:
   ```bash
   docker run --platform linux/amd64 \
     -e 'ACCEPT_EULA=Y' \
     -e 'SA_PASSWORD=12321Qwq!' \
     -p 1433:1433 \
     --name mssql \
     -v mssql-volume:/var/opt/mssql \
     -d mcr.microsoft.com/mssql/server:2019-latest
   ```

Дані будуть доступні з тому!

---

## Корисні команди
| Опис                  | Команда                                   |
|-----------------------|-------------------------------------------|
| Перевірити образи     | `docker images`                          |
| Перевірити контейнери | `docker ps -a`                           |
| Перевірити томи       | `docker volume ls`                       |
| Перевірити деталі     | `docker inspect mssql`                   |
| Підключитись в MSSQL  | `Azure Data Studio / DataGrip`           |

---

### Додаткові ресурси:
- [Docker Docs](https://docs.docker.com/)
- [MSSQL Server on Docker](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)

---

