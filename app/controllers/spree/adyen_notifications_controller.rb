module Spree
  class AdyenNotificationsController < AdyenController
    skip_before_action :verify_authenticity_token

    before_action :authenticate

    def notify
      notification = AdyenNotification.build(params)
      begin
        notification.save!
      rescue ActiveRecord::RecordNotUnique
        # Notification is a duplicate, ignore it and return a success.
        accept
      else
        # prevent alteration to associated payment while we're handling the action
        Spree::Adyen::NotificationProcessor.new(notification).process!
        accept
      end
    end

    protected
    # Enable HTTP basic authentication
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["ADYEN_NOTIFY_USER"] &&
          password == ENV["ADYEN_NOTIFY_PASSWD"]
      end
    end

    private
    def accept
      render text: "[accepted]"
    end
  end
end
