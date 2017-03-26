class MoipWebhook < ApplicationRecord
  def self.generate_webhook
    webhook = MoipWebhook.where.not(token: nil).first
    return webhook unless webhook.nil?
    webhook = MoipWebhook.create(events: "ORDER.*/PAYMENT.AUTHORIZED/PAYMENT.CANCELLED",
                                 target: 'https://musical-mita.herokuapp.com/webhook/moip')
    webhook.configure_webhook
  end

  def configure_webhook
    moip_client = MoipClient.new
    # As it is not implemented on Moip2 gem, I will make every step that other apis do
    # on the gem.
    cl = moip_client.client
    webhook_response = Moip2::Resource::Webhooks.new(cl, cl.post('/v2/preferences/notifications',
                                                             self.webhook_to_json))
    self.update(token: webhook_response.token, moip_id: webhook_response.id)
  end

  def webhook_to_json
    {
      events: self.events.split('/'),
      target: self.target,
      media: 'WEBHOOK'
    }
  end
end
