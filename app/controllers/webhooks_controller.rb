class WebhooksController < ApplicationController
  def moip
    # Checking only if payment was authorized or cancelled For more complete webhook
    # it would be necessary more complex implementation
    token = request.headers["token"]
    webhook = MoipWebhook.where.not(token: nil).first
    if webhook.token == token
      event = params[:event].split('.').first
      if event == 'PAYMENT'
        @cart = Cart.where(moip_payment_id: params[:resource][:payment][:id]).first
        if params[:resource][:payment][:status] == "AUTHORIZED"
          @cart.paid!
        elsif params[:resource][:payment][:status] == "CANCELLED"
          @cart.cancelled!
        end
      end
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
