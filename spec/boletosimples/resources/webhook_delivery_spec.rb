# encoding: UTF-8

require 'spec_helper'

# Before running this spec again, you need to set environment variable BOLETOSIMPLES_ACCESS_TOKEN
RSpec.describe BoletoSimples::WebhookDelivery do
  before {
    BoletoSimples.configure do |c|
      c.application_id = nil
      c.application_secret = nil
    end
  }
  describe 'all', vcr: { cassette_name: 'resources/webhook_delivery/all'} do
    subject { BoletoSimples::WebhookDelivery.all }
    it { expect(subject.first).to be_a_kind_of(BoletoSimples::WebhookDelivery) }
  end
end