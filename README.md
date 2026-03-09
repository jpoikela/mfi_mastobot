# mastobot-integrations

This repository contains the code for the Mielenosoitukset.fi Mastodon bot.

## Setup

### 1. Copy the example configuration file

```bash
cp example.config.yaml config.yaml
```

### 2. Edit the configuration

```bash
nano config.yaml
```

### 3. Create a dedicated system user

```bash
sudo adduser --system --group --home /opt/mastobot mastobot
```

### 4. Create the required directories

```bash
sudo mkdir -p /opt/mastobot/current
sudo mkdir -p /etc/mastobot
sudo mkdir -p /var/log/mastobot
sudo mkdir -p /var/lib/mastobot

sudo chown mastobot:mastobot /opt/mastobot
sudo chown mastobot:mastobot /opt/mastobot/current
sudo chown mastobot:mastobot /etc/mastobot
sudo chown mastobot:mastobot /var/log/mastobot
sudo chown mastobot:mastobot /var/lib/mastobot
```

### 5. Copy the project files

```bash
sudo cp -a . /opt/mastobot/current/
sudo chown -R mastobot:mastobot /opt/mastobot/current
```

### 6. Move the configuration file into place

```bash
sudo mv config.yaml /etc/mastobot/config.yaml
sudo chown mastobot:mastobot /etc/mastobot/config.yaml
```

### 7. Install and start the systemd service (optional)

```bash
sudo cp mastobot.service /etc/systemd/system/mastobot.service
sudo chown root:root /etc/systemd/system/mastobot.service

sudo systemctl daemon-reload
sudo systemctl enable --now mastobot
```

### 8. View logs

```bash
journalctl -u mastobot -f
```

## Directory layout

```
/opt/mastobot/current      -> application code
/etc/mastobot/config.yaml  -> configuration
/var/log/mastobot          -> log files
/var/lib/mastobot          -> persistent data (if needed)
```
