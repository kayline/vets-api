# frozen_string_literal: true
require 'breakers/statsd_plugin'
require 'rx/configuration'
require 'sm/configuration'
require 'mvi/configuration'
require 'hca/configuration'

require 'evss/claims_service'
require 'evss/common_service'
require 'evss/documents_service'
require 'evss/letters/service'

# Read the redis config, create a connection and a namespace for breakers
redis_config = Rails.application.config_for(:redis).freeze
redis = Redis.new(redis_config['redis'])
redis_namespace = Redis::Namespace.new('breakers', redis: redis)

services = [
  Rx::Configuration.instance.breakers_service,
  SM::Configuration.instance.breakers_service,
  MVI::Configuration.instance.breakers_service,
  HCA::Configuration.instance.breakers_service,
  EVSS::ClaimsService.breakers_service,
  EVSS::CommonService.breakers_service,
  EVSS::DocumentsService.breakers_service,
  EVSS::Letters::Service.breakers_service,
  EVSS::GiBillStatus::Service.breakers_service
]

plugin = Breakers::StatsdPlugin.new

client = Breakers::Client.new(
  redis_connection: redis_namespace,
  services: services,
  logger: Rails.logger,
  plugins: [plugin]
)

# No need to prefix it when using the namespace
Breakers.redis_prefix = ''
Breakers.client = client
