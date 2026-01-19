# Hardcoded admin user - automatically created on application startup
Rails.application.config.after_initialize do
  begin
    # Ensure hardcoded admin user exists
    User.ensure_admin_exists!
  rescue => e
    # Skip during migrations or if database doesn't exist yet
    Rails.logger.debug "Skipping admin creation: #{e.message}"
  end
end
