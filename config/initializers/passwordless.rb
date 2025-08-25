Passwordless.configure do |config|
  config.after_session_save = lambda do |session, request|
    # Default behavior is
    Rails.logger.info "Attempting to send passwordless email for session: #{session.inspect}"
    Passwordless::Mailer.sign_in(session).deliver_now

    # You can change behavior to do something with session model. For example,
    # SmsApi.send_sms(session.authenticatable.phone_number, session.token)
  end
end
