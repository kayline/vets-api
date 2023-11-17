# frozen_string_literal: true

require 'map/sign_up/service'

module TermsOfUse
  class SignUpServiceUpdaterJob
    include Sidekiq::Job

    sidekiq_options unique_for: 2.days
    sidekiq_options retry: 15 # 2.1 days using exponential backoff

    sidekiq_retries_exhausted do |job, exception|
      Rails.logger.warn(
        "[TermsOfUse][SignUpServiceUpdaterJob] Retries exhausted for #{job['class']} " \
        "with args #{job['args']}: #{exception.message}"
      )
    end

    attr_reader :icn, :signature_name, :version

    def perform(icn, signature_name, version)
      @icn = icn
      @signature_name = signature_name
      @version = version

      terms_of_use_agreement.accepted? ? accept : decline
    end

    private

    def accept
      MAP::SignUp::Service.new.agreements_accept(icn:, signature_name:, version:)
    end

    def decline
      MAP::SignUp::Service.new.agreements_decline(icn:)
    end

    def terms_of_use_agreement
      UserAccount.find_by(icn:).terms_of_use_agreements.where(agreement_version: version).last
    end
  end
end
