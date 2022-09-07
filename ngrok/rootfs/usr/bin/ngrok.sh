#!/usr/bin/with-contenv bashio
set -e
bashio::log.debug "Building ngrok.yml..."
configPath="/ngrok-config/ngrok.yml"
mkdir -p /ngrok-config
echo "log: stdout" > $configPath

echo "version: 2" >> $configPath

bashio::log.debug "Web interface port: $(bashio::addon.port 4040)"
if bashio::var.has_value "$(bashio::addon.port 4040)"; then
  echo "web_addr: 0.0.0.0:$(bashio::addon.port 4040)" >> $configPath
fi
if bashio::var.has_value "$(bashio::config 'log_level')"; then
  echo "log_level: $(bashio::config 'log_level')" >> $configPath
fi
if bashio::var.has_value "$(bashio::config 'auth_token')"; then
  echo "authtoken: $(bashio::config 'auth_token')" >> $configPath
fi
if bashio::var.has_value "$(bashio::config 'region')"; then
  echo "region: $(bashio::config 'region')" >> $configPath
else
  echo "No region defined, default region is US."
fi
echo "tunnels:" >> $configPath
for id in $(bashio::config "tunnels|keys"); do
  name=$(bashio::config "tunnels[${id}].name")
  echo "  $name:" >> $configPath
  proto=$(bashio::config "tunnels[${id}].proto")
  if [[ $proto != "null" ]]; then
    echo "    proto: $proto" >> $configPath
  fi
  addr=$(bashio::config "tunnels[${id}].addr")
  if [[ $addr != "null" ]]; then
    if [[ $addr =~ ^([1-9]|[1-5]?[0-9]{2,4}|6[1-4][0-9]{3}|65[1-4][0-9]{2}|655[1-2][0-9]|6553[1-5])$ ]]; then
      echo "    addr: 172.30.32.1:$addr" >> $configPath
    else
      echo "    addr: $addr" >> $configPath
    fi
  fi
  inspect=$(bashio::config "tunnels[${id}].inspect")
  if [[ $inspect != "null" ]]; then
    echo "    inspect: $inspect" >> $configPath
  fi
  basic_auth=$(bashio::config "tunnels[${id}].basic_auth")
  if [[ $basic_auth != "null" ]]; then
    echo "    basic_auth: $basic_auth" >> $configPath
  fi
  host_header=$(bashio::config "tunnels[${id}].host_header")
  if [[ $host_header != "null" ]]; then
    echo "    host_header: $host_header" >> $configPath
  fi
  scheme=$(bashio::config "tunnels[${id}].scheme")
  if [[ $scheme != "null" ]]; then
    echo "    scheme: $scheme" >> $configPath
  fi
  subdomain=$(bashio::config "tunnels[${id}].subdomain")
  if [[ $subdomain != "null" ]]; then
    echo "    subdomain: $subdomain" >> $configPath
  fi
  hostname=$(bashio::config "tunnels[${id}].hostname")
  if [[ $hostname != "null" ]]; then
    echo "    hostname: $hostname" >> $configPath
  fi
  crt=$(bashio::config "tunnels[${id}].crt")
  if [[ $crt != "null" ]]; then
    echo "    crt: $crt" >> $configPath
  fi
  key=$(bashio::config "tunnels[${id}].key")
  if [[ $key != "null" ]]; then
    echo "    key: $key" >> $configPath
  fi
  mutual_tls_cas=$(bashio::config "tunnels[${id}].mutual_tls_cas")
  if [[ $mutual_tls_cas != "null" ]]; then
    echo "    mutual_tls_cas: $mutual_tls_cas" >> $configPath
  fi
  remote_addr=$(bashio::config "tunnels[${id}].remote_addr")
  if [[ $remote_addr != "null" ]]; then
    echo "    remote_addr: $remote_addr" >> $configPath
  fi
  metadata=$(bashio::config "tunnels[${id}].metadata")
  if [[ $metadata != "null" ]]; then
    echo "    metadata: $metadata" >> $configPath
  fi
done
configfile=$(cat $configPath)
bashio::log.debug "Config file: \n${configfile}"
bashio::log.info "Starting ngrok..."
ngrok start --config $configPath --all