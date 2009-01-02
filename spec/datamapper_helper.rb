
Merb::Plugins.config[:merb_mail_queue] = {
  :mail_queue_job_model_class_name => "DMMailQueueJob",
  :adapter                         => :datamapper
}

# An in-memory Sqlite3 connection:
DataMapper.setup(:default, 'sqlite3::memory:')
 
class DMMailQueueJob
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
 
  property :to,         String
  property :from,       String
  property :subject,    String
  property :text,       Text
  property :html,       Text
  
  property :created_at, DateTime, :index => true
  property :updated_at, DateTime
end
DMMailQueueJob.auto_migrate!

def clear_mail_queue
  DMMailQueueJob.all.destroy
end

def create_mail_queue_jobs
  first = DMMailQueueJob.create(
    :to      => "mail@queue.plugins.merbivore.com",
    :from    => "datamapper@queue.plugins.merbivore.com",
    :subject => "Merb Mail queue plugin",
    :text    => "This plugin makes email queueing simpler than before!"
  )
  
  second = DMMailQueueJob.create(
    :to      => "mail@queue.plugins.merbivore.com",
    :from    => "datamapper@queue.plugins.merbivore.com",
    :subject => "Merb Mail queue plugin, take 2",
    :html    => "This plugin for <a href='http://merbivore.com'>Merb</a> works with DataMapper"
  )
  
  [first, second]
end