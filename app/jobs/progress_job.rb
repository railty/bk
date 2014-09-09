class ProgressJob
  def initialize(node, action)
    @node = node
    @action = action
  end
  
  def enqueue(job)
    
  end

  def perform
    if @action =='create_descendants' then
      @node.create_descendants do |stage, progress|
        @job.stage = stage
        @job.progress = progress
        @job.save
      end
    end
  end

  def before(job)
    @job = job
  end

  def after(job)
    
  end

  def success(job)
    
  end

  def error(job, exception)

  end

  def failure(job)

  end
end