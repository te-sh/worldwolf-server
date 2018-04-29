class CleanupRoom
  include Sidekiq::Worker

  def perform
    logger.info 'cleanup room'
  end
end
